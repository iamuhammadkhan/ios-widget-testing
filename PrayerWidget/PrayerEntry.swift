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
    let nextPrayerDate: Date
    let prayers: [MyPrayer]
    
    static func mockPrayerEntry() -> Self {
        let prayers = [ MyPrayer(prayerName: "Fajr", prayerTime: "04:45", textColor: .white),
                        MyPrayer(prayerName: "Dhuhar", prayerTime: "12:55", textColor: .white),
                        MyPrayer(prayerName: "Asr", prayerTime: "16:50", textColor: .white),
                        MyPrayer(prayerName: "Maghrib", prayerTime: "17:05", textColor: .white) ]
        return PrayerEntry(date: Date(), currentPrayerName: Prayer.isha, currentPrayerTime: "20:25",
                           nextPrayerName: Prayer.fajr, nextPrayerTime: "04:45", untilNextPrayerTime: "0:20",
                           nextPrayerImage: "\(Prayer.isha)", primaryTextColor: .white, highlightedTextColor: Constants.lightBlueWidgetColor, nextPrayerDate: Date(), prayers: prayers)
    }
    
    static func createObject(_ prayers: PrayerTimes) -> Self {
        let currentDate = Date()
        let fajrTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.fajr))
        let dhuharTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.dhuhr))
        let asrTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.asr))
        let maghribTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.maghrib))
        let ishaTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.isha))
        if let nextPrayer = prayers.nextPrayer() {
            let nextPrayerDate = prayers.time(for: prayers.nextPrayer() ?? Prayer.fajr)
            let timeRemaining = PrayerManager.shared.getNextPrayerRemainingTime(nextPrayerDate)
            let timeRemainingText = "\(timeRemaining.hour ?? 0):\(timeRemaining.minute ?? 0)"
            switch nextPrayer {
            case .fajr:
                let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.fajr), nextPrayerName: Prayer.dhuhr, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.dhuhr), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.fajr)", primaryTextColor: .white, highlightedTextColor: .white, nextPrayerDate: nextPrayerDate, prayers: [MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: .white), MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: .white), MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: .white), MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: .white)])
                return prayerEntry
            case .dhuhr:
                let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.dhuhr), nextPrayerName: Prayer.asr, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.asr), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.dhuhr)", primaryTextColor: Constants.lightBlackWidgetColor, highlightedTextColor: .black, nextPrayerDate: nextPrayerDate, prayers: [MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Fajr", prayerTime: fajrTime, textColor: Constants.lightBlackWidgetColor)])
                return prayerEntry
            case .asr:
                let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.asr), nextPrayerName: Prayer.maghrib, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.maghrib), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.asr)", primaryTextColor: Constants.lightBlackWidgetColor, highlightedTextColor: .black, nextPrayerDate: nextPrayerDate, prayers: [MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Fajr", prayerTime: fajrTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: Constants.lightBlackWidgetColor)])
                return prayerEntry
            case .maghrib:
                let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.maghrib), nextPrayerName: Prayer.isha, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.isha), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.maghrib)", primaryTextColor: .white, highlightedTextColor: Constants.orangeWidgetColor, nextPrayerDate: nextPrayerDate, prayers: [MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: .white), MyPrayer(prayerName: "Fajr", prayerTime: fajrTime, textColor: .white), MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: .white), MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: .white)])
                return prayerEntry
            case .isha:
                let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.isha), nextPrayerName: Prayer.fajr, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.fajr), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.isha)", primaryTextColor: .white, highlightedTextColor: Constants.lightBlueWidgetColor, nextPrayerDate: nextPrayerDate, prayers: [MyPrayer(prayerName: "Fajr", prayerTime: fajrTime, textColor: .white), MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: .white), MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: .white), MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: .white)])
                return prayerEntry
            default:
                return mockPrayerEntry()
            }
        } else {
            let nextPrayerDate = prayers.time(for: Prayer.fajr)
            let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextPrayerDate)!
            let timeRemaining = PrayerManager.shared.getNextPrayerRemainingTime(nextDate)
            let timeRemainingText = "\(timeRemaining.hour ?? 0):\(timeRemaining.minute ?? 0)"
            
            let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: Prayer.fajr, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.fajr), nextPrayerName: Prayer.sunrise, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.sunrise), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.fajr)", primaryTextColor: .white, highlightedTextColor: .white, nextPrayerDate: nextPrayerDate, prayers: [MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: .white), MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: .white), MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: .white), MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: .white)])
            return prayerEntry
        }
    }
}

struct MyPrayer {
    let prayerName: String
    let prayerTime: String
    let textColor: Color
}
