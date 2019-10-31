//
//  WeatherApi.swift
//  Weather App
//
//  Created by Rahul on 2019-10-16.
//  Copyright © 2019 AppsZum. All rights reserved.
//

import Foundation
import CoreLocation
class WeatherApi {
    
    static func fetchWeather(location: CLLocation, _ action: @escaping (WeatherResponse?)->()) {
        DispatchQueue.global(qos: .background).async {
            do{
                
                if let url = URL(string:"https://api.darksky.net/forecast/2bb07c3bece89caf533ac9a5d23d8417/\(location.coordinate.latitude),\(location.coordinate.longitude)"), let json = try JSONSerialization.jsonObject(url: url){
                    DispatchQueue.main.async {
                        print(url)
                        print(json)
                        action(WeatherResponse.decode(items: json))
                    }
                }
                
            }catch{
                print(error)
            }
        }
    }
}
