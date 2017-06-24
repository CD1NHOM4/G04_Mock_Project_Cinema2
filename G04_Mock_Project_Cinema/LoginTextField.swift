//
//  LoginTextField.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 5/27/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

@IBDesignable
class LoginTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var leftImage: UIImage?{
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0{
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        if let image = leftImage{
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 25, height: 25))
            
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
            //image is nill
            leftViewMode = .never
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder!: "", attributes: [NSForegroundColorAttributeName: tintColor])
        
    }

}
