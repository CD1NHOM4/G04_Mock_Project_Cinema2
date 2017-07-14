//
//  ForgotViewController.swift
//  G04_MockProject_Cinema
//
//  Created by THANH on 6/5/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase
class ForgotPassViewController: UIViewController {
    
    @IBOutlet weak var txtEmailRegistered: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnClose_Act(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //Hàm xử lí button Reset Pass gửi link xác nhận
    @IBAction func btnResetPass_Act(_ sender: Any) {
        let email: String = txtEmailRegistered.text!
        if email.isEmpty
        {
            //Hien cảnh báo Cần Nhập đầy đủ thông tin
            showAlertDialog(message: "Hãy điền đầy đủ thông tin");
        }
        else
        {
            //Kiểm tra định dạng Email
            if !(Validate.isValidEmail(testStr: email))
            {
                showAlertDialog(message: "Sai định dạng Email")
            }
            else
            {
                //gửi email reset password cho người dùng
                Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                    if error == nil
                    {
                        //show alert
                        let alertView = UIAlertController(title: "Thông Báo", message: "Một Emai đã được gửi đến EMAIL của bạn", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Đồng ý", style: .default, handler: { (action: UIAlertAction) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alertView.addAction(action)
                        self.present(alertView, animated: true, completion: nil)
                    }
                    else {
                        self.showAlertDialog(message: "Gửi email không thành công")
                    }
                }
            }
        }
    }
    //MARK: - Show, Hide Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEmailRegistered.resignFirstResponder()
        return true
    }
    //
    fileprivate func observerKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    //Dismiss keyboard khi click ra khỏi TextField
    func DismissKeyboard(){
        view.endEditing(true)
    }
    //Hiện bàn phím
    func keyboardWillShow(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -100, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    //Ẩn Bàn phím
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    //Hàm hiện cảnh báo lỗi alertView
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Chấp nhận", style: .default, handler: nil)
       
        alertView.addAction(action)
        //
        self.present(alertView, animated: true, completion: nil)
    }
    
}
