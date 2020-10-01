//
//  UIAlertController+Extension.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

extension UIAlertController{
    /// Show Basic alert
    /// - Parameters:
    ///   - title: titile alert
    ///   - message: message alert
    ///   - vc: view controller to show alert
    static func basicAlert(title: String?, message: String?, vc: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    /// Show basic alert
    /// - Parameters:
    ///   - title: title alert
    ///   - message: message alert
    ///   - buttonTitle: button title
    ///   - vc: view controller to show alert
    ///   - completion: called as an aciton of the ok button
    /// - Returns: void
    static func basicAlertWithCompletion(title: String?, message: String?, buttonTitle: String?, vc: UIViewController, completion: @escaping (Bool) -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle ?? "OK", style: .default) { (_) in
            completion(true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}


