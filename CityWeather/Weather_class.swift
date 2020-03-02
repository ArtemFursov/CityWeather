//
//  Weather_class.swift
//  CityWeather
//
//  Created by Артём Фурсов on 20.02.2020.
//  Copyright © 2020 Артём Фурсов. All rights reserved.
//

import Foundation

class weather {
    let CityName: String
   // let NowDate: Data
   // let NowTemp: Double
    let NowCondition: String
   // let TomorrowDate: Data
   // let TomorrowTemp: Double
   // let TomorrowCondition: String
    
    init(CityName: String,/* NowDate: Data, NowTemp: Double,*/ NowCondition: String/*, TomorrowDate: Data, TomorrowTemp: Double, TomorrowCondition: String*/) {
        self.CityName = CityName
       // self.NowDate = NowDate
       // self.NowTemp = NowTemp
        self.NowCondition = NowCondition
     //   self.TomorrowDate = TomorrowDate
     //   self.TomorrowTemp = TomorrowTemp
      //  self.TomorrowCondition = TomorrowCondition
    }
}
