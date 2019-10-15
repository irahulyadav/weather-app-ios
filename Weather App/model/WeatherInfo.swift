//
//  WeatherInfo.swift
//  Weather App
//
//  Created by Rahul on 2019-10-15.
//  Copyright © 2019 AppsZum. All rights reserved.
//

import Foundation
import UIKit
class WeatherInfo: NSObject, Decodable {
    
    let time: Int64
    let summary: String
    let icon: String
    let precipIntensity: Double
    let precipProbability: Double
    let precipType: String
    let temperature: Double
    let humidity: Double
    let uvIndex: Int
    let visibility: Double
    
    //let image = UIImage(named: "\(icon).png")
    
    enum CodingKeys: String, CodingKey {
        case time, summary, icon, precipIntensity, precipProbability, precipType, temperature, humidity, uvIndex, visibility
    }
    
    public required  init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        time = try values.decode(Int64.self, forKey: .time)
        summary = try values.decode(String.self, forKey: .summary)
        icon = try values.decode(String.self, forKey: .icon)
        precipIntensity = try values.decode(Double.self, forKey: .precipIntensity)
        precipProbability = try values.decode(Double.self, forKey: .precipProbability)
        precipType = try values.decode(String.self, forKey: .precipType)
        temperature = try values.decode(Double.self, forKey: .temperature)
        humidity = try values.decode(Double.self, forKey: .humidity)
        uvIndex = try values.decode(Int.self, forKey: .uvIndex)
        visibility = try values.decode(Double.self, forKey: .visibility)
    }
    
    
}
