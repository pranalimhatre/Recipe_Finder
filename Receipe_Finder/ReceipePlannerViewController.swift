//
//  ReceipePlannerViewController.swift
//  Receipe_Finder
//
//  Created by Pranali on 4/7/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit
import UserNotifications

class ReceipePlannerViewController: UIViewController,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate {
    //var dateFormatter = DateFormatter()
    var selectedDate = Date()
    var selectedRecp = Double()
    var selectedmsg =  String()
    var selectrcpmsgdate = String()
    var selectedrcpname = String()
    var ReminderArray = [RecipeReminderDetails]()
   
    
    var ReciepeArray:[String] = [] //["Pizza","ChickenWings","Pasta","IceCreame","Beef","Pizza","ChickenWings","Pasta","IceCreame","Beef"]
    @IBOutlet var recptbleview: UITableView!
    @IBAction func btnSET(_ sender: UIButton) {
        let calendar = Calendar.current//Calendar(identifier: .gregorian)
        let datecal = calendar.date(byAdding: .hour, value: Int(-selectedRecp), to: selectedDate)
        var msg = String()
        
        if ( selectedrcpname == "")
        {
        msg = "Please Select Receipe"
        }
        else{
         msg = "Reminder is set for " + selectedrcpname + " on  " + selectrcpmsgdate
            scheduleNotification(at: datecal!,at:selectedmsg)
        }
       // let alert = UIAlertController(title: "Receipe Reminer", message: msg, preferredStyle: <#T##UIAlertControllerStyle#>)
        
       // let okbtn = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
       // alert.addAction(okbtn)
      //  present(presentedViewController!, animated: <#T##Bool#>, completion: nil)
        var alert = UIAlertController(title:"Receipe Reminder", message:msg, preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:nil))
        self.present(alert, animated:true, completion:nil)
    }
      
    @IBOutlet var RecpDt: UIDatePicker!
    @IBAction func recpDatePicker(_ sender: UIDatePicker) {

       // print(sender.date)
         selectedDate = sender.date
      scheduleNotification(at: selectedDate,at:"HIIIIIIII")
       // let calendar = Calendar.current//Calendar(identifier: .gregorian)
    //    print(-selectedRecp)
      //  print(selectedmsg)
      // let datecal = calendar.date(byAdding: .hour, value: Int(-selectedRecp), to: sender.date)
      //  print(datecal)
      
        
       var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-d-yyyy HH:mm"
       selectrcpmsgdate = dateFormatter.string(from: sender.date)
     // print(strDate)
        //  lblshow.text = strDate
       
    }
    func scheduleNotification(at date: Date,at msg:String) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Receipe Reminder"
        // content.body = "Just a reminder to read your tutorial over at appcoda.com!"
        content.body = msg
        content.sound = UNNotificationSound.default()
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
        
    }

    @IBOutlet var lblshow: UILabel!
    
    var filterecp = [String]()
    var searchctrl : UISearchController!
    var resultcontroller = UITableViewController()
    
    

    
   override func viewDidLoad() {
        super.viewDidLoad()
       ReminderArray = SQLDataIO.getRecipeReminderDetails()
    for i in 0..<ReminderArray.count
         {
            print(ReminderArray[i].recipeName)
        ReciepeArray.append(ReminderArray[i].recipeName)        }
        
    
        
        
        self.resultcontroller.tableView.dataSource = self
        self.resultcontroller.tableView.delegate = self
        self.searchctrl = UISearchController(searchResultsController: self.resultcontroller)
    self.recptbleview.tableHeaderView = self.searchctrl.searchBar
        self.searchctrl.searchResultsUpdater = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
       self.filterecp = self.ReciepeArray.filter { (ReciepeArray:String) -> Bool in
        if ReciepeArray.contains(self.searchctrl.searchBar.text!)
        {
            return true
        }
        else{
            return false
            }
        
        }
        self.resultcontroller.tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == recptbleview){
        return ReciepeArray.count
        }
        else{
            return filterecp.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
        }
        if (tableView == recptbleview){
           cell!.textLabel?.text = ReciepeArray[indexPath.row]        }
        else{
           cell!.textLabel?.text = filterecp[indexPath.row]
        }
        
        
        return cell!

       
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        
        selectedRecp = ReminderArray[indexPath.row].recipePrepTime
       selectedmsg = ReminderArray[indexPath.row].recipeReminderMsg
        selectedrcpname = ReminderArray[indexPath.row].recipeName
        //itemstopass.add(ingridient[indexPath.row])
        
    }
    
   
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
    }

}
