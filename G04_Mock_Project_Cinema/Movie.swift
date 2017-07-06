//
//  Movie.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 7/8/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation

class Movie {
    var movieDetail: MovieDetail
    var showTime: ShowTime
    
    init(movieDetail: MovieDetail, showTime: ShowTime) {
        self.movieDetail = movieDetail
        self.showTime = showTime
    }
}
