# Listé – Productivity Made Easy

## Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Support](#support)
- [What's Ahead](#whats-ahead)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)
- [License](#license)

## Introduction
Welcome to **Listé**, a simple and open-sourced to-do list app for everyone.

Whether you're a developer or user using the app, I'd love to add on the number of parties involved in this project. I plan to cater to all; however, I'm only focusing on developing the app in this current point in time. If you're a developer and wish to contribute, check out the [Getting Started](#getting-started) section below.

## Getting Started
Thanks for your interest in trying out this project! To begin, check out the [Contributing Guide](CONTRIBUTING.md) to see what you have to do, including general rules-of-thumb that I recommend you to follow.

If you'd like to try out this project on your end, let's get started!

### Setting Up

> **Warning!**
>
> Listé may take a long time to compile and build due to the number of libraries it depends on (most notably, Firebase). You may notice that your computer may be abnormal while compiling for the first time.

- [Direct clone/download](#direct-clone/download)
- [Cloning via Xcode](#cloning-via-xcode)

## Direct clone/download
1. Clone or download this project and save it somewhere accessible. If downloaded, unzip the file before you continue.
2. Head over to the [Firebase console](https://console.firebase.google.com) and create a Firebase project. Follow all onboarding instructions.
> Note: Do also enable **Authentication** and **Database** (Cloud Firestore)!
>
> Sub note: This project uses Cloud Firestore. If you'd like to make it into a Realtime Database project, please do so at your discretion!
3. Add an iOS app to your project and follow all instructions. Download the `GoogleService-Info.plist` file and place it in `Liste/Liste/`.

*Optional, but just in case:*

4. Install Cocoapods on your device by using `sudo gem install cocoapods` in Terminal.
5. Navigate to the Xcode folder of Liste (`Liste/Liste/`).
6. Enter `pod install` in Terminal.

## Cloning via Xcode
1. Open Xcode and select "Clone an existing project".
2. Enter `https://github.com/arashnrim/Liste.git` in the text field.
3. Select Clone and choose the branch `dev` to checkout to.
4. Save the project somewhere accessible.
5. Head over to the [Firebase console](https://console.firebase.google.com) and create a Firebase project. Follow all onboarding instructions.
> Note: Do also enable **Authentication** and **Database** (Cloud Firestore)!
>
> Sub note: This project uses Cloud Firestore. If you'd like to make it into a Realtime Database project, please do so at your discretion!
6. Add an iOS app to your project and follow all instructions. Download the `GoogleService-Info.plist` file and place it in `Liste/Liste/`.

*Optional, but just in case:*

7. Install Cocoapods on your device by using `sudo gem install cocoapods` in Terminal.
8. Navigate to the Xcode folder of Liste (`Liste/Liste/`).
9. Enter `pod install` in Terminal.

### Using the Xcode Project
- Always use `Liste.xcworkspace` instead of `Liste.xcodeproj`. The `xcworkspace` file has all the Cocoapods libraries installed.
- If not added, add your own `GoogleService-Info.plist` file into the Xcode project.
- It is recommended that you **change the bundle ID and development team** of your project to avoid conflicts with the original project.

### Contributing After
- Ensure that your `GoogleService-Info.plist` is not part of your commits/pull requests to ensure the security of your Firebase project and stability of the original project.
    - The `.gitignore` file should've managed this for you, but do check manually as well before making changes.

## Support
If you need help with anything related to the project, I recommend opening a new issue in the Issue Tracker page. Following GitHub's [Open Source Guide](https://www.opensource.guide), it is strongly advised against privately communicating.

## What's Ahead
Listé is an existing project, and subsequently a version 1.0 (latest 1.0.3) exists. While the App Store contains the app, the app is currently unusable at this point as I'm rewriting the code. Here's what I plan for the next few versions, starting from version 1.1.0:

Listé 1.1.0
- Reintroduced user interface. I've taken the design of version 1.0 and redesigned the interface a little, making the app more usable and available to more features.

Listé 1.2.0
- Collaborative Lists. A simple, innovative way to share a List with people.
- Local storage. Version 1.0 emphasises a mostly online structure, unnecessarily using data to sync with the online database (Firebase). In the new version, I'm only making Collaborative Lists (a new feature) store data online; everything else uses UserDefaults or other forms of local storage.

## Contributing
Please review our [Contributing Guide](CONTRIBUTING.md) for detailed elaborations of the how and what to contribute.

This project is **accepting contributions**. If there's something broken or something you'd like to add, **fork the repository**, **create a branch** and **create a pull request** once you're done working.

## Acknowledgements
I'd want to thank everyone who spends their time and effort in contributing to this project. Eventually, you'll see that your efforts made something worth.

## License
This project uses the [MIT](https://spdx.org/licenses/MIT.html) license.