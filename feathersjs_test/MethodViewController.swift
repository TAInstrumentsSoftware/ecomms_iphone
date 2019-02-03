//
//  MethodViewController.swift
//  feathersjs_test
//
//  Created by stephen eshelman on 1/17/19.
//  Copyright © 2019 stephen eshelman. All rights reserved.
//

import UIKit
import Feathers
import FeathersSwiftRest
import SocketIO
import FeathersSwiftSocketIO

class MethodViewController: UIViewController, InstrumentViewControllerDelegate {

   var _instrument:[String: Any]?
   var instrument: [String : Any]
   {
      get{
         return self._instrument!
      }
      set(i){
         self._instrument = i
      }
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   @IBAction func onStart(_ sender: UIButton) {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let service = appDelegate._is;
      
      let query = Query().eq(property: "action", value: "action")
      
      service!.request(.update(
         id: (instrument["id"] as! String),
         data: [:],
         query: query))
         .start()
   }
   
   @IBAction func onStop(_ sender: UIButton) {
   }
   
   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
