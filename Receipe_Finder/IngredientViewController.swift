//
//  IngredientViewController.swift
//  Receipe_Finder
//
//  Created by Pranali on 4/7/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit
struct Section {
    var name: String!
    var items: [String]!
    var ingredientId: [String]!
    var ingredientImage: [String]!
    var collapsed: Bool!
    
    init(name: String, items: [String], collapsed: Bool = false, ingredientId: [String], ingredientImage: [String]) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
        self.ingredientId = ingredientId
        self.ingredientImage = ingredientImage
    }
}

class IngredientViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBAction func nxt(_ sender: UIButton) {
         performSegue(withIdentifier: "IngredientSegue", sender: selectedItem)
        
    }
    
    @IBOutlet var tblViewIngri: UITableView!
    var sections = [Section]()
     var ingredientCategory: [Category] = []
     var selectedItem = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientCategory = SQLDataIO.fetchIngredientCategory()
        
        
        for i in 0..<ingredientCategory.count{
            let index = ingredientCategory[i].categoryId
            sections.append(Section(name: ingredientCategory[i].categoryName, items: SQLDataIO.getIngredientName(index: index!), ingredientId: SQLDataIO.getIngredientId(index: index!), ingredientImage: SQLDataIO.getIngredientImage(index: index!)))
            
        }
        
        tblViewIngri.dataSource = self
        tblViewIngri.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sections[section].items.count)    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
        
       // cell.IMGingridnt.image = UIImage(named: sections[indexPath.section].items[indexPath.row]+".jpg" )
      //  var imageName =
        //var image = UIImage(named: sections[indexPath.section].items[indexPath.row])
        //let imageView = UIImageView(image: image!)
       // var imgname =
       // cell.IMgingri.image = UIImage(named:sections[indexPath.section].items[indexPath.row]+".png")
       
        let img = sections[indexPath.section].ingredientImage[indexPath.row]
        //let endIndex = img.index(img.startIndex, offsetBy: img.characters.count)
        //let StartIndex = img.index(img.endIndex, offsetBy: -(img.characters.count - 1))
        //let range = StartIndex..<endIndex
    //   img = img.substring(with: range)
        cell.IMgingri.image = UIImage(named: img)
        
        cell.lblIngri.text = sections[indexPath.section].items[indexPath.row]
        return cell

        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        let label = UILabel()
        label.text = sections[section].name
        label.frame = CGRect(x: 35, y: 5, width: 100, height: 35)
        label.textColor = UIColor.white
        view.addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // performSegue(withIdentifier: "myingri", sender: ingridient[indexPath.row])
        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark)
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            
            selectedItem.remove(sections[indexPath.section].ingredientId[indexPath.row])
            print(sections[indexPath.section].ingredientId[indexPath.row])
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            //itemstopass.add(ingridient[indexPath.row])
            
            selectedItem.add(sections[indexPath.section].ingredientId[indexPath.row])
            print(sections[indexPath.section].ingredientId[indexPath.row])
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! ReciepeListViewController
        
        guest.arry = sender as!NSMutableArray
    }
    

}
