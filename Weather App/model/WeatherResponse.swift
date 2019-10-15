//
//  WeatherResponse.swift
//  Weather App
//
//  Created by Rahul on 2019-10-15.
//  Copyright © 2019 AppsZum. All rights reserved.
//

import Foundation
class WeatherResponse: NSObject, Decodable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currently: WeatherInfo
    
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude, timezone, currently, precipProbability, precipType, temperature, humidity, uvIndex, visibility
    }
    
    public required  init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        timezone = try values.decode(String.self, forKey: .timezone)
        currently = try values.decode(WeatherInfo.self, forKey: .currently)
    }
    
    
    public static func decode(items: JSONObject) -> WeatherResponse? {
        do{
            let list =  try JSONDecoder().decode(WeatherResponse.self, from: JSONSerialization.data(withJSONObject: items, options: []))
            return list
            
        }catch{
            print(error)
        }
        return nil
    }
    
}
