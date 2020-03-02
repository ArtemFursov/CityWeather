//
//  Showplace+CoreDataProperties.swift
//  CityWeather
//
//  Created by Артём Фурсов on 02.03.2020.
//  Copyright © 2020 Артём Фурсов. All rights reserved.
//
//

import Foundation
import CoreData


extension Showplace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Showplace> {
        return NSFetchRequest<Showplace>(entityName: "Showplace")
    }

    @NSManaged public var desc: String?
    @NSManaged public var descFull: String?
    @NSManaged public var image: URL?
    @NSManaged public var lan: Double
    @NSManaged public var lon: Double
    @NSManaged public var showplaceName: String?
    @NSManaged public var city: City?

}
