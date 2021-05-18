//
//  PrayerEntry.swift
//  PrayerWidgetExtension
//
//  Created by Muhammad Khan on 5/11/21.
//

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
    
    static func mockPrayerEntry() -> Self {
        return PrayerEntry(date: Date(), currentPrayerName: Prayer.fajr, currentPrayerTime: "4:55 AM", nextPrayerName: Prayer.dhuhr, nextPrayerTime: "12:45 PM", untilNextPrayerTime: "20min", nextPrayerImage: "\(Prayer.fajr)")
    }
}
