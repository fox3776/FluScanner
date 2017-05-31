//
//  DetailCell.swift
//  QRReaderDemo
//
//  Created by taohanyao on 2017/4/21.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableControllerCell: UITableViewCell {
    @IBOutlet weak var patientid: UILabel!
    @IBOutlet weak var swabID: UILabel!
    @IBOutlet weak var createTime: UILabel!

    func setcontent(history:Patient) {
        patientid.text = String(describing: history.PatientID!)
        swabID.text = String(describing: history.t_swab!)
        createTime.text = String(describing: history.createTime).components(separatedBy: " +")[0]
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
  
}
