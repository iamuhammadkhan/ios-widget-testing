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
        let location = CLLocation(latitude: 24.8607, longitude: 67.0011)
        if let prayers = PrayerManager.shared.getPrayers(location) {
            if let nextPrayer = prayers.nextPrayer() {
                let nextPrayerDate = prayers.time(for: nextPrayer)
                let timeRemaining = PrayerManager.shared.getNextPrayerRemainingTime(nextPrayerDate)
                var timeRemainingText = "\(timeRemaining.minute ?? 0)min"
                if let hour = timeRemaining.hour, let minute = timeRemaining.minute, hour > 0 {
                    timeRemainingText = "\(hour)hr \(minute)min"
                }
                switch nextPrayer {
                case .fajr:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.fajr), nextPrayerName: Prayer.sunrise, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.sunrise), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.fajr)")
                    entries.append(prayerEntry)
                case .sunrise:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.sunrise), nextPrayerName: Prayer.dhuhr, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.dhuhr), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.sunrise)")
                    entries.append(prayerEntry)
                case .dhuhr:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.dhuhr), nextPrayerName: Prayer.asr, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.asr), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.dhuhr)")
                    entries.append(prayerEntry)
                case .asr:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.asr), nextPrayerName: Prayer.maghrib, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.maghrib), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.asr)")
                    entries.append(prayerEntry)
                case .maghrib:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.maghrib), nextPrayerName: Prayer.isha, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.isha), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.maghrib)")
                    entries.append(prayerEntry)
                case .isha:
                    let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: nextPrayer, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.isha), nextPrayerName: Prayer.fajr, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.fajr), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.isha)")
                    entries.append(prayerEntry)
                }
            } else {
                let nextPrayerDate = prayers.time(for: Prayer.fajr)
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextPrayerDate)!
                let timeRemaining = PrayerManager.shared.getNextPrayerRemainingTime(nextDate)
                var timeRemainingText = "\(timeRemaining.minute ?? 0)min"
                if let hour = timeRemaining.hour, let minute = timeRemaining.minute, hour > 0 {
                    timeRemainingText = "\(hour)hr \(minute)min"
                }
                let prayerEntry = PrayerEntry(date: currentDate, currentPrayerName: Prayer.fajr, currentPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.fajr), nextPrayerName: Prayer.sunrise, nextPrayerTime: PrayerManager.shared.getPrayerTimeString(prayers.sunrise), untilNextPrayerTime: timeRemainingText, nextPrayerImage: "\(Prayer.fajr)")
                entries.append(prayerEntry)
            }
        }
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
}
