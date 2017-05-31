//
//  MainViewController.swift
//  QRReaderDemo
//
//  Created by taohanyao on 2017/4/21.
//  Copyright © 2017年 AppCoda. All rights reserved.
//
import UIKit
import Foundation

class MainViewController: UIViewController {
     

    @IBOutlet weak var ScanButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transfer = false
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
