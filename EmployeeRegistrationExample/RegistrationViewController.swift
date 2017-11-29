//
//  RegistrationViewController.swift
//  EmployeeRegistrationExample
//
//  Created by Yogesh Rathore on 27/11/17.
//  Copyright © 2017 Yogesh Rathore. All rights reserved.
//

import UIKit
import WebKit
import MobileCoreServices
import FSCalendar

class RegistrationViewController: UIViewController, UITextFieldDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, UINavigationControllerDelegate, FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNmaeTxtfield: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var mobileTxtField: UITextField!
    @IBOutlet weak var dobTxtField: UITextField!
    @IBOutlet weak var uploadresumeBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    var backView = UIView()
    
    var uploadResumePath: URL!
    fileprivate weak var calendar: FSCalendar!
    var dobstring = String()
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Registration"
        
        // Do any additional setup after loading the view.
        addDoneButton(text: self.mobileTxtField)
        let screenSize: CGRect = UIScreen.main.bounds
        backView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        backView.isHidden = true
        backView.backgroundColor = UIColor.lightGray
        self.view.addSubview(backView)
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        backView.addSubview(calendar)
        self.calendar = calendar
        
       // calendar.isHidden = false
       
        

       
    }
    @IBAction func calshow(_ sender: Any) {
        self.view.endEditing(true)
        
        firstNameTxtField.endEditing(true)
        lastNmaeTxtfield.endEditing(true)
        emailTxtField.endEditing(true)
        mobileTxtField.endEditing(true)
        dobTxtField.endEditing(true)
        
        
    }
    
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        print("did select date \(self.dateFormatter.string(from: date))")
        dobstring = self.dateFormatter.string(from: date)
        dobTxtField.text = dobstring
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
       // calendar.isHidden = true
        backView.isHidden = true
       
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    @IBAction func uploadresumeBtnAction(_ sender: Any) {
         self.view.endEditing(true)

        // Open file container
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }

    @IBAction func submitBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        if firstNameTxtField.text?.isEmpty == true {
            AlertShow(title: "Please enter the first name", message: "")
        }else if lastNmaeTxtfield.text?.isEmpty == true{
             AlertShow(title: "Please enter the last name", message: "")
        }else if emailTxtField.text?.isEmpty == true{
             AlertShow(title: "Please enter the email id", message: "")
        }else if isValidEmail(emailTxtField.text!) == false {
             AlertShow(title: "Please enter the valid email id", message: "")
        }else if mobileTxtField.text?.isEmpty == true{
             AlertShow(title: "Please enter the mobile number", message: "")
        }else if validatemobile(mobileTxtField.text!) == false {
             AlertShow(title: "Please enter the valid mobile number", message: "")
        }else if dobTxtField.text?.isEmpty == true {
             AlertShow(title: "Please select the dob", message: "")
        }else if uploadResumePath == nil {
            AlertShow(title: "Please upload the resume", message: "")
        }else{
        
            let alert = UIAlertController(title: "Congratulation", message: "Registration successfull", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                UIAlertAction in
                self.submitReq()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
      
    }
    
    func submitReq() {
        let nextController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewControllerID") as! DetailViewController
        nextController.firstnameStr = firstNameTxtField.text!
        nextController.lastNameStr = lastNmaeTxtfield.text!
        nextController.emailStr = emailTxtField.text!
        nextController.mobileStr = mobileTxtField.text!
        nextController.dobStr = dobTxtField.text!
        nextController.urlString = uploadResumePath
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    // ********************** Document Picker ************************** //
    @available(iOS 8.0, *)
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        uploadResumePath = url as URL
        print("The Url is : \(uploadResumePath!)")
        print(uploadResumePath.lastPathComponent)
        uploadresumeBtn.setTitle(uploadResumePath.lastPathComponent, for: .normal)
        
    }
    
    @available(iOS 8.0, *)
    public func documentMenu(_ documentMenu:     UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
        
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("we cancelled")
        dismiss(animated: true, completion: nil)
        
    }
    
    // ************************************************************* //
    
    /// Add Custom Done Button Mobile TextField
    ///
    /// - Parameter text: pass the textField name
    func addDoneButton(text : UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        text.keyboardType = UIKeyboardType.numberPad
        text.inputAccessoryView = keyboardToolbar
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == dobTxtField){
            
//            let calendar = FSCalendar(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 300))
//            calendar.dataSource = self
//            calendar.delegate = self
//            view.addSubview(calendar)
//            self.calendar = calendar
//
//            calendar.isHidden = false
            backView.isHidden = false

        }

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    /// Textfield Delegate method
    ///
    /// - Parameters:
    ///   - textField: firstNameTxtField,lastNmaeTxtfield,mobileTxtField
    ///   - range: checking validation
    ///   - string:
    /// - Returns: true
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == firstNameTxtField {
            if string.isEmpty {
                return true
            }
            let alphaNumericRegEx = "[a-zA-Z]"
            let predicate = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegEx)
            return predicate.evaluate(with: string)
        }else if textField == lastNmaeTxtfield {
            if string.isEmpty {
                return true
            }
            let alphaNumericRegEx = "[a-zA-Z]"
            let predicate = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegEx)
            return predicate.evaluate(with: string)
        }else if textField == mobileTxtField
        {
            guard let text = mobileTxtField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 10
        }
        
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
