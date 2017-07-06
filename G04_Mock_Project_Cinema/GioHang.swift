//
//  GioHang.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 7/8/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation

class History {
    var releaseDay: String
    var movieTitle: String
    var money: Int64
    var location: String
    var numberOfChair: Int
    var showTime: String
    var bookDay: String
    
    init(releaseDay: String, movieTitle: String, money: Int64, location: String,
         numberOfChair: Int, showTime: String, bookDay: String) {
        self.releaseDay = releaseDay
        self.movieTitle = movieTitle
        self.money = money
        self.location = location
        self.numberOfChair = numberOfChair
        self.showTime = showTime
        self.bookDay = bookDay
    }
}
