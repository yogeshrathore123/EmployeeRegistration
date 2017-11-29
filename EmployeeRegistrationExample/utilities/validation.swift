//
//  validation.swift
//  EmployeeRegistrationExample
//
//  Created by Yogesh Rathore on 27/11/17.
//  Copyright © 2017 Yogesh Rathore. All rights reserved.
//

import Foundation

func validatemobile(_ value: String) -> Bool {
    let PHONE_REGEX = "[0-9]{10}";
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}

func isValidEmail(_ testStr:String) -> Bool
{
    
    let emailRegEx = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
    let range = testStr.range(of: emailRegEx, options:.regularExpression)
    let result = range != nil ? true : false
    return result
    
}



//func validtxtspace(txtfield: UITextField) -> Bool {
//    guard let text = txtfield.text,
//        !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
//            // this will be reached if the text is nil (unlikely)
//            // or if the text only contains white spaces
//            // or no text at all
//            return false
//    }
//    
//    return true
//}

