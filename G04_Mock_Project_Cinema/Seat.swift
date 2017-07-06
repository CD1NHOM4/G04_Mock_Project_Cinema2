//
//  UserProfile.swift
//  G04_MockProject_Cinema
//
//  Created by THANH on 6/5/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation

class Seat {
    var bookBy: String
    var state: Bool
    var seatName: String
    
    init (bookBy: String, state: Bool, seatName: String) {
        self.bookBy = bookBy
        self.state = state
        self.seatName  = seatName
    }
}
