//
//  CustomDesignButton.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 7/6/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

@IBDesignable
class CustomDesignButton: UIButton {
    //Độ bo tròn đường viền
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    //Set độ rộng đường viền
    @IBInspectable var borderWidth: CGFloat = 0.1{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    //Set Màu sắc cho đường viền
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
}
