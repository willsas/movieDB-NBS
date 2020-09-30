//
//  AppDelegate.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let dependecies = DependencyContainer(networkService: AlamofireNetworkingService())
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupFirstScreen()
        
        return true
    }
    
    

}


// MARK: - PRIVATE FUNCTION
extension AppDelegate{
    
    
    /// Setup first screen of an app
    private func setupFirstScreen(){
        let initialViewController: UIViewController = dependecies.makeMainTabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.switchRootViewController(initialViewController)
        window?.makeKeyAndVisible()
    }
    
}

