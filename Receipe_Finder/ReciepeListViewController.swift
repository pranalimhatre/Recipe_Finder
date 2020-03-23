//
//  ReciepeListViewController.swift
//  Receipe_Finder
//
//  Created by Pranali on 4/7/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit

class ReciepeListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var recipeList: [RecipeDetails] = []
    var  selection = Int()
 
    @IBOutlet var lblselection: UILabel!
    @IBOutlet var tblRcpList: UITableView!
    
    
    var dt  = String()
    var ingredientIdList = String()
    
    var arry = NSMutableArray()
    //let lblext = 0
    //let rcpimg = ["Pizza"]
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in arry
        {
          //  for item in arry
           // {
           //     dt += item  as! String
           // }
           dt += String(describing: item) + " "
            if (ingredientIdList == ""){
                ingredientIdList = String(describing: item)
            }
            else{
                ingredientIdList += ","+String(describing: item)
            }
        }
        
        
        recipeList = SQLDataIO.fetchRecipeDetails(ingredientList: ingredientIdList)
        
        //lblselection.text = dt
        tblRcpList.dataSource = self
         tblRcpList.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return rcpimg.count
        return recipeList.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeListTableViewCell
        
        cell.imgRcp.image = UIImage(named: recipeList[indexPath.row].recipeImage)
        cell.lblrcpname.text = recipeList[indexPath.row].recipeName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let selection = tableView.cellForRow(at: indexPath)?.textLabel?.text
         selection = recipeList[indexPath.row].recipeId
//recipeList[indexPath.row].recipeId
        performSegue(withIdentifier: "ReceipeDetaileSegue", sender: selection )

        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! ReceipeDetailViewController
        guest.ReceipeSelected = sender as!Int
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
