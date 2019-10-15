//
//  WeatherInfoVC.swift
//  Weather App
//
//  Created by Rahul on 2019-10-15.
//  Copyright © 2019 AppsZum. All rights reserved.
//

import Foundation
import UIKit
class WeatherInfoVC: UIViewController {
    public static var viewController: WeatherInfoVC {
        return UIStoryboard(name: "WeatherInfoVC", bundle: Bundle(for: self)).instantiateViewController(withIdentifier: "WeatherInfoVC") as! WeatherInfoVC
    }
}
