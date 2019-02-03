//
//  AppDelegate.swift
//  feathersjs_test
//
//  Created by stephen eshelman on 1/13/19.
//  Copyright © 2019 stephen eshelman. All rights reserved.
//

import UIKit
import Feathers
import FeathersSwiftRest
import SocketIO
import FeathersSwiftSocketIO

protocol InstrumentViewControllerDelegate
{
   var instrument:[String: Any] {get set}
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?
   var _fr:Feathers?
   var _fa:Feathers?
   var _manager:SocketManager?
   var _provider:SocketProvider?
   var _is:ServiceType?
   var _instrumentService:ServiceType?
   var _instruments:Dictionary<String, [String: Any]>?
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
      
      //let feathersRestApp = Feathers(provider: provider)
      
      _instruments = Dictionary<String, [String: Any]>()
      
      ///////////REST TEST
      //let url = URL(string:"http://192.168.86.149:3030")
      let url = URL(string:"http://10.52.56.225:3030")

      _fr = Feathers(provider: RestProvider(baseURL: url!))
      _instrumentService = _fr!.service(path: "instruments")
      
      _instrumentService!.request(.find(query: Query()))
         .on(value:{ response in
            print("service response:")
            //print(response.data.value)
            
            if let instruments = response.data.value as? [[String: Any]] {
               //if let data = dataTotal.first {
               //   print("RESPONSE DATA: \(data["id"] ?? "unknown")")
               //}
               for instrument in instruments
               {
                  print(instrument["id"]!)
                  
                  if let id = instrument["id"] as? String
                  {
                     self._instruments![id] = instrument
                  }
               }
            }
         })
         .start()
      
//      service.request(.find(query: Query()
//         .eq(property: "id", value: "ae8fd29b-5096-43e7-bc17-9591675be9ee")
//         ))
//         .on(value:
//            { data in
//
//               if let response = data.data.value as? [[String: Any]]{
//                  print("service response:")
//                  print(response[0])
//               }
//         })
//         .start()


      ///////////
      
      /////////////////////FEATHERS TEST
      _manager = SocketManager(socketURL: url!, config: [.log(false), .compress])
      _provider = SocketProvider(manager: _manager!, timeout: 5)

      _fa = Feathers(provider: _provider!)
      _is = _fa!.service(path: "instruments")
      
      _is!.request(.find(query: Query()))
         .on(value:
         { response in
            print("socket service response:")
            //print(response)
         })
         .start()
      
      _is!.on(event: .updated)
         .observeValues
         { instrument in
            
            //print("\(instrument["id"]!) \(instrument["currentTemperature"]!)")
         
            if let signals = instrument["signals"] as? [Any]
            {
               if signals.count > 9
               {
                  if let v = signals[9] as? Float
                  {
                     print(v)
                  }
               }
            }
            
            if let signalNames = instrument["signalNames"] as? [String]
            {
               if signalNames.count > 9
               {
                  print(signalNames[9])
               }
            }
            
            if let id = instrument["id"] as? String
            {
               self._instruments![id] = instrument
            }
            
            NotificationCenter.default.post(name: Notification.Name("INSTRUMENTS_CHANGED"), object: nil)
            
//            self._is!.request(.find(query: Query()
//               .eq(property: "id", value: "ae8fd29b-5096-43e7-bc17-9591675be9ee")
//               ))
//               .on(value:
//                  { response in
//                     print("response")
//               })
//               .start()
            
         }
      
      _is!.on(event: .created)
         .observeValues
         { instrument in
            
            print("CREATED \(instrument["id"]!) \(instrument["currentTemperature"]!)")
            
            if let id = instrument["id"] as? String
            {
               self._instruments![id] = instrument
            }
         }

      _is!.on(event: .removed)
         .observeValues
         { instrument in
            
            print("REMOVED \(instrument["id"]!) \(instrument["currentTemperature"]!)")
            
            if let id = instrument["id"] as? String
            {
               self._instruments!.removeValue(forKey: id)
            }
      }
      //////////////////////////////////
      
      return true
   }

   func applicationWillResignActive(_ application: UIApplication) {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
   }

   func applicationDidEnterBackground(_ application: UIApplication) {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   }

   func applicationWillEnterForeground(_ application: UIApplication) {
      // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
   }

   func applicationDidBecomeActive(_ application: UIApplication) {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   }

   func applicationWillTerminate(_ application: UIApplication) {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   }
}

extension Notification.Name {
   static let didReceiveData = Notification.Name("didReceiveData")
   static let didCompleteTask = Notification.Name("didCompleteTask")
   static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}

