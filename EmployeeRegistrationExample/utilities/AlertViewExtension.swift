//
//  AlertViewExtension.swift
//  EmployeeRegistrationExample
//
//  Created by Yogesh Rathore on 29/11/17.
//  Copyright © 2017 Yogesh Rathore. All rights reserved.
//

import Foundation
import UIKit


//MARK: UIViewController Extensions

//extension UIViewController {
//
//    func showAlert(_ message: String) {
//        showAlert(message, andTitle: "")
//    }
//
//    func showAlert(_ message: String, andTitle title: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//        // add an action (button)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//    }
//}

extension UIViewController {
    func AlertShow(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
