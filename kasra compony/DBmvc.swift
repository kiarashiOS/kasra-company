//
//  DBmvc.swift
//  kasra compony
//
//  Created by Kiarash Karimian on 9/14/22.
//

import UIKit
import Foundation
import CoreData

var manage = [NSManagedObject]()
var context : NSManagedObjectContext?
var fetchR : NSFetchRequest<NSFetchRequestResult>?

class data {
 
// MARK: Fetch
    
    var fetchDB = {(code: UITextField)  in
      
        //use singlton
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         
        context = appDelegate.persistentContainer.viewContext
        
        fetchR = NSFetchRequest<NSFetchRequestResult>(entityName: "Regular")
        
        do {
            manage = try context!.fetch(fetchR!) as! [NSManagedObject]
          
                for data in manage {
            
                code.text = (data.value(forKey: "codesave") as! String)
                    
               }
            }
             catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
// MARK: Save
    var saveDB = {(code: UITextField)  in
        
        let entity =  NSEntityDescription.entity(forEntityName: "Regular", in: context!)
 
        let newUser = NSManagedObject(entity: entity!, insertInto: context)

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchR!)
        
            newUser.setValue(code.text, forKey: "codesave")
            do {
                try context!.save()
            }
             catch let error as NSError {
             print("Could not save. \(error), \(error.userInfo)")
            }
         }
      
   }
