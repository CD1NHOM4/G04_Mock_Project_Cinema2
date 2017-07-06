//
//  DatVeViewController.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 7/13/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import MBProgressHUD
import Firebase

class DatVeViewController: UIViewController {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var txtFilmName: UILabel!
    @IBOutlet weak var txtActor: UILabel!
    
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var txtNumberTicket: UILabel!//UITextField!//BorderLabel!
    
    @IBOutlet weak var txtPrice: UILabel!
    var mDatabase: DatabaseReference!
    var progressDialog: MBProgressHUD!
    
    var movieDetail: MovieDetail!
    var time: String = ""
    var ticketNumber: Int64  = 1
    var priceFilm: Int64 = 0
    var money: Int64 = 0
    
    var userInfo: UserProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mDatabase = Database.database().reference()
        // Do any additional setup after loading the view.
        initData()
    }
    
    func initData() {
        if (true/*InternetConnection.isConnectedToNetwork()*/){
            loadData()
            loadDataFromDB()
        }
        else {
            showAlertDialogWithHandler(message: "Lỗi kết nối internet")
        }
    }
    
    //load data from database
    func loadDataFromDB() {
        //show progress movieDetail.movieType .child("PhimDangChieu")movieDetail.movieId .child("1").child("showTime").child("850").child("showTimeInfo")
        showProgress()
      //  mDatabase.child("movies").child("PhimDaChieu").observeSingleEvent(of: .value, with: { (snapshot)  in
       // mDatabase.child("movies").child("PhimDaChieu").observe(.childAdded, with: { (snapshot) -> Void in
        mDatabase.child("movies").child("PhimDangChieu").child("1").child("showTime").child("850").child("showTimeInfo").observeSingleEvent(of: .value, with: { (snapshot) in
            self.hideProgress()
            if let showTimeInfo = snapshot.value as? [String: AnyObject] {
                let price = showTimeInfo["price"] as? Int64 ?? 0
                let type = showTimeInfo["type"] as? String ?? ""
                let timeShow = showTimeInfo["time"] as? String ?? ""
                //load data
                self.txtPrice.text = String(price) + "VNĐ"
                self.txtTime.text = type + " - " + timeShow
                self.priceFilm = price
                //load data price
                self.money = self.priceFilm * self.ticketNumber
                self.lblMoney.text = String(self.money) + "VNĐ"
                
            }
        })
    }
    
    //Hàm hiện cảnh báo
    func showAlertDialogWithHandler(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Huỷ bỏ", style: .default, handler: nil)
        
        let tryAgainAction = UIAlertAction(title: "Thử lại", style: .default, handler: { (action: UIAlertAction) in
            self.initData()
        })
        
        alertView.addAction(cancelAction)
        alertView.addAction(tryAgainAction)
        present(alertView, animated: true, completion: nil)
    }
    
    //Hàm hiện cảnh báo đợi
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = "Đang xử lí..."
    }
    
    //Hàm ẩn cảnh báo đợi
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    //Hàm load dữ liệu
    func loadData() {
        imgPoster.image = Downloader.downloadImageWithURL(movieDetail.posterUrl)
        txtFilmName.text = movieDetail.movieName
    }
    
    //Sụ kiện khi click nút giảm
    @IBAction func btnMinus(_ sender: Any) {
        if (ticketNumber > 0) {
            ticketNumber = ticketNumber - 1;
            txtNumberTicket.text = String(ticketNumber)
            money = priceFilm * ticketNumber
            lblMoney.text = String(money) + "VNĐ"
        }
    }
    
    //Sự kiện khi click nút tăng
    @IBAction func btnAdd(_ sender: Any) {
        ticketNumber = ticketNumber + 1;
        txtNumberTicket.text = String(ticketNumber)
        money = priceFilm * ticketNumber
        lblMoney.text = String(money) + " VNĐ"
    }
    
    //Xửu lí sự kiện khi nhấn phím Next
    @IBAction func btnNext(_ sender: Any) {
        if (ticketNumber > 0) {
            if Auth.auth().currentUser != nil {
                if (userInfo != nil) {
                    if (Int64(userInfo.balance) < money) {
                        showAlertDialog(message: "Số tiền trong tài khoản của bạn không đủ")
                    }
                    else {
                        let src = self.storyboard?.instantiateViewController(withIdentifier: "choosePlacesId") as! LuaChonGheViewController
                        src.movieDetail = movieDetail
                        src.time = time
                        src.ticket = Int(self.ticketNumber)
                        src.money = money
                        src.userInfo = userInfo
                        navigationController?.pushViewController(src, animated: true)
                    }
                }
                else {
                    mDatabase.child("Acount").child(getUid()).observeSingleEvent(of: .value, with: { (snapshot) in
                        if let user = snapshot.value as? [String: AnyObject] {
                            let fullName = user["fullname"] as? String ?? ""
                            let email = user["email"] as? String ?? ""
                            let address = user["address"] as? String ?? ""
                            let phone = user["phone"] as? String ?? ""
                            let balance = user["balance"] as? Double ?? 0
                            let score = user["score"] as? Double ?? 0
                            let password = user["password"] as? String ?? ""
                            //Khởi tạo
                          //  init(userid: String, fullName: String, email: String, address: String, score: Double,
                            //password: String, phone: String, balance: Double) {
                            self.userInfo = UserProfile.init(userid: self.getUid(), fullName: fullName, email: email, address: address, score: score, password: password, phone: phone,balance:balance)
                            
                            if (Int64(self.userInfo.balance) < self.money) {
                                self.showAlertDialog(message: "Số tiền trong tài khoản của bạn không đủ")
                            }
                            else {
                                let src = self.storyboard?.instantiateViewController(withIdentifier: "choosePlacesId") as! LuaChonGheViewController
                                src.movieDetail = self.movieDetail
                                src.time = self.time
                                src.ticket = Int(self.ticketNumber)
                                src.money = self.money
                                src.userInfo = self.userInfo
                                self.navigationController?.pushViewController(src, animated: true)
                            }
                            
                        }
                    })
                }
            }
            else {
                let alertView = UIAlertController(title: "Thông Báo", message: "Hãy đăng nhập trước khi sử dụng tính năng này", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                let actionLogin = UIAlertAction(title: "Đăng nhập", style: .default, handler: { (action: UIAlertAction) in
                    let srcSignIn = self.storyboard?.instantiateViewController(withIdentifier: "signInId") as! LogInViewController
                    self.present(srcSignIn, animated: true, completion: nil)
                })
                alertView.addAction(action)
                alertView.addAction(actionLogin)
                self.present(alertView, animated: true, completion: nil)
                
            }
        }
        else {
            showAlertDialog(message: "Hãy chọn ít nhất 1 vé")
        }
    }
    
    //show alertView
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //Lấy mã User hiện tại
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(String(ticketNumber))
        super.viewDidAppear(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
