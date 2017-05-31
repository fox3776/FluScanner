//
//  ChageStatusViewController.swift
//  QRReaderDemo
//
//  Created by taohanyao on 2017/5/20.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import Alamofire

class ChageStatusViewController: UIViewController {

    @IBOutlet weak var PatientID: UILabel!
    @IBOutlet weak var SwabID: UILabel!
    @IBOutlet weak var CurrentStatus: UILabel!
    @IBOutlet weak var ChangeStatus: UISegmentedControl!
    
    @IBOutlet weak var modified_on: UILabel!
    @IBAction func ChangeStatus(_ sender: Any) {
        
        let parameters: Parameters = [
            "t_swab": SwabID.text!,
            "status": ChangeStatus.titleForSegment(at: ChangeStatus.selectedSegmentIndex)!
        ]
        let headers: HTTPHeaders = [
            "Authorization": apiKey!
        ]
        
        
        Alamofire.request(ipAddress + "createSwabStatus", method: .post, parameters: parameters, headers:headers)
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
                
                
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    let error = JSON["error"] as! Bool
                    changeSt = false
                    if !error
                    {
                        print("success")
                        //self.performSegue(withIdentifier: "toMain", sender:nil)
                        let msg = "Update success!"
                        let alert = UIAlertController(title: " Update Success", message: msg,preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { Void in
                            self.dismiss(animated: false, completion: nil)
                            self.navigationController?.popViewController(animated: true)
                        }))
                        
                        self.present(alert, animated: true)
                    }
                    else{
                        print("fail")
                        let msg = "Update failed!"
                        let alert = UIAlertController(title: " Update Fail", message: msg,preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { Void in
                            self.dismiss(animated: false, completion: nil)
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true)
                        //                        let maincontrol = MainViewController()
                        //                        self.present(maincontrol, animated: true, completion: nil)
                    }
                    
                }
                
                
        }
        
    }
    
    
    override func willMove(toParentViewController parent: UIViewController?)
    {
        if parent == nil
        {
            changeSt = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()

        // Do any additional setup after loading the view.
    }
    
    func setInfo() {
        var parameters: Parameters = [
            "patient_id": patientID
        ]
        let headers: HTTPHeaders = [
            "Authorization": apiKey!
        ]
        self.PatientID.text = String(patientID)
        Alamofire.request(ipAddress + "swabPatient", method: .post, parameters: parameters, headers:headers)
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
                    let t_swab = JSON["t_swab"] as? String
                    self.SwabID.text = t_swab
                    parameters = [
                        "t_swab": Int(t_swab!)!
                    ]
                    
                    Alamofire.request(ipAddress + "currentSwabStatus", method: .post, parameters: parameters, headers:headers)
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
                                let status = JSON["status"] as? String
                                let modified_on = JSON["modified_on"] as? String
                                self.CurrentStatus.text = status
                                self.modified_on.text = modified_on
                            }
                    }
                    
                    ///
                    
                    
                }
        }
        
        
        
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
