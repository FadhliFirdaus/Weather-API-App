//
//  Helper.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import Foundation
import UIKit

extension UIScreen {
    static let sw = UIScreen.main.bounds.size.width
    static let sh = UIScreen.main.bounds.size.height
}

let w = UIScreen.sw
let h = UIScreen.sh

extension Double {
    func decimalPlaces(_ decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}

extension UIScreen {
    static var topSafeArea: CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return (keyWindow?.safeAreaInsets.top) ?? 0
    }
}
