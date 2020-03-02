//
//  Structures.swift
//  CityWeather
//
//  Created by Артём Фурсов on 22.02.2020.
//  Copyright © 2020 Артём Фурсов. All rights reserved.
//

import Foundation

let apiKey = "rSAE19rP0zPYCKCiiuguxqwvqmKlvGKo"

struct CityComplete: Codable {
    var Key: String
    var LocalizedName: String
}


struct forcast: Codable {
    let DailyForecasts: [DailyForecasts]
}

struct DailyForecasts :Codable {
    let Day: Day
    let Night: Night
    let Temperature: Temperature
        }
struct Temperature: Codable {
    let Minimum: Minimum
    let Maximum: Maximum
}

struct Minimum: Codable{
    let Value: Double
}

struct Maximum: Codable{
    let Value: Double
}

struct Day: Codable {
    let Icon: Int
    let IconPhrase: String
}

struct Night: Codable {
    let Icon: Int
    let IconPhrase: String
}

struct cityCoordinates: Codable {
    let GeoPosition: GeoPosition
}
struct GeoPosition: Codable {
    let Latitude: Double
    let Longitude: Double
}
