//
//  Patient.swift
//  QRReaderDemo
//
//  Created by taohanyao on 2017/4/21.
//  Copyright © 2017年 Hanyaotao. All rights reserved.
//

import Foundation
class Patient: NSObject {
    
    //properties
    var PatientID: Int?
    var t_swab: Int?
    var gender: String?
    var dob: String?
    var createTime: Date
    
    
    //empty constructor
    
    override init()
    {
        self.createTime = Date()
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(PatientID: Int, t_swab: Int, gender: String, dob: String, createTime: Date) {
        
        self.PatientID = PatientID
        self.t_swab = t_swab
        self.gender = gender
        self.dob = dob
        self.createTime = createTime
    }
    
//    
//    //prints object's current state
//    
//    override var description: String {
//        return "Name: \(name), Address: \(address), Latitude: \(latitude), Longitude: \(longitude)"
//        
//    }
    
    
}
