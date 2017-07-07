//
//  UserProfile.swift
//  G04_MockProject_Cinema
//
//  Created by THANH on 6/5/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation
import UIKit

class UserProfile: NSObject {
    var userid: String
    var fullName: String
    var email: String
    var address: String
    var score: Double
    var password: String
    var phone: String
    var balance: Double
    //Khởi tạo
    init(userid: String, fullName: String, email: String, address: String, score: Double,
         password: String, phone: String, balance: Double) {
        
        self.userid = userid
        self.fullName = fullName
        self.email = email
        self.address = address
        self.score = score
        self.password = password
        self.phone = phone
        self.balance = balance

        
    }
    //
    convenience override init() {
        self.init(userid: "", fullName: "",email: "", address: "", score: 0, password: "",
                  phone: "", balance: 0)
    }
}
