//
//  FilmInfo.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/3/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import Foundation
import UIKit

class FilmInfo {
    var actor: String
    var content: String
    var director: String
    var duration: Int
    var filmId: String
    var filmName: String
    var openningDay: String
    var posterUrl: String
    var type: String
    var videoUrl: String
    
    init(actor: String, content: String, director: String, duration: Int, filmId: String, filmName: String,
         openningDay: String, posterUrl: String, type: String, videoUrl: String) {
        self.actor = actor
        self.content = content
        self.director = director
        self.duration = duration
        self.filmId = filmId
        self.filmName = filmName
        self.openningDay = openningDay
        self.posterUrl = posterUrl
        self.type = type
        self.videoUrl = videoUrl
    }
    
}
