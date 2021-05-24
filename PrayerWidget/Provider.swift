//
//  Provider.swift
//  PrayerWidgetExtension
//
//  Created by Muhammad Khan on 5/11/21.
//

import WidgetKit
import CoreLocation
import Adhan

struct Provider: TimelineProvider {
    typealias Entry = PrayerEntry
    
    func placeholder(in context: Context) -> PrayerEntry {
        PrayerEntry.mockPrayerEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (PrayerEntry) -> ()) {
        let entry = PrayerEntry.mockPrayerEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        WidgetCenter.shared.reloadAllTimelines()
        var entries = [PrayerEntry]()
        let currentDate = Date()
        let location = LocationManager.shared.getLocation()
        if let prayers = PrayerManager.shared.getPrayers(location) {
            let fajrTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.fajr))
            let dhuharTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.dhuhr))
            let asrTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.asr))
            let maghribTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.maghrib))
            let ishaTime = PrayerManager.shared.getPrayerTimeString(prayers.time(for: Prayer.isha))
            if let nextPrayer = prayers.nextPrayer() {
                let nextPrayerDate = prayers.time(for: nextPrayer)
                let timeRemaining = PrayerManager.shared.getNextPrayerRemainingTime(nextPrayerDate)
                var timeRemainingText = "\(timeRemaining.hour ?? 0):\(timeRemaining.minute ?? 0)"
                if let hour = timeRemaining.hour, hour > 0, hour < 10, let minute = timeRemaining.minute, minute > 0, minute < 10 {
                    timeRemainingText = "0\(timeRemaining.hour ?? 0):0\(timeRemaining.minute ?? 0)"
                } else if let minute = timeRemaining.minute, minute > 0, minute < 10 {
                    timeRemainingText = "\(timeRemaining.hour ?? 0):0\(timeRemaining.minute ?? 0)"
                } else if let hour = timeRemaining.hour, hour > 0, hour < 10 {
                    timeRemainingText = "\(timeRemaining.hour ?? 0):\(timeRemaining.minute ?? 0)"
                }
                switch nextPrayer {
                case .fajr:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.fajr), nextPrayerName: Prayer.dhuhr, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.dhuhr), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.fajr)", primaryTextColor: .white, highlightedTextColor: .white, prayers: [MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: .white), MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: .white), MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: .white), MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: .white)])
                    entries.append(prayerEntry)
                case .dhuhr:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.dhuhr), nextPrayerName: Prayer.asr, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.asr), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.dhuhr)", primaryTextColor: Constants.lightBlackWidgetColor, highlightedTextColor: .black, prayers: [MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Fajr", prayerTime: fajrTime, textColor: Constants.lightBlackWidgetColor)])
                    entries.append(prayerEntry)
                case .asr:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.asr), nextPrayerName: Prayer.maghrib, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.maghrib), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.asr)", primaryTextColor: Constants.lightBlackWidgetColor, highlightedTextColor: .black, prayers: [MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Fajr", prayerTime: fajrTime, textColor: Constants.lightBlackWidgetColor), MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: Constants.lightBlackWidgetColor)])
                    entries.append(prayerEntry)
                case .maghrib:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.maghrib), nextPrayerName: Prayer.isha, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.isha), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.maghrib)", primaryTextColor: .white, highlightedTextColor: Constants.orangeWidgetColor, prayers: [MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: .white), MyPrayer(prayerName: "Fajr", prayerTime: fajrTime, textColor: .white), MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: .white), MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: .white)])
                    entries.append(prayerEntry)
                case .isha:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.isha), nextPrayerName: Prayer.fajr, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.fajr), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.isha)", primaryTextColor: .white, highlightedTextColor: Constants.lightBlueWidgetColor, prayers: [MyPrayer(prayerName: "Fajr", prayerTime: fajrTime, textColor: .white), MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: .white), MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: .white), MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: .white)])
                    entries.append(prayerEntry)
                default:
                    break
                }
            } else {
                let nextPrayerDate = prayers.time(for: Prayer.fajr)
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextPrayerDate)!
                let timeRemaining = PrayerManager.shared.getNextPrayerRemainingTime(nextDate)
                var timeRemainingText = "\(timeRemaining.hour ?? 0):\(timeRemaining.minute ?? 0)"
                if let hour = timeRemaining.hour, hour > 0, hour < 10, let minute = timeRemaining.minute, minute > 0, minute < 10 {
                    timeRemainingText = "0\(timeRemaining.hour ?? 0):0\(timeRemaining.minute ?? 0)"
                } else if let minute = timeRemaining.minute, minute > 0, minute < 10 {
                    timeRemainingText = "\(timeRemaining.hour ?? 0):0\(timeRemaining.minute ?? 0)"
                } else if let hour = timeRemaining.hour, hour > 0, hour < 10 {
                    timeRemainingText = "\(timeRemaining.hour ?? 0):\(timeRemaining.minute ?? 0)"
                }
                let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: Prayer.fajr, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.fajr), nextPrayerName: Prayer.sunrise, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.sunrise), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.fajr)", primaryTextColor: .white, highlightedTextColor: .white, prayers: [MyPrayer(prayerName: "Dhuhar", prayerTime: dhuharTime, textColor: .white), MyPrayer(prayerName: "Asr", prayerTime: asrTime, textColor: .white), MyPrayer(prayerName: "Maghrib", prayerTime: maghribTime, textColor: .white), MyPrayer(prayerName: "Isha", prayerTime: ishaTime, textColor: .white)])
                entries.append(prayerEntry)
            }
        }
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
}
