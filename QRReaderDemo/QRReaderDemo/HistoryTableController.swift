//
//  InquireTableController.swift
//  QRReaderDemo
//
//  Created by taohanyao on 2017/4/22.
//  Copyright © 2017年 AppCoda. All rights reserved.
//
//

import UIKit
import Foundation
import Alamofire


class HistoryTableController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var InquireTable: UITableView!

    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (history.count)
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableControllerCell
        cell.setcontent( history: history[indexPath.row])

            return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") {
            action, index in
            
            print("delete")
            
            let alertController = UIAlertController(title: "Confirm Delete history", message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (action: UIAlertAction!) -> Void in
                self.dismiss(animated: false, completion: nil)
            })
            let okAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
                (action: UIAlertAction!) -> Void in
                
            
                history.remove(at: indexPath.row)
                
                self.InquireTable.reloadData()
                
                let alert = UIAlertController(title: "Delete Success", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { Void in
                    self.dismiss(animated: false, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                
                
            })
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        delete.backgroundColor = .red
        
        
        return [delete]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "History"
    
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        InquireTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
