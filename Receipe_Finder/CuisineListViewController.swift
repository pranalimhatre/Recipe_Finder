//
//  CuisineListViewController.swift
//  Receipe_Finder
//
//  Created by Pranali on 4/8/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit

class CuisineListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
var cuisineSelected = String()
    
    @IBOutlet var lblcu: UILabel!
    
    @IBOutlet var ListTblVw: UITableView!
    let arrayVideo = ["https://www.youtube.com/embed/r-OLJZ8z9OQ","https://www.youtube.com/embed/cs1z31m-0-U","https://www.youtube.com/embed/r-OLJZ8z9OQ","https://www.youtube.com/embed/cs1z31m-0-U","https://www.youtube.com/embed/r-OLJZ8z9OQ","https://www.youtube.com/embed/cs1z31m-0-U"]
    
let IndianVideo = ["https://www.youtube.com/embed/T5tCiHGjEbk","https://www.youtube.com//embed/nF0x3fY_Xqg","https://www.youtube.com/embed/iJUdcbCoIcA","https://www.youtube.com//embed/eidZ9bjABP0","https://www.youtube.com//embed/v=_V6hdyV3k7w"]
    
    
    let med = ["https://www.youtube.com/embed/LhZ-5y8eTZk","https://www.youtube.com/embed/0IazCdINze0","https://www.youtube.com/embed/foB6bxhZYF0"]
    
    let chins = ["https://www.youtube.com/embed/J6xFRlG5Qxg","https://www.youtube.com/embed/hqWkaYZ6cWA",
                 "https://www.youtube.com/embed/VjneaJ0hmgs"]
    
    let ita = ["https://www.youtube.com/embed/Nbx6N_lqN3w","https://www.youtube.com/embed/XAHNVoKV1Bc",
               "https://www.youtube.com/embed/6fe0ZZhOBxc"]
    
   let mex = ["https://www.youtube.com/embed/99xkJVhJxz0",
              "https://www.youtube.com/embed/OEfzgobszUA","https://www.youtube.com/embed/LqYrW0rJSOY"]
    override func viewDidLoad() {
        super.viewDidLoad()
//lblcu.text = cuisineSelected
        
        ListTblVw.register(UINib(nibName: "YoutTubeVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "YoutTubeVideoTableViewCell")
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YoutTubeVideoTableViewCell", for: indexPath) as! YoutTubeVideoTableViewCell
        //var youtubeURL = String()
       var  youtubeURL=arrayVideo[indexPath.row]
        if (cuisineSelected == "Indian")
        {
         youtubeURL = IndianVideo[indexPath.row]}
        else if (cuisineSelected == "Mediterranean")
        {
         youtubeURL = med[indexPath.row]}
else if (cuisineSelected == "Chinese")
        {youtubeURL = chins[indexPath.row]
    
        }
        else if(cuisineSelected == "Italian")
        {
        
        youtubeURL = ita[indexPath.row]}
        else if (cuisineSelected == "Mexican")
        {
            youtubeURL = mex[indexPath.row]
        }
    
        
        let requestURL = URL(string: youtubeURL)
        let request = URLRequest(url: requestURL!)
        cell.webView1.allowsInlineMediaPlayback = false
        cell.webView1.loadRequest(request)
        cell.webView1.scrollView.isScrollEnabled = false
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
