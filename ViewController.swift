//
//  ViewController.swift
//  G04_Mock_Project_Cinema
//
//  Created by THANH on 6/7/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITableViewDataSource,UITabBarDelegate{
    
    
 var rfDatabase: DatabaseReference!
    var handle: DatabaseHandle!
    var myList :[String] = []
    var dem = 0
    @IBOutlet weak var txtf: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rfDatabase = Database.database().reference()
        myList.removeAll()
        handle = rfDatabase.child("list").child("1").observe(.childAdded, with: { (snapshot) in
                if let item = snapshot.value as? String
                {
                    self.myList.append(item)
                    self.myTableView.reloadData()
                }
            self.myTableView.reloadData()
           
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell(style: .default,reuseIdentifier:"cell")
        cell.textLabel?.text = myList[indexPath.row]
        return cell        // Configure the cell...
    }
    
    //
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myList.count
    }

    //=============
    func getAllMoviesCommningSoon() {
        rfDatabase.child("films").child("commingSoon").child("filmInfo").observe(.childAdded, with: { (snapshot) -> Void in
//            var film: [String: AnyObject] = (snapshot.value as? [String: AnyObject])!
//            var filmInfo = film["filmInfo"] as? [String: AnyObject]
//            //get data filmInfo
//            let actor: String = filmInfo!["actor"] as? String ?? ""
//            let content: String = filmInfo!["content"] as? String ?? ""
//            let director: String = filmInfo!["director"] as? String ?? ""
//            let duration: Int = filmInfo?["duration"] as? Int ?? 0
//            let filmId: String = filmInfo!["filmId"] as? String ?? ""
//            let filmName: String = filmInfo!["filmName"] as? String ?? ""
//            let openningDay: String = filmInfo!["openningDay"] as? String ?? ""
//            let posterUrl: String = filmInfo!["posterUrl"] as? String ?? ""
//            let type: String = filmInfo!["type"] as? String ?? ""
//            let videoUrl: String = filmInfo!["videoUrl"] as? String ?? ""
//            
//            let filmInfoData: FilmInfo  = FilmInfo.init(actor: actor, content: content, director: director, duration: duration, filmId: filmId, filmName: filmName, filmType: <#String#>, openningDay: openningDay, posterUrl: posterUrl, type: type, videoUrl: videoUrl)
           // self.films.append(filmInfoData)
            //show into main thread
          //  DispatchQueue.main.async {
             //   self.tableView.reloadData()
          //  }
        })
    }
    @IBAction func btn(_ sender: Any) {
                //getAllMoviesCommningSoon()
         if txtf.text != ""
        {
            
            rfDatabase.child("list").child("1").childByAutoId().setValue(txtf.text)
            txtf.text = ""
            dem = dem + 1
        }
           // self.myList.removeAll()
        handle = rfDatabase.child("list").child("1").observe(.childAdded, with: { (snapshot) in
            
                
                if let item = snapshot.value as? String
                {
                    //self.myList.append(item)
                    //self.myTableView.reloadData()
                }
              //  self.myTableView.reloadData()
            
    })
    }
            
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
