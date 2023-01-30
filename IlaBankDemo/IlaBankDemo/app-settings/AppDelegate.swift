//
//  AppDelegate.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        /* Create ui-view-controller instance*/
         let list = ListRouter.createModule()

         /* Initiating instance of ui-navigation-controller with view-controller */
         let navigationController = UINavigationController()
         navigationController.viewControllers = [list]

         /* Setting up the root view-controller as ui-navigation-controller */
         window?.rootViewController = navigationController
         window?.makeKeyAndVisible()

        return true
    }
}

