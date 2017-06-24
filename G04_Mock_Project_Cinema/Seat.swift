//
//  Seat.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/3/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import Foundation

class Seat {
    var bookBy: String
    var state: Bool
    
    init (bookBy: String, state: Bool) {
        self.bookBy = bookBy
        self.state = state
    }
}
