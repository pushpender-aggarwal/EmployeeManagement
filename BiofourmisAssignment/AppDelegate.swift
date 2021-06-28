//
//  AppDelegate.swift
//  BiofourmisAssignment
//
//  Created by Pushpender on 25/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: StoryBoardName.main, bundle: nil)
        
        let viewControllerIdentifier = UserDefaultsLocalStorage().getUserLoginStatusFor() ? ViewControllerIdentifier.employeeList : ViewControllerIdentifier.login
        
        let vc = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        let navigationController = UINavigationController.init(rootViewController: vc)
        self.window?.rootViewController = navigationController

        self.window?.makeKeyAndVisible()
        return true
    }
}

