//
//  WeatherInfoVC.swift
//  Weather App
//
//  Created by Rahul on 2019-10-15.
//  Copyright © 2019 AppsZum. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
class WeatherInfoVC: UIViewController {
    public static var viewController: WeatherInfoVC {
        return UIStoryboard(name: "WeatherInfoVC", bundle: Bundle(for: self)).instantiateViewController(withIdentifier: "WeatherInfoVC") as! WeatherInfoVC
    }
    var location: CLLocation?{
        didSet{
            guard let location = location else {
                return
            }
            WeatherApi.fetchWeather(location: location) { (response) in
                if let response = response{
                    self.response = response
                }
            }
            
        }
    }
    let locationService = LocationService()
    
    public var calendar = Locale(identifier:  Locale.current.languageCode == "sv" ? "sv_SE" : "en_SE").calendar
    
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lblProbability: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblSummery: UILabel!
    
    var response: WeatherResponse?{
        didSet{
            guard let response = response else {
                return
            }
            print(response)
            lblTemp.text = String(format: "%.0f", response.currently.temperature)
            lblPlace.text = response.timezone
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "h:mm a"
            if let timeZone = TimeZone(identifier: response.timezone){
                calendar.timeZone = timeZone
                dateFormat.calendar = calendar
            }
            
            lblTime.text = "At \(dateFormat.string(from: Date(timeIntervalSinceNow: TimeInterval(Double(response.currently.time * 1000))))) it will be"
            ivIcon.image = UIImage(named: "\(response.currently.icon).png")
            lblProbability.text = "\(String(format: "%.02f", response.currently.precipProbability * 100)) %"
            lblHumidity.text = String(response.currently.humidity)
            lblSummery.text = response.currently.summary
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationService.findCurrentLocation(self) { location in
            self.location = location
        }
    }
}


