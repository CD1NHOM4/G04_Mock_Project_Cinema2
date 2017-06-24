//
//  DesignView.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 5/28/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

@IBDesignable
class DesignView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
}
