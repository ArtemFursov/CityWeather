//
//  City+CoreDataProperties.swift
//  CityWeather
//
//  Created by Артём Фурсов on 02.03.2020.
//  Copyright © 2020 Артём Фурсов. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var showplace: NSSet?

}

// MARK: Generated accessors for showplace
extension City {

    @objc(addShowplaceObject:)
    @NSManaged public func addToShowplace(_ value: Showplace)

    @objc(removeShowplaceObject:)
    @NSManaged public func removeFromShowplace(_ value: Showplace)

    @objc(addShowplace:)
    @NSManaged public func addToShowplace(_ values: NSSet)

    @objc(removeShowplace:)
    @NSManaged public func removeFromShowplace(_ values: NSSet)

}
