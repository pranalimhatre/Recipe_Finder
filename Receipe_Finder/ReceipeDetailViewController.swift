//
//  ReceipeDetailViewController.swift
//  Receipe_Finder
//
//  Created by Pranali on 4/10/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit

class ReceipeDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var ReceipeSelected = Int()
    @IBOutlet var lblrcpname: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var recipeIngredient: UILabel!
    
    @IBOutlet var ingredientListTableView: UITableView!
    @IBOutlet var recipeInsruction: UILabel!
    @IBOutlet var recipeImageView: UIImageView!
    
    var ingredientList: [IngredientListRecipeDetailsPage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize.height = 700
        
        ingredientList = SQLDataIO.getIngredientListRecipeDetailPage(Index: ReceipeSelected)
        
        var recipeDetails: [RecipeDetailsPage] = []
        recipeDetails = SQLDataIO.getRecipeDetailPage(index: ReceipeSelected)
        
        //lblrcpname.text = String (ReceipeSelected)
        if (recipeDetails.count != 0){
            lblrcpname.text = recipeDetails[0].recipeName
            recipeImageView.image = UIImage(named: recipeDetails[0].recipeImage)
            recipeInsruction.text = recipeDetails[0].recipeInstruction
            recipeInsruction.numberOfLines = 0
            recipeInsruction.lineBreakMode = NSLineBreakMode.byWordWrapping
            recipeInsruction.sizeToFit()
            
        }
        
        
        
        ingredientListTableView.dataSource = self
        ingredientListTableView.delegate = self
        
        UIView.setAnimationsEnabled(false)
        self.ingredientListTableView.beginUpdates()
        self.ingredientListTableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableViewRowAnimation.none)
        self.ingredientListTableView.endUpdates()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ingredientList.count)    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailsIngredientListCell", for: indexPath) as! RecipeDetailTableViewCell
        
        cell.lbl_IngredientName.text = ingredientList[indexPath.row].ingredientName
        
        cell.lbl_IngredientMeasurement.text = ingredientList[indexPath.row].ingredientMeasurement
        return cell
        
        
        
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
