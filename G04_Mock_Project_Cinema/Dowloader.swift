//
//  Dowloader.swift
//  G04_MockProject_Cinema
//
//  Created by THANH on 6/5/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation
import UIKit

class Downloader {
    //1.Hàm dowload file ảnh từ URL, hàm đang dùng
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        let data = try? Data(contentsOf: URL(string: url)!)
        if(data == nil){ return  #imageLiteral(resourceName: "imgNotAvailable")}
        return UIImage(data: data!)
    }
    
    //2.Hàm get Data từ URL, hàm dư phòng
    class func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    //3.
    class func downloadImage(url: URL){
        print("Bắt đầu Download")
        getDataFromUrl(url: url) { (data, response, error)  in
            //guard let data = data, error == nil else { return }
            guard let _ = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Hoàn thành")
            DispatchQueue.main.async() { () -> Void in
            }
        }
    }
}
