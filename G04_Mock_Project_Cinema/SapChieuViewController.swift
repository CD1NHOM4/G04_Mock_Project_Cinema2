//
//  SapChieuViewController.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 6/7/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase

class SapChieuTableViewController: UITableViewController {

        var rfDatabase: DatabaseReference!
        var movies = [MovieDetail]()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem()
            rfDatabase = Database.database().reference()
            getAllMoviesCommningSoon()
        }
        
        func getAllMoviesCommningSoon() {
            rfDatabase.child("movies").child("commingSoon").observe(.childAdded, with: { (snapshot) -> Void in
                var user1 = snapshot.value as? [String: AnyObject]
                var movie: [String: AnyObject] = (snapshot.value as? [String: AnyObject])!
                var movieDetail = movie["movieDetail"] as? [String: AnyObject]
                //get data moviesDetail
                let actor: String = movieDetail!["actor"] as? String ?? ""
                let content: String = movieDetail!["content"] as? String ?? ""
                let director: String = movieDetail!["director"] as? String ?? ""
                let duration: Int = movieDetail?["duration"] as? Int ?? 0
                let movieId: String = movieDetail!["movieId"] as? String ?? ""
                let movieName: String = movieDetail!["movieName"] as? String ?? ""
                let openningDay: String = movieDetail!["openningDay"] as? String ?? ""
                let posterUrl: String = movieDetail!["posterUrl"] as? String ?? ""
                let type: String = movieDetail!["type"] as? String ?? ""
                let videoUrl: String = movieDetail!["videoUrl"] as? String ?? ""
                
                let movieDetailData: MovieDetail  = MovieDetail.init(actor: actor, content: content, director: director, duration: duration, movieId: movieId, movieName: movieName, openningDay: openningDay, posterUrl: posterUrl, type: type, videoUrl: videoUrl)
                self.movies.append(movieDetailData)
                //show into main thread
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return movies.count
        }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmRow", for: indexPath) as! DesignTableViewCell
        
        let cell = Bundle.main.loadNibNamed("DesignTableViewCell", owner: self, options: nil)?.first as! DesignTableViewCell
        let movieDetail = movies[indexPath.row]
        
        //cell.txtTitle.text! = "dsa"
        // cell.txtType.text! = "das"
        cell.configWithCell(movieDetail: movieDetail)
        
        return cell
    }
}
