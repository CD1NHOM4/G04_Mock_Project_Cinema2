//
//  UserProfileViewController.swift
//  G04_MockProject_Cinema
//
//  Created by THANH on 6/5/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet weak var txtFFullName: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    
    @IBOutlet weak var txtFPhone: UITextField!
    @IBOutlet weak var txtFAddress: UITextField!
    
    @IBOutlet weak var txtScore: UITextField!
    
    var mDatabase: DatabaseReference!
    var loadingNotification: MBProgressHUD!
    var userToMove: UserProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mDatabase = Database.database().reference()
        
        //load user info
        //show progress
        self.showProgress()
        if let userid = Auth.auth().currentUser?.uid {
            mDatabase.child("Acount").child(userid).observeSingleEvent(of: .value, with: { (snapshot) in
                self.hideProgress()
                if let user = snapshot.value as? [String: AnyObject] {
                    let fullName = user["fullname"] as? String ?? ""
                    let email = user["email"] as? String ?? ""
                    let address = user["address"] as? String ?? ""
                    let phone = user["phone"] as? String ?? ""
                    let score = String(user["score"] as? Double ?? 0)
                    
                    self.txtFFullName.text! = fullName
                    self.txtFEmail.text! = email
                    self.txtFAddress.text! = address
                    self.txtFPhone.text! = phone
                    self.txtScore.text! = score
                    
                    self.userToMove = UserProfile.init(userid: userid, fullName: fullName, email: email, address: address, score: Double(score)!, password: user["password"] as? String ?? "" , phone: phone)
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //event click change pass
    
    @IBAction func btnChangePass_Act(_ sender: Any) {
        let srcChangePass = self.storyboard?.instantiateViewController(withIdentifier: "changePassId") as! ChangePassViewController
        srcChangePass.user = userToMove
        self.present(srcChangePass, animated: true)
    }
    
    func showProgress() {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Đang tải..."
    }
    
    func hideProgress() {
        loadingNotification.hide(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnHome_Act(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
