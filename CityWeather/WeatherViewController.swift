//
//  WeatherViewController.swift
//  CityWeather
//
//  Created by Артём Фурсов on 22.02.2020.
//  Copyright © 2020 Артём Фурсов. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class WeatherViewController: UIViewController {

    var cityName: String!
    var cityKey: String = ""
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var todayday: UIImageView!
    
    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var todayWeatherCondition: UILabel!
    
    @IBOutlet weak var tomorrowWeatherCondition: UILabel!
    @IBOutlet weak var tomorrowday: UIImageView!
    @IBOutlet weak var tomorrowTempLabel: UILabel!
    
    override func viewDidLoad() {
               super.viewDidLoad()
        cityLabel.text = cityName
        
        let urlString = "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(cityKey)?apikey=\(apiKey)&language=ru-ru"

        //Request
            guard let url = URL(string: urlString) else {
                print("url error")
                return}
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("data error")
                        return
                    }
                    guard let data = data else {return}
                    let jsonstring = String(data: data, encoding: .utf8)
                    print (jsonstring ?? "no data")

        let jsonData = Data(jsonstring!.utf8)
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            
            let weatherForecast = try decoder.decode(forcast.self, from: jsonData)
            self.tempLabel.text = "\(String (Int((weatherForecast.DailyForecasts[0].Temperature.Maximum.Value - 32.0) * 5.0 / 9.0))) °C"
            self.tomorrowTempLabel.text = "\(String (Int((weatherForecast.DailyForecasts[1].Temperature.Maximum.Value - 32.0) * 5.0 / 9.0))) °C"
            self.viewWillAppear(true)
            self.todayWeatherCondition.text = "Сегодня, \(weatherForecast.DailyForecasts[0].Day.IconPhrase)"
            self.tomorrowWeatherCondition.text = "Завтра, \(weatherForecast.DailyForecasts[1].Day.IconPhrase)"
            
            let todayDayImg = weatherForecast.DailyForecasts[0].Day.Icon
            let imageURL: String!
            if todayDayImg < 9
            
            {
            imageURL = "https://developer.accuweather.com/sites/default/files/0\(todayDayImg)-s.png"
            }
            
            else {
                imageURL = "https://developer.accuweather.com/sites/default/files/\(todayDayImg)-s.png"
            }
            
            let imgurl = URL(string: imageURL)
            let data = NSData(contentsOf: imgurl!)
            self.todayday.image = UIImage(data: data! as Data)
            
            let tomarrowDayIng = weatherForecast.DailyForecasts[1].Day.Icon
            let imageURL2: String!
            if tomarrowDayIng < 9
            
            {
            imageURL2 = "https://developer.accuweather.com/sites/default/files/0\(tomarrowDayIng)-s.png"
            }
            
            else {
                imageURL2 = "https://developer.accuweather.com/sites/default/files/\(tomarrowDayIng)-s.png"
            }
            
            let imageurl2 = URL(string: imageURL2)
            let data2 = NSData(contentsOf: imageurl2!)
            self.tomorrowday.image = UIImage(data: data2! as Data)
            
        } catch {
            print(error.localizedDescription)
                    }
                }
        }.resume()
        
        //Преобразование кириллицы
              if let data = cityName.data(using: .utf8) {
              let encoded = data.map { String(format: "%%%02hhX", $0) }.joined()
              
        
                let urlString2 = "http://dataservice.accuweather.com/locations/v1/cities/search?apikey=\(apiKey)&q=\(encoded)&language=ru-ru"
        

        //Request
            guard let url2 = URL(string: urlString2) else {
                print("url error")
                return}
            URLSession.shared.dataTask(with: url2) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("data error")
                        return
                    }
                    guard let data = data else {return}
                    let jsonstring2 = String(data: data, encoding: .utf8)
                    print (jsonstring2 ?? "no data")

        let jsonData = Data(jsonstring2!.utf8)
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            
            let coordinates = try decoder.decode([cityCoordinates].self, from: jsonData)
            
            DispatchQueue.main.async {

            
            let geocoordinates = CLLocationCoordinate2DMake(coordinates[0].GeoPosition.Latitude, coordinates[0].GeoPosition.Longitude)
            print(geocoordinates)
            let span = MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7)
            let region = MKCoordinateRegion(center:geocoordinates, span: span)
            print (span)
                self.MapView.region = region
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = geocoordinates
            annotation.title = self.cityName
            self.MapView.addAnnotation(annotation)
            
            self.viewWillAppear(true)
            }
        } catch {
            print(error.localizedDescription)
                    }
                }
                                
        }.resume()
    }
    

}
}
