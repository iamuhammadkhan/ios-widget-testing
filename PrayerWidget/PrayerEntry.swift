//
//  PrayerEntry.swift
//  PrayerWidgetExtension
//
//  Created by Muhammad Khan on 5/11/21.
//

import SwiftUI
import WidgetKit
import Adhan

struct PrayerEntry: TimelineEntry {
    var date: Date
    let currentPrayerName: Prayer
    let currentPrayerTime: String
    let nextPrayerName: Prayer
    let nextPrayerTime: String
    let untilNextPrayerTime: String
    let nextPrayerImage: String
    let primaryTextColor: Color
    let highlightedTextColor: Color
    let prayers: [MyPrayer]
    
    static func mockPrayerEntry() -> Self {
        let prayers = [ MyPrayer(prayerName: "Fajr", prayerTime: "04:45", textColor: .white),
                        MyPrayer(prayerName: "Dhuhar", prayerTime: "12:55", textColor: .white),
                        MyPrayer(prayerName: "Asr", prayerTime: "16:50", textColor: .white),
                        MyPrayer(prayerName: "Maghrib", prayerTime: "17:05", textColor: .white) ]
        return PrayerEntry(date: Date(), currentPrayerName: Prayer.isha, currentPrayerTime: "20:25",
                           nextPrayerName: Prayer.fajr, nextPrayerTime: "04:45", untilNextPrayerTime: "0:20",
                           nextPrayerImage: "\(Prayer.isha)", primaryTextColor: .white, highlightedTextColor: Constants.lightBlueWidgetColor, prayers: prayers)
    }
}

struct MyPrayer {
    let prayerName: String
    let prayerTime: String
    let textColor: Color
}
