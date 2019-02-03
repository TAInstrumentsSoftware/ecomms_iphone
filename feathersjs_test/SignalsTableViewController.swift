//
//  SignalsTableViewController.swift
//  feathersjs_test
//
//  Created by stephen eshelman on 1/14/19.
//  Copyright © 2019 stephen eshelman. All rights reserved.
//

import UIKit

class SignalsTableViewController: UITableViewController, InstrumentViewControllerDelegate {
   var signals:[Float]?
   var signalNames:[String]?
   
   var _instrument:[String: Any]?
   var instrument: [String : Any]
   {
      get{
         return self._instrument!
      }
      set(i){
         self._instrument = i
         
         signals = [Float]()
         //signals?.append(7.77)   //Array((i["signals"] as? [Float])!)
         
         for a in (i["signals"] as? [Any])!
         {
            if let v = a as? Float
            {
               signals?.append(v)
            }
            else
            {
               signals?.append(0)
            }
         }
         
         signalNames = Array((i["signalNames"] as? [String])!)
         
         tableView.reloadData()
      }
   }
   
   @objc func instrumentsChanged() -> Void
   {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      instrument = appDelegate._instruments![(_instrument!["id"] as? String)!]!
      //tableView.reloadData()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false
      
      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem
      
      NotificationCenter.default.addObserver(
         self,
         selector: #selector(instrumentsChanged),
         name: Notification.Name("INSTRUMENTS_CHANGED"),
         object: nil)
   }
   
   // MARK: - Table view data source
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 1
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return (signalNames?.count)!
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "signalCell", for: indexPath)
      
      // Configure the cell...
      cell.textLabel?.text = signalNames![indexPath.row]
      cell.detailTextLabel?.text = "\(signals![indexPath.row])"
      
      return cell
   }
   
   // MARK: - Navigation
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
      
   }
   
   /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
   
   /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    // Delete the row from the data source
    tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
   
   /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    
    }
    */
   
   /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
}
