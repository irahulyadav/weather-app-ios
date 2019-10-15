//
//  LocationService.swift
//  Weather App
//
//  Created by Rahul on 2019-10-15.
//  Copyright © 2019 AppsZum. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
class LocationService: NSObject, CLLocationManagerDelegate {
    
    public let locationManager = CLLocationManager()
    public override init() {
        super.init()
    }
    
    private var granted: ((Bool, UIAlertController?) -> ())?
    
    public var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    public var checkPermission: Bool {
        let status = authorizationStatus
        return status == .authorizedWhenInUse || status == .authorizedAlways
    }
    
    public func alert(_ action: @escaping (Bool) -> ()) -> UIAlertController {
        return AlertView.actionSettingAlert(title: "location_service_disabled", id: "go_to_location_settings", action: { (open) in
            if (open) {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                UIApplication.shared.open(settingsUrl, options: [:]) { (success) in
                    print("Settings opened: \(success)")
                }
                return
            }
            action(open)
        })
    }
    
    // CLLocationManagerDelegate function
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let granted = self.granted else {
            return
        }
        granted(checkPermission, nil)
    }
    
    private func ask(_ delegate: CLLocationManagerDelegate, _ granted: @escaping (Bool, UIAlertController?) -> ()) {
        self.granted = granted
        switch authorizationStatus {
        case .notDetermined:
            locationManager.delegate = delegate
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            granted(false, alert({ (action) in
                granted(action, nil)
            }))
            
        case .authorizedWhenInUse, .authorizedAlways:
            DispatchQueue.main.async(execute: {
                granted(true, nil)
            })
        @unknown default: break
            
        }
    }
    
    public func ask(_ granted: @escaping (Bool, UIAlertController?) -> ()) {
        ask(self, granted)
    }
    
    func findCurrentLocation(_ viewController: UIViewController, action: @escaping (CLLocation?)->()) {
        findCurrentLocation { (location, alert) in
            guard let alert = alert else{
                action(location)
                return
            }
            viewController.present(alert, animated: false, completion: nil)
        }
    }
    
    func findCurrentLocation(action: @escaping (CLLocation?, UIAlertController?)->()) {
        if(checkPermission){
            action(CLLocationManager().location, nil)
            return
        }
        ask { (granted, alert) in
            if let alert = alert{
                action(nil, alert)
                return
            }
            action(CLLocationManager().location, nil)
        }
        
    }
    
}


public class AlertView {
    
    public static func actionSettingAlert(title: String, id message: String, action: @escaping (Bool) -> ()) -> UIAlertController {
        
        let alertController = UIAlertController(title: title.localized, message: message.localized, preferredStyle: .alert)
        
        alertController.view.tintColor = UIColor.colorPrimary
        alertController.view.backgroundColor = UIColor.white
        alertController.view.layer.cornerRadius = 15
        
        let attributedMessage = NSMutableAttributedString(
            string: "\n" + message.localized,
            attributes: [
                NSAttributedString.Key.font: UIFont.HelveticaNeue_Regular(),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
        alertController.setValue(attributedMessage, forKey: "attributedMessage")
        
        if let title = alertController.title {
            let attributedTitle = NSMutableAttributedString(
                string: title,
                attributes: [
                    NSAttributedString.Key.font: UIFont.HelveticaNeue_Light(size: IS_IPAD ? 24.0 : 21.0),
                    NSAttributedString.Key.foregroundColor: UIColor.colorPrimary
                ]
            )
            alertController.setValue(attributedTitle, forKey: "attributedTitle")
        }
        
        alertController.addAction( UIAlertAction(title: "cancel".localized, style: .default, handler: { (uiAc) in
            action(false)
        }))
        
        alertController.addAction( UIAlertAction(title: "settings".localized, style: .default, handler: { (uiAc) in
            action(true)
        }))
        return alertController
    }
}
