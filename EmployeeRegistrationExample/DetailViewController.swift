//
//  DetailViewController.swift
//  EmployeeRegistrationExample
//
//  Created by Yogesh Rathore on 27/11/17.
//  Copyright © 2017 Yogesh Rathore. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNmaeLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    
    //var urlString:String! = ""
    var urlString: URL!
    var firstnameStr = String()
    var lastNameStr = String()
    var emailStr = String()
    var mobileStr = String()
    var dobStr = String()
    
    var activityView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.title = "Detail"
        // Do any additional setup after loading the view.
        firstNameLbl.text = firstnameStr
        lastNmaeLbl.text = lastNameStr
        emailLbl.text = emailStr
        mobileLbl.text = mobileStr
        dobLbl.text = dobStr
        webView.delegate = self
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.center = self.view.center
        self.webView.addSubview(activityView)
        
        let request = URLRequest(url: urlString)
        self.webView.loadRequest(request)
    }
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      //  let fileURL = URL(fileURLWithPath: self.urlString)
     //   let fileURL = URL(fileURLWithPath: self.urlString)
       
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        activityView.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        activityView.stopAnimating()
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
