//
//  Extention.swift
//  Weather App
//
//  Created by Rahul on 2019-10-15.
//  Copyright © 2019 AppsZum. All rights reserved.
//

import Foundation
import UIKit
extension UIAlertController {
    
    @objc public func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func show(_ vc: UIViewController, cancelable: Bool = true) {
        vc.present(self, animated: true) {
            if (!cancelable) {
                return
            }
            self.view.superview?.isUserInteractionEnabled = true
            self.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.close)))
        }
    }
}


extension String{
    public var localized: String {
        let localized: String = NSLocalizedString(self, comment: self)
        return localized.isEmpty ? self : localized
    }
}

extension UIFont {
    
    public static func HelveticaNeue_Light(size: CGFloat = IS_IPAD ? 20 : 17) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    }
    
    public static func HelveticaNeue_Regular(size: CGFloat = IS_IPAD ? 20 : 17) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    }
    
    public static func HelveticaNeue_Medium(size: CGFloat = IS_IPAD ? 20 : 17) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    }
}


public var IS_IPAD: Bool {
    return UIScreen.main.traitCollection.userInterfaceIdiom == .pad
}


extension UIColor{
    public static let colorPrimary: UIColor = UIColor(named: "colorPrimary")!
}

public typealias JSONObject = [String: Any]


extension JSONSerialization {
    //    public static func jsonObject(from data: Data, options: JSONSerialization.ReadingOptions) -> throws JSONObject {
    //        if let json = (try? JSONSerialization.jsonObject(with: data, options: options)) as? JSONObject {
    //            return json
    //        }
    //        return [:]
    //    }
    
    static func jsonObject(url: URL) throws -> JSONObject? {
        return try jsonObject(with: try Data(contentsOf: url), options: []) as? JSONObject
    }
}
