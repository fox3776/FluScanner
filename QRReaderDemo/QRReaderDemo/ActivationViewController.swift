//
//  ActivationViewController.swift
//  QRReaderDemo
//
//  Created by taohanyao on 2017/5/5.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import Alamofire
import OnOffButton
var apiKey : String? = "84caef1c00f210e7afbd0e178554153b"

class ActivationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var inputActivationCode: UITextField!
    @IBOutlet weak var ActiveButton: UIButton!
    var activeField: UITextField?
    var window : UIWindow?
    

    
    @IBAction func activation(_ sender: OnOffButton) {
        sender.checked = !sender.checked
        let deviceUUID = UIDevice.current.identifierForVendor!.uuidString
        let parameters: Parameters = [
            "code": inputActivationCode.text!,
            "mac": deviceUUID
            ]
        Alamofire.request(ipAddress + "activateMac", method: .post, parameters: parameters)
            .responseJSON { response in
                
                
            //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(result)
                    let error = JSON["error"] as! Bool
                    print(error)
                    if !error {
                        apiKey = JSON["apiKey"] as? String
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(true, forKey: "isActived")
                        print("actived!")
                        guard let rootViewController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController else {
                            return
                        }
                        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                        let navMainVC = UINavigationController(rootViewController: mainVC)
                        navMainVC.setNavigationBarHidden(false, animated: false)
//                        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "viewvc") as! ViewController
//                        self.navigationController?.pushViewController(tabVC, animated: true)
                        rootViewController.present(navMainVC, animated: true, completion: nil)


                    }
                    else{
                        
                        let msg = "Please check your activation code!"
                        let alert = UIAlertController(title: " Activation Failed", message: msg,preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { Void in
                            self.dismiss(animated: false, completion: nil)
                        }))
                        self.present(alert, animated: true)
                        return
                    }
                    
                }
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
        
        let tapper = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        tapper.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapper)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                                         name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                                         name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(_ notification: Notification) {
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        if let _ = activeField
        {
            if (!aRect.contains(activeField!.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    
    func tap(_ sender:AnyObject) {
        self.view.endEditing(true)
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
