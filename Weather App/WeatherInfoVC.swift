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
            fetchWeather(location: location) { (response) in
                if let response = response{
                    self.response = response
                }
            }
            
        }
    }
    let locationService = LocationService()
    
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
            lblTime.text = "At \("ff") it will be"
            ivIcon.image = UIImage(named: "\(response.currently.icon).png")
            lblProbability.text = "\(String(format: "%.02f", response.currently.precipProbability * 100)) %"
            lblHumidity.text = String(response.currently.humidity)
            lblSummery.text = response.currently.summary
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService.findCurrentLocation(self) { location in
            self.location = location
        }
    }
    
    func fetchWeather(location: CLLocation, _ action: @escaping (WeatherResponse?)->()) {
        DispatchQueue.global(qos: .background).async {
            do{
                if let json = try JSONSerialization.jsonObject(url: URL(string: "https://api.darksky.net/forecast/2bb07c3bece89caf533ac9a5d23d8417/\(location.coordinate.latitude),\(location.coordinate.longitude)")!){
                    DispatchQueue.main.async {
                        action(WeatherResponse.decode(items: json))
                    }
                }
                
            }catch{
                print(error)
            }
        }
    }
}


