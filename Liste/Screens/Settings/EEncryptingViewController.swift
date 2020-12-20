//
//  EEncryptingViewController.swift
//  Liste
//
//  Created by Arash on 20/12/20.
//  Copyright © 2020 Apprendre. All rights reserved.
//

import UIKit
import Firebase
import RNCryptor

class EEncryptingViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        statusLabel.text = "Connecting to database..."
        let database = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Warning: No authenticated user is found; attempting to recover by redirection.")
            self.showReauthenticationAlert()
            return
        }
        statusLabel.text = "Retrieving data..."
        database.document("users/\(userID)").getDocument { (snapshot, error) in
            if let error = error {
                print("Error (fetching from Firebase database): \(error.localizedDescription)")
                self.displayAlert(title: "Uh oh.", message: error.localizedDescription, override: nil)
            } else {
                if let snapshot = snapshot {
                    let data = snapshot.data()
                    if let data = data {
                        self.statusLabel.text = "Encrypting data..."
                        let encryptedData = self.encryptData(unencryptedData: data)

                        self.statusLabel.text = "Uploading changes..."
                        self.updateDatabase(encryptedData: encryptedData)
                    } else {
                        print("Warning: The snapshot data appears to be empty.")
                    }
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "complete" {
            let destination = segue.destination
            destination.hero.modalAnimationType = .uncover(direction: .down)
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    func encryptData(unencryptedData: [String: Any]) -> [String: Any] {
        guard let password = UserDefaults.standard.string(forKey: "masterPassword") else { return [:] }

        var encryptedData = [String: Any]()
        for item in unencryptedData {
            if let value = item.value as? String {
                guard let valueData = value.data(using: .utf8) else { return [:] }
                let cipheredData = RNCryptor.encrypt(data: valueData, withPassword: password)
                encryptedData[item.key] = cipheredData
            } else {
                if item.key == "tasks" {
                    if let tasks: [String: Any] = item.value as? [String: [String: Any]] {
                        var encryptedTasks = [String: Any]()
                        for task in tasks {
                            var encryptedTask = [String: Any]()
                            let details = task.value as! [String: Any]
                            // Encrypts the task name and description.
                            for detail in details {
                                if detail.key == "taskName" || detail.key == "description" {
                                    if let value = detail.value as? String {
                                        guard let valueData = value.data(using: .utf8) else { return [:] }
                                        let cipheredData = RNCryptor.encrypt(data: valueData, withPassword: password)
                                        encryptedTask[detail.key] = cipheredData
                                    }
                                } else {
                                    encryptedTask[detail.key] = detail.value
                                }
                            }
                            encryptedTasks[task.key] = encryptedTask
                        }
                        encryptedData["tasks"] = encryptedTasks
                    }
                } else {
                    encryptedData[item.key] = item.value
                }
            }
        }
        return encryptedData
    }

    func updateDatabase(encryptedData: [String: Any]) {
        let database = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Warning: No authenticated user is found; attempting to recover by redirection.")
            self.showReauthenticationAlert()
            return
        }

        database.document("users/\(userID)").updateData(encryptedData) { (error) in
            self.statusLabel.text = "Finishing..."
            if let error = error {
                self.displayAlert(title: "An error occurred.", message: "Something went wrong when encrypting your data: \(error.localizedDescription). Encryption will terminate.") { (alert) in
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.performSegue(withIdentifier: "complete", sender: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                self.displayAlert(title: "Encryption successful.", message: "Your data is now encrypted and more secure.") { (alert) in
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.performSegue(withIdentifier: "complete", sender: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}