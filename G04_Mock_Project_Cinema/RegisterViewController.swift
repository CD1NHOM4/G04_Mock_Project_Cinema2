//
//  RegisterViewController.swift
//  G04_MockProject_Cinema
//
//  Created by THANH on 6/5/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var gh: UITextField!
    @IBOutlet weak var txtFFullName: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFPass: UITextField!
    @IBOutlet weak var txtFConfirmPass: UITextField!
    @IBOutlet weak var txtFAddress: UITextField!
    @IBOutlet weak var txtFPhone: UITextField!
    
    
    var mDatabase: DatabaseReference!
    var loadingNotification: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()

        // Do any additional setup after loading the view.
        mDatabase = Database.database().reference()
    }
    
    @IBAction func btnClose_Act(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRegister_Act(_ sender: Any) {
        var result: Bool = true
        let email: String = txtFEmail.text!
        let password: String = txtFPass.text!
        let phone: String = txtFPhone.text!
        let confirmPass: String = txtFConfirmPass.text!
        let address: String = txtFAddress.text!
        let fullName: String = txtFFullName.text!
        
        if (email.isEmpty || password.isEmpty || phone.isEmpty || confirmPass.isEmpty || address.isEmpty || fullName.isEmpty){
            showAlertDialog(message: "Bạn cần điền đầy đủ thông tin");
            result = false
        }
        else{
            if !(Validate.isValidEmail(testStr: email)) {
                showAlertDialog(message: "Sai định dạng Email")
                result = false
            }
            
            if (password.characters.count < 6 || confirmPass.characters.count < 6) {
                showAlertDialog(message: "Mật khẩu phải có ít nhất 6 kí tự");
                result = false;
            }
            else {
                if (password != confirmPass) {
                    showAlertDialog(message: "Mật khẩu không trùng khớp")
                    result = false;
                }
            }
            
            if (result) {
                
                //Hiện Progress
                self.showProgress()
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    //Ẩn tiến trình
                    self.hideProgress()
                    if error == nil {
                        let dataUser = [
                            "userid": user?.uid ?? "guest",
                            "email": email,
                            "phone": phone,
                            "address": address,
                            "password": password,
                            "score": 200000,
                            "fullName": fullName
                            ] as [String : Any]
                        self.mDatabase.child("users").child((user?.uid)!).updateChildValues(dataUser)
                        
                        //Chuẩn bị trước khi chuyển qua Màn hình user Profile
                        let srcUserInfo = self.storyboard?.instantiateViewController(withIdentifier: "userInfoId") as! UserInfoViewController
                        self.present(srcUserInfo, animated: true)
                    } else {
                        if let errCode = AuthErrorCode(rawValue: error!._code) {
                            switch errCode {
                            case .invalidEmail:
                                self.showAlertDialog(message: "Sai định dạng Email")
                            case .emailAlreadyInUse:
                                self.showAlertDialog(message: "Email đã được sử dụng, vui lòng thử lại")
                            default:
                                self.showAlertDialog(message: "Không thể tạo tài khoản, vui lòng thử lại")
                            }
                        }                    }
                }
            }
            
        }
        
    }
    //Hiện tiến trình khi đang xử lí
    func showProgress() {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Đang tải..."
    }
    //Ẩn Progress khi tiến trình hoàn tất
    func hideProgress() {
        loadingNotification.hide(animated: true)
    }
    //Hiện hộp thoại cảnh báo
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //MARK: - Show, Hide Keyboard
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtFEmail.resignFirstResponder()
        txtFPass.resignFirstResponder()
        txtFConfirmPass.resignFirstResponder()
        txtFAddress.resignFirstResponder()
        txtFPhone.resignFirstResponder()
        txtFFullName.resignFirstResponder()
        return true
    }
    //
    fileprivate func observerKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    //Ẩn Bàn phím khi kết thúc Edit
    func DismissKeyboard(){
        view.endEditing(true)
    }
    //Hiện bàn phím khi bắt đầu Edit TextField
    func keyboardWillShow(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -170, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    //Ẩn bàn phìm
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
}
