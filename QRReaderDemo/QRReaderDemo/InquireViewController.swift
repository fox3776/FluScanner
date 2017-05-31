//
//  InquireViewController.swift
//  QRReaderDemo
//
//  Created by taohanyao on 2017/4/25.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import Alamofire



class InquireViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet var PatientID: UILabel!

    @IBOutlet var Gender: UILabel!

    @IBOutlet var t_swab: UILabel!
    @IBOutlet var FluInput: UITextField!
    @IBOutlet var TypePickerView: UIPickerView!

    @IBOutlet var Age: UILabel!
//    var maincontrol : MainViewController!
    
    var result = ["Yes","No"]
    var flu : [Int:String] = [:]
    var fluTypes : [String] = []

   
    
    
    @IBAction func UpdateFlu(_ sender: Any) {
        
        guard let swabtext = FluInput.text, (swabtext == "No" || swabtext.hasPrefix("Yes - ")) else {
            let alert = UIAlertController(title: "Error", message: "Swab Result is incorrect.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
       var parameters: Parameters
       let headers: HTTPHeaders = [
            "Authorization": apiKey!
        ]
        let swabValue = FluInput.text?.components(separatedBy: " - ")[0]
        
       if swabValue == "Yes" {
        let swabType = FluInput.text?.components(separatedBy: " - ")[1]
        parameters = [
            "t_swab": instances[0].t_swab!,
            "t_labresult": (self.flu as NSDictionary).allKeys(for: swabType!)[0]
        ]
        }
       else{
        parameters = [
            "t_swab": instances[0].t_swab!,
            "t_labresult": 1
        ]
        }
        
        print(parameters)
        
        Alamofire.request(ipAddress + "swabResult", method: .post, parameters: parameters, headers:headers)
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
                        transfer = false
                    if !error
                    {
                        print("success")
                        history.append(instances[0])
                        print(history.count)
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
                        let alert = UIAlertController(title: " Create Fail", message: msg,preferredStyle: UIAlertControllerStyle.alert)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TypePickerView.selectRow(1, inComponent: 0, animated: true)
        TypePickerView.isHidden = true
        let tapper = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        tapper.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapper)
//        TypePickerView.removeFromSuperview()
        FluInput.inputView = TypePickerView

        setFluType()
        insertinfo()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func tap(_ sender:AnyObject) {
        TypePickerView.isHidden = true
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (component) {
        case 0:
            return result.count
        case 1:
            return flu.count
        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        switch (component) {
        case 0:
            return result[row]
        case 1:
            if FluInput.text?.components(separatedBy: " - ")[0] == "Yes" {
                
                return fluTypes[row]
                
            }
            else{
                return nil
            }
            
        default:
            break
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch (component) {
        case 0:
            FluInput.text = result[row]
            pickerView.reloadComponent(1)
        case 1:
            if FluInput.text?.components(separatedBy: " - ").count==1{
                FluInput.text?.append(" - " + fluTypes[row])
            }
            else{
                FluInput.text = "Yes - " + fluTypes[row]
            }
            
            pickerView.reloadComponent(1)
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //InputFlu.isUserInteractionEnabled = false
        TypePickerView.isHidden = false
         FluInput.text = "No"
        FluInput.endEditing(true)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        if !instances.isEmpty{
            setcontent(instances[0])
        }
    }
    
    func insertinfo()  {
        let parameters: Parameters = [
            "patient_id": patientID
            ]
        let headers: HTTPHeaders = [
            "Authorization": apiKey!
        ]
        

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
                    print("result:  ")
                    print(result)
                    let JSON = result as! NSDictionary

                    //                    print(Any)
                    
                    let patient = Patient()
                    let PatientID = JSON["id"] as? String
                    let t_swab = JSON["t_swab"] as? String
                    let gender = JSON["gender"] as? String
                    let dob = JSON["dob"] as? String
                    
                    
                    patient.PatientID = Int(PatientID!)
                    patient.t_swab = Int(t_swab!)
                    patient.gender = gender
                    patient.dob = dob
                    instances.append(patient)
                    
                    
//                    self.reloadInputViews()
                    
                    
                }
        }
        
    }
    
    func setcontent(_ patient:Patient) {
        self.PatientID.text = String(patient.PatientID!)
        self.Gender.text = patient.gender!
        self.Age.text = patient.dob!
        self.t_swab.text = String(patient.t_swab!)
        
    }
    
    override func willMove(toParentViewController parent: UIViewController?)
    {
        if parent == nil
        {
            transfer = false
            instances.removeAll()
        }
    }

    
    func setFluType(){
        let headers: HTTPHeaders = [
            "Authorization": apiKey!
        ]
        print(apiKey!)
        Alamofire.request(ipAddress + "fluType",headers:headers)
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
                    if !error {
                        let typeResults = JSON["result"] as! [NSDictionary]
                    for i in 0 ..< typeResults.count {
                        if typeResults[i]["id"] as! String != String(1) {
                            self.flu.updateValue(typeResults[i]["name"] as! String, forKey: Int(typeResults[i]["id"] as! String)!)
                            self.fluTypes.append(typeResults[i]["name"] as! String)
                        }
                        
                                                }
                    }
                    
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
