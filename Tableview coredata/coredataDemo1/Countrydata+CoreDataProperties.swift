//
//  Countrydata+CoreDataProperties.swift
//  coredataDemo1
//
//  Created by Mac on 09/10/34.
//
//

import Foundation
import CoreData


extension Countrydata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Countrydata> {
        return NSFetchRequest<Countrydata>(entityName: "Countrydata")
    }

    @NSManaged public var countryname: String?

}

extension Countrydata : Identifiable {

}
