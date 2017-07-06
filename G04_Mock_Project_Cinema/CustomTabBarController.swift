//
//  CustomTabBarController.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 6/7/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    @IBOutlet weak var financialTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // I've added this line to viewDidLoad
        //UIApplication.shared.statusBarFrame.size.height
//        financialTabBar.frame = CGRect(x: 0, y:  financialTabBar.frame.size.height, width: financialTabBar.frame.size.width, height: financialTabBar.frame.size.height)
}
}
