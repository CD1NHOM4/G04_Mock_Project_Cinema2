//
//  uyTicketViewController.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 7/8/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

//import UIKit
//import MBProgressHUD
//import Firebase
//
//class BuyTicketViewController: UIViewController {
//    
//    
//    @IBOutlet weak var imgPoster: UIImageView!
//    @IBOutlet weak var txtFilmName: UILabel!
//    @IBOutlet weak var txtActor: UILabel!
//    
//    @IBOutlet weak var lblMoney: UILabel!
//    @IBOutlet weak var txtTime: UILabel!
//   // @IBOutlet weak var txtNumberTicket: BorderLabel!
//    
//    @IBOutlet weak var txtPrice: UILabel!
//    var mDatabase: DatabaseReference!
//    var progressDialog: MBProgressHUD!
//    
//    var filmInfo: FilmInfo!
//    var time: String = ""
//    var ticketNumber: Int64  = 1
//    var priceFilm: Int64 = 0
//    var money: Int64 = 0
//    
//    var userInfo: User!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        mDatabase = Database.database().reference()
//        // Do any additional setup after loading the view.
//        initData()
//    }
//    
//    func initData() {
//        if (true/*InternetConnection.isConnectedToNetwork()*/){
//            loadData()
//            loadDataFromDB()
//        }
//        else {
//            showAlertDialogWithHandler(message: "Không có kết nối internet")
//        }
//    }
//    
//    //load data from database
//    func loadDataFromDB() {
//        //show progress
//        showProgress()
//        mDatabase.child("films").child(filmInfo.filmType).child(filmInfo.filmId).child("showTimes").child(time).child("showTimeInfo").observeSingleEvent(of: .value, with: { (snapshot) in
//            self.hideProgress()
//            if let showTimeInfo = snapshot.value as? [String: AnyObject] {
//                let price = showTimeInfo["price"] as? Int64 ?? 0
//                let type = showTimeInfo["type"] as? String ?? ""
//                let timeShow = showTimeInfo["time"] as? String ?? ""
//                //load data
//                self.txtPrice.text = String(price) + "VND"
//                self.txtTime.text = type + " - " + timeShow
//                self.priceFilm = price
//                //load data price
//                self.money = self.priceFilm * self.ticketNumber
//                self.lblMoney.text = String(self.money) + "VND"
//                
//            }
//        })
//    }
//    
//    //show alertView
//    func showAlertDialogWithHandler(message: String) {
//        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Huỷ", style: .default, handler: nil)
//        
//        let tryAgainAction = UIAlertAction(title: "Thử lại", style: .default, handler: { (action: UIAlertAction) in
//            self.initData()
//        })
//        
//        alertView.addAction(cancelAction)
//        alertView.addAction(tryAgainAction)
//        present(alertView, animated: true, completion: nil)
//    }
//    
//    //show progress dialog
//    func showProgress() {
//        progressDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
//        progressDialog.mode = MBProgressHUDMode.indeterminate
//        progressDialog.label.text = "Đang tải..."
//    }
//    
//    //hide progress dialog
//    func hideProgress() {
//        progressDialog.hide(animated: true)
//    }
//    
//    func loadData() {
//        imgPoster.image = Downloader.downloadImageWithURL(filmInfo.posterUrl)
//        txtFilmName.text = filmInfo.filmName
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    //event click button minus
//    @IBAction func btnMinus(_ sender: Any) {
//        if (ticketNumber > 0) {
//            ticketNumber = ticketNumber - 1;
//            txtNumberTicket.text = String(ticketNumber)
//            money = priceFilm * ticketNumber
//            lblMoney.text = String(money) + "VND"
//        }
//    }
//    
//    //event click button add
//    @IBAction func btnAdd(_ sender: Any) {
//        ticketNumber = ticketNumber + 1;
//        txtNumberTicket.text = String(ticketNumber)
//        money = priceFilm * ticketNumber
//        lblMoney.text = String(money) + " VND"
//    }
//    
//    //event click button next
//    @IBAction func btnNext(_ sender: Any) {
//        if (ticketNumber > 0) {
//            if Auth.auth().currentUser != nil {
//                if (userInfo != nil) {
//                    if (Int64(userInfo.balance) < money) {
//                        showAlertDialog(message: "Số tiền trong tài khoản của bạn không đủ")
//                    }
//                    else {
//                        let src = self.storyboard?.instantiateViewController(withIdentifier: "choosePlacesId") as! ChoosePlacesViewController
//                        src.filmInfo = filmInfo
//                        src.time = time
//                        src.ticket = Int(self.ticketNumber)
//                        src.money = money
//                        src.userInfo = userInfo
//                        navigationController?.pushViewController(src, animated: true)
//                    }
//                }
//                else {
//                    mDatabase.child("users").child(getUid()).observeSingleEvent(of: .value, with: { (snapshot) in
//                        if let user = snapshot.value as? [String: AnyObject] {
//                            let fullName = user["fullName"] as? String ?? ""
//                            let email = user["email"] as? String ?? ""
//                            let address = user["address"] as? String ?? ""
//                            let phone = user["phone"] as? String ?? ""
//                            let balance = user["balance"] as? Double ?? 0
//                            let password = user["password"] as? String ?? ""
//                            
//                            self.userInfo = User.init(fullName: fullName, email: email, address: address, balance: balance, password: password, phone: phone, uid: self.getUid())
//                            
//                            if (Int64(self.userInfo.balance) < self.money) {
//                                self.showAlertDialog(message: "Số tiền trong tài khoản của bạn không đủ")
//                            }
//                            else {
//                                let src = self.storyboard?.instantiateViewController(withIdentifier: "choosePlacesId") as! ChoosePlacesViewController
//                                src.filmInfo = self.filmInfo
//                                src.time = self.time
//                                src.ticket = Int(self.ticketNumber)
//                                src.money = self.money
//                                src.userInfo = self.userInfo
//                                self.navigationController?.pushViewController(src, animated: true)
//                            }
//                            
//                        }
//                    })
//                }
//            }
//            else {
//                let alertView = UIAlertController(title: "Thông Báo", message: "Hãy đăng nhập trước khi sử dụng tính năng này", preferredStyle: .alert)
//                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                let actionLogin = UIAlertAction(title: "Đăng nhập", style: .default, handler: { (action: UIAlertAction) in
//                    let srcSignIn = self.storyboard?.instantiateViewController(withIdentifier: "signInId") as! SignInViewController
//                    self.present(srcSignIn, animated: true, completion: nil)
//                })
//                alertView.addAction(action)
//                alertView.addAction(actionLogin)
//                self.present(alertView, animated: true, completion: nil)
//                
//            }
//        }
//        else {
//            showAlertDialog(message: "Hãy chọn ít nhất 1 vé")
//        }
//    }
//    
//    //show alertView
//    func showAlertDialog(message: String) {
//        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alertView.addAction(action)
//        self.present(alertView, animated: true, completion: nil)
//    }
//    
//    //get current id
//    func getUid() -> String {
//        return (Auth.auth().currentUser?.uid)!
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        print(String(ticketNumber))
//        super.viewDidAppear(true)
//    }
//}
