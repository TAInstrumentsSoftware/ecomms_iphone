//
//  InstrumentsTableViewController.swift
//  feathersjs_test
//
//  Created by stephen eshelman on 1/13/19.
//  Copyright © 2019 stephen eshelman. All rights reserved.
//

import UIKit

class InstrumentsTableViewController: UITableViewController {
   
   var _keys:Array<String>?

   override func viewDidLoad() {
      super.viewDidLoad()
      
      NotificationCenter.default.addObserver(
         self,
         selector: #selector(instrumentsChanged),
         name: Notification.Name("INSTRUMENTS_CHANGED"),
         object: nil)

      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

   @objc func instrumentsChanged() -> Void
   {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate

      _keys = Array((appDelegate._instruments?.keys)!)
      
      tableView.reloadData()
   }
   
   // MARK: - Table view data source

   override func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 1
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      let appDelegate = UIApplication.shared.delegate as! AppDelegate

      return (appDelegate._instruments?.count)!
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "instrumentCell", for: indexPath)

      // Configure the cell...
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      
      //cell.textLabel?.text = appDelegate._instruments?.first!.value["name"] as? String
      cell.textLabel?.text = appDelegate._instruments![_keys![indexPath.row]]!["name"] as? String
      cell.detailTextLabel?.text = appDelegate._instruments![_keys![indexPath.row]]!["location"] as? String

      var instrument = appDelegate._instruments![_keys![indexPath.row]]!
      if let signals = instrument["signals"] as? [Any]
      {
         if signals.count > 9
         {
            if let v = signals[9] as? Float
            {
               let label = UILabel.init(frame: CGRect(x:0,y:0,width:100,height:20))
               label.text = "\(v)"
               cell.accessoryView = label
            }
         }
      }
      
      return cell
    }

   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
      
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      
      var instrument =
         appDelegate._instruments![_keys![(tableView.indexPathForSelectedRow?.row)!]]
      
      
      if let controller = segue.destination as? InstrumentTabBarController
      {
         print("about to segue")
         controller._instrument = instrument
      }
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
