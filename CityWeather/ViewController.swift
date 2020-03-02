//
//  ViewController.swift
//  CityWeather
//
//  Created by Артём Фурсов on 20.02.2020.
//  Copyright © 2020 Артём Фурсов. All rights reserved.
//

import UIKit
import CoreData

//массив для выгрузки списка городов из поиска
var city:Array? = []
var city_Keys:Array? = []
var city_key:String = "city_key"
var city_name:String = "city_name"

//классы для работы с tableview
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if city != nil {return city!.count} else {
            city![0]=""
            return 1}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CityList.dequeueReusableCell(withIdentifier: "cell_id", for: indexPath)
        if city != nil {cell.textLabel?.text = city![indexPath.row] as? String}
        
            return cell
    }
    
    @IBAction func action_button(_ sender: Any) {
        
        //переход на следующий view controller передачей названия города и ключа для создания дальнейших запросов
        
        let newVC = storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        newVC.cityKey = city_key
        newVC.cityName = city_name
           navigationController?.pushViewController(newVC, animated: true)
    }
    //активация перехода на следующий view controller по нажатию на строку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if city_Keys?[indexPath.row] != nil && city?[indexPath.row] != nil {
        city_key = city_Keys![indexPath.row] as! String
            city_name = city![indexPath.row] as! String
            self.action_button(self)
        print(city![indexPath.row])
        print(city_key)
            
        }
        else {
           
            print("Request Error")
            
            return}
        }
         
    //Функция обновления таблицы
override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(true)
                 CityList.reloadData()
             }
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var CityList: UITableView!

  //  var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate=self
               
    }

}
    extension ViewController:UISearchBarDelegate {
    
         func searchBarSearchButtonClicked(_ SearchBar: UISearchBar) {
         SearchBar.resignFirstResponder()} //убираем клавиатуру по нажатию на "Поиск"
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
        {

        //API and url
        
        let request = SearchBar.text!
        
       //Преобразование кириллицы
       if let data = request.data(using: .utf8) {
       let encoded = data.map { String(format: "%%%02hhX", $0) }.joined()
       
        
        let urlString = "http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=\(apiKey)&q=\(encoded)&language=ru-ru"
        

        //Request
            guard let url = URL(string: urlString) else {
                
                print("url error")
                return}
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        InternetConnectionAlert()
                        print("data error")
                        return
                    }
                    guard let data = data else {
                        InternetConnectionAlert()
                        return}
                    let jsonstring = String(data: data, encoding: .utf8)
                    print (jsonstring ?? "no data")
                    
        let jsonData = Data(jsonstring!.utf8)
        
        //Парсинг джейсона с добавлением данных в таблицу результатов поиска
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            city?.removeAll()
            city_Keys?.removeAll()
            let city_list = try decoder.decode([CityComplete].self, from: jsonData)
            for i in city_list {
                city!.append(i.LocalizedName)
                city_Keys!.append(i.Key)
            }
            self.viewWillAppear(true)
            print(city_list)
        } catch {
            print(error.localizedDescription)
            if searchBar.text != ""
            {InternetConnectionAlert ()}
                    }
                }
        }.resume()
        }
            //Функция для вывода ошибок интернет соединения
            func InternetConnectionAlert ()
            {
                let alert = UIAlertController (title: "Ошибка", message: "Отсутствует интернет соединение или превышен лимит подключений", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog ("InternetConnectionAlert")
                }))
                present(alert, animated: true, completion: nil)
            }

            
        }
}
       
       
              

