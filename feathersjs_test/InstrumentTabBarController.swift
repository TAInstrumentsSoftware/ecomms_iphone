//
//  InstrumentTabBarController.swift
//  feathersjs_test
//
//  Created by stephen eshelman on 1/14/19.
//  Copyright © 2019 stephen eshelman. All rights reserved.
//

import UIKit

class InstrumentTabBarController: UITabBarController {
   
   var _instrument:[String: Any]?
   {
      set(i){
         
         for controller in viewControllers!
         {
            var c = controller as? InstrumentViewControllerDelegate
            if c != nil
            {
               c!.instrument = i!
            }
         }
      }
      
      get{
         return nil
      }
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
   }
   
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
   }
}
