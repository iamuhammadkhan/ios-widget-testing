//
//  Constants.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/19/21.
//

import UIKit
import SwiftUI

struct Constants {
    static let moonImageIconName = "moon_icon"
    static let locationLatKey = "locationLatitudeKey"
    static let locationLngKey = "locationLongitudeKey"
    static let prayerTimeRemainingText = "until athan"
    static let nextPrayerText = "Next Prayer"
    
    static let lightBlueWidgetColor: Color = {
        return Color(red: 146 / 255, green: 212 / 255, blue: 251 / 255)
    }()
    
    static let orangeWidgetColor: Color = {
        return Color(red: 229 / 255, green: 151 / 255, blue: 100 / 255)
    }()
    
    static let lightBlackWidgetColor: Color = {
        return Color(red: 92 / 255, green: 105 / 255, blue: 132 / 255)
    }()
}
