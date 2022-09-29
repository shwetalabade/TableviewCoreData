//
//  DatabaseHandler.swift
//  coredataDemo1
//
//  Created by Mac on 09/10/34.
//

import Foundation
import CoreData
import UIKit

class  DatabaseHandler
{
    
    func saveData(cName: String)
    {
        let appDe = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDe.persistentContainer.viewContext
        let countryObject = NSEntityDescription.insertNewObject(forEntityName: "Countrydata", into: context)  as! Countrydata
        countryObject.countryname = cName
        
        do{
            try context.save()
            print("data has been saved")
            
        }
        catch {
            print("Error has been occured save data")
        }
        
    }
    func fetchdata()->[Countrydata]
    {
        var cData = [Countrydata]()
        let appDe = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDe.persistentContainer.viewContext
        do{
            cData = try context.fetch(Countrydata.fetchRequest()) as! [Countrydata]
            
        }
        catch
        {
            
            print("Error oocured during fetch data")
            
        }
        return cData
    }
    
    
}
