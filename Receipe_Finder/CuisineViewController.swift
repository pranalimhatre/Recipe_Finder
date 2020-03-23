//
//  CuisineViewController.swift
//  Receipe_Finder
//
//  Created by Pranali on 4/8/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit

class CuisineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
let CuisineArry = ["Indian","Chinese", "Mediterranean","Italian","Mexican"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CuisineArry.count    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CuisineTableViewCell
        
       // var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        //if cell == nil {
          //  cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
      //  }
        cell.imgcuisinename.image = UIImage(named: CuisineArry[indexPath.row])
        cell.lblcuiinename.text = CuisineArry[indexPath.row]
        
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //let selection = tableView.cellForRow(at: indexPath)?.textLabel?.text
        
       let selection = CuisineArry[indexPath.row]
        performSegue(withIdentifier: "CuisineSegue", sender: selection )
       
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! CuisineListViewController
        guest.cuisineSelected = sender as!String
    }

}
