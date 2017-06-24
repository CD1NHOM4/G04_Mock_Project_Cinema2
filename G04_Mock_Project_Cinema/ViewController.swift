//
//  ViewController.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 6/6/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

import Firebase

class ViewController: UIViewController{//, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var shownButton: UIButton!
    @IBOutlet var nowShowingButton: UIButton!
    @IBOutlet var comingSoonButton: UIButton!
    
    @IBOutlet var movieTableView: UITableView!
    //var movies = [Movie]()
   // var moviesClass = [Movie]()
    var posterImage: [Int:UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.movieTableView.dataSource = self
        //self.movieTableView.delegate = self
       // getMoviesList()
        // getNowShowingMovies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

