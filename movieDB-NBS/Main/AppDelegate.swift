//
//  AppDelegate.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let dependecies = DependencyContainer(networkService: AlamofireNetworkingService())
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupFirstScreen()
        
        return true
    }
    
    
    
    // MARK: - Core Data
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "movieDB-NBS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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


