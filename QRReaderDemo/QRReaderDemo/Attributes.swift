//
//  Attributes.swift
//  QRReaderDemo
//
//  Created by taohanyao on 2017/4/21.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import Foundation
var t_swab: Int = 0
var instances: [Patient] = []
var history: [Patient] = []
var ipAddress: String = "http://192.168.1.123/task/v1/index.php/"
//var ipAddress: String = "http://10.12.22.117/task/v1/index.php/"
class Attributes {
    static let SharedAttributes = Attributes()
    
    
    func clear()  {
        instances = []
    }
    
    
    
}
