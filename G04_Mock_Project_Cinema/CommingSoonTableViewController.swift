//
//  CommingSoonTableViewController.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/3/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase


class CommingSoonTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

     let searchController = UISearchController(searchResultsController: nil)
    var mDatabase: DatabaseReference!
    var films = [FilmInfo]()
   var filteredFilms = [FilmInfo]()
    
    @IBOutlet weak var txtF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        mDatabase = Database.database().reference()
        getAllMoviesCommningSoon()
    }
    
    @IBAction func btn(_ sender: Any) {
    }
    
    func getAllMoviesCommningSoon() {
        mDatabase.child("Film").observe(.childAdded, with: { (snapshot) -> Void in
          //  var film: [String: AnyObject] = (snapshot.value as? [String: AnyObject])!
            var filmInfo: [String: AnyObject] = (snapshot.value as? [String: AnyObject])!
         //  var filmInfo = film["filmInfo"] as? [String: AnyObject]
            //get data filmInfo
            let actor: String = filmInfo["actor"] as? String ?? ""
            let content: String = filmInfo["content"] as? String ?? ""
            let director: String = filmInfo["director"] as? String ?? ""
            let duration: Int = filmInfo["duration"] as? Int ?? 0
            let filmId: String = filmInfo["filmId"] as? String ?? ""
            let filmName: String = filmInfo["filmName"] as? String ?? ""
            let openningDay: String = filmInfo["openningDay"] as? String ?? ""
            let posterUrl: String = filmInfo["posterUrl"] as? String ?? ""
            let type: String = filmInfo["type"] as? String ?? ""
            let videoUrl: String = filmInfo["videoUrl"] as? String ?? ""
            
            let filmInfoData: FilmInfo  = FilmInfo.init(actor: actor, content: content, director: director, duration: duration, filmId: filmId, filmName: filmName, openningDay: openningDay, posterUrl: posterUrl, type: type, videoUrl: videoUrl)
            self.films.append(filmInfoData)
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
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredFilms.count
        }
        return films.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmRow", for: indexPath) as! DesignTableViewCell

        let cell = Bundle.main.loadNibNamed("DesignTableViewCell", owner: self, options: nil)?.first as! DesignTableViewCell
        let filmInfo: FilmInfo
        if searchController.isActive && searchController.searchBar.text != "" {
            filmInfo = filteredFilms[indexPath.row]
        } else {
            filmInfo = films[indexPath.row]
        }
       // let filmInfo = films[indexPath.row]
        
        //cell.txtTitle.text! = "dsa"
       // cell.txtType.text! = "das"
        cell.configWithCell(filmInfo: filmInfo)
        
        return cell
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredFilms = films.filter { films in
            return  (films.filmName.lowercased().contains(searchText.lowercased())||films.actor.lowercased().contains(searchText.lowercased()))
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
