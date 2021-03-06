//
//  FMInitialisationViewController.swift
//  Liste
//
//  Created by Arash on 26/09/20.
//  Copyright © 2020 Apprendre. All rights reserved.
//

import UIKit
import MSCircularSlider
import Hero

class FMInitialisationViewController: UIViewController, MSCircularSliderDelegate {

    // MARK: Outlets
    @IBOutlet weak var timerCircularSlider: MSCircularSlider!
    @IBOutlet weak var timeLabel: UILabel!

    // MARK: Properties
    var focusTime: Double = 0.0
    var tasks: [Task] = []
    var task: Task?
    var row: Int?

    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        self.timerCircularSlider.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "start" {
            let destination = segue.destination as! FMPreflightViewController
            destination.hero.modalAnimationType = .slide(direction: .left)
            destination.focusTime = self.focusTime
            destination.tasks = self.tasks
            destination.task = self.task!
            destination.row = self.row!
        }
    }

    // MARK: Circular Slider Protocols
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        // Gets the value from the circular slider and updates the label's value of the time set.
        let time = Int(round(value))
        let hours = Int(time / 60)
        let minutes = time - (hours * 60)
        var string = ""

        if hours > 1 {
            string = "\(hours) \(NSLocalizedString("hours", comment: "Plural form of hour."))"
        } else if hours == 1 {
            string = "\(hours) \(NSLocalizedString("hour", comment: "Singular form of hour."))"
        } else {
            string = ""
        }

        if minutes == 1 {
            string += " \(minutes) \(NSLocalizedString("minute", comment: "Singular form of minute."))"
        } else if minutes > 1 {
            string += " \(minutes) \(NSLocalizedString("minutes", comment: "Plural form of minute."))"
        }

        self.timeLabel.text = string
        self.focusTime = Double(time)
    }

    // MARK: Actions
    @IBAction func startButton(_ sender: ListeButton) {
        if focusTime > 0 {
            self.performSegue(withIdentifier: "start", sender: nil)
        }
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
