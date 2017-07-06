//
//  MovieDetailTableViewController.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 7/12/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    var movieDetail: MovieDetail!
    @IBOutlet weak var txtMovieTitle: UILabel!
    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var txtFilmType: UILabel!
    @IBOutlet weak var txtContent: UITextView!
        
    @IBOutlet weak var txtDirector: UILabel!
    @IBOutlet weak var txtActor: UILabel!
    @IBOutlet weak var txtReleaseDay: UILabel!
        
    @IBOutlet weak var imgPoster: UIImageView!
    var type: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
         self.clearsSelectionOnViewWillAppear = false
        //Khởi tạo
        initData()
    }
        
    //load Data
    func initData() {
        txtMovieTitle.text = movieDetail.movieName
        txtType.text = movieDetail.type
        txtContent.text = movieDetail.content
        txtDirector.text = movieDetail.director
        txtActor.text = movieDetail.actor
        txtReleaseDay.text = movieDetail.openningDay
        if (movieDetail.movieType == "PhimDangChieu") {
            type = "Đang chiếu"
        }
        else if (movieDetail.movieType == "PhimSapChieu") {
            type = "Sắp chiếu"
        }
        else {
            type = "Đã chiếu"
        }
        txtFilmType.text = type
        imgPoster.image = Downloader.downloadImageWithURL(movieDetail.posterUrl)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    // MARK: - Table view data source
        
    override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
        if (movieDetail.movieType != "isShowing"){
            return 2
        }
        return 2
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
        
    //Sự kiện chọn suất chiếu
    @IBAction func btn850(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "DatVe") as! DatVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "850"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
        
    @IBAction func btn1000(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "DatVe") as! DatVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1000"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
        
    @IBAction func btn1125(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "DatVe") as! DatVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1125"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
        
    @IBAction func btn1400(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "DatVe") as! DatVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1400"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
        
    @IBAction func btn1635(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "DatVe") as! DatVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1635"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
        
    @IBAction func btn1900(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "DatVe") as! DatVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1900"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
}
        
