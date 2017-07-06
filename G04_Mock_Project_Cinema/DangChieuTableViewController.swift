//
//  DangChieuTableViewController.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 7/12/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//
import UIKit
import Firebase
import MBProgressHUD

extension DangChieuTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchMovieByName(searchBar.text!)
    }
}

extension DangChieuTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        searchMovieByName(searchController.searchBar.text!)
    }
}

class DangChieuTableViewController: UITableViewController {

    var mDatabase: DatabaseReference!
    var movies = [MovieDetail]()
    var searchFilms = [MovieDetail]()
    let searchController = UISearchController(searchResultsController: nil)
    var progressDialog: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mDatabase = Database.database().reference()
        //
         self.clearsSelectionOnViewWillAppear = false
        loadData()
        //register
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "FilmRow")
        //Tuy chon tim kiem
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false;
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func loadData() {
        if (true) {
            LayPhimDangChieu()        }
        else {
            showAlertDialog(message: "Không có kết nối internet")
        }
    }
    
    //Xem profile của người dùng
    @IBAction func btnUserInfo(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let srcUserInfo = self.storyboard?.instantiateViewController(withIdentifier: "userProfileId") as! UserProfileViewController
            present(srcUserInfo, animated: true, completion: nil)
        } else {
            let srcSignIn = self.storyboard?.instantiateViewController(withIdentifier: "logInId") as! LogInViewController
            present(srcSignIn, animated: true, completion: nil)
            }
    }
    
    //Hiện tiến trình đợi
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = "Đang tải..."
    }
    
    //Ẩn tiến trình đợi
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    
    //Hiện cảnh báo
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Huỷ", style: .default, handler: nil)
        
        let tryAgainAction = UIAlertAction(title: "Thử lại", style: .default, handler: { (action: UIAlertAction) in
            self.loadData()
        })
        
        alertView.addAction(cancelAction)
        alertView.addAction(tryAgainAction)
        present(alertView, animated: true, completion: nil)
    }
    
    //Lấy các phim sắp chiếu từ database
    func LayPhimDangChieu(){
        //Hiện cảnh báo đợi
        showProgress()
        mDatabase.child("movies").child("PhimDangChieu").observe(.childAdded, with: { (snapshot) -> Void in
            
            var movie: [String: AnyObject] = (snapshot.value as? [String: AnyObject])!
            var movieDetail = movie["movieDetail"] as? [String: AnyObject]
            //Lấy data chứa trong movieDetail
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
            let movieType: String = movieDetail!["movieType"] as? String ?? ""
            
            let movieDetailData: MovieDetail  = MovieDetail.init(actor: actor, content: content, director: director, duration: duration, movieId: movieId, movieName: movieName, movieType: movieType, openningDay: openningDay, posterUrl: posterUrl, type: type, videoUrl: videoUrl)
            self.movies.append(movieDetailData)
            
            //thêm tiến trình vào main thread
            DispatchQueue.main.async {
                self.hideProgress()
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
        if (searchController.isActive && searchController.searchBar.text != "") {
            return searchFilms.count
        }
        return movies.count
    }
    
    //load dữ liệu lên cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmRow", for: indexPath) as! CustomTableViewCell
        let movieDetail: MovieDetail
        if (searchController.isActive && searchController.searchBar.text != "") {
            movieDetail = searchFilms[indexPath.row]
        }
        else {
            movieDetail = movies[indexPath.row]
        }
        cell.configWithCell(movieDetail: movieDetail)
        return cell
    }
    
    //Sự kiện khi click vào cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let srcDetailMovie = self.storyboard?.instantiateViewController(withIdentifier: "movieDetailId") as! MovieDetailTableViewController
        let movieDetail: MovieDetail
        if (searchController.isActive && searchController.searchBar.text! != "") {
            movieDetail = searchFilms[indexPath.row]
        }
        else {
            movieDetail = movies[indexPath.row]
        }
        srcDetailMovie.movieDetail = movieDetail
        navigationController?.pushViewController(srcDetailMovie, animated: true)
        
    }
    //search
    func searchMovieByName(_ movieName: String) {
        searchFilms = movies.filter({ (movieDetail: MovieDetail) -> Bool in
            return movieDetail.movieName.lowercased().contains(movieName.lowercased())
        })
        self.tableView.reloadData()
    }
}

