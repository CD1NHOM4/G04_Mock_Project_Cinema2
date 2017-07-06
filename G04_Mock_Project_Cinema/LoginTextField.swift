//
//  LogInTextField.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 7/6/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

@IBDesignable class LogInTextField: UITextField {
    
    //Set độ cong viền cho TextField
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    //Set ảnh bên trái cho TextField
    @IBInspectable var leftImage: UIImage?{
        didSet {
            updateView()
        }
    }
    //
    @IBInspectable var leftPadding: CGFloat = 0{
        didSet{
            updateView()
        }
    }
    //Hàm update View
    func updateView(){
        if let image = leftImage{
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 27, height: 27))
            
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = leftPadding + 20
            
            if borderStyle == UITextBorderStyle.none || borderStyle ==  UITextBorderStyle.line {
                width = width + 10
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            leftView = view
        } else{
            //Nếu Ảnh nil
            leftViewMode = .never
        }
        //
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder!: "", attributes: [NSForegroundColorAttributeName: tintColor])
    }
    
}

