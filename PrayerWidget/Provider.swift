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
        var entries = [PrayerEntry]()
        let location = LocationManager.shared.getLocation()
        if let prayers = PrayerManager.shared.getPrayers(location) {
            let prayer = PrayerEntry.createObject(prayers)
            entries.append(prayer)
        }
        let refreshDate = Calendar.current.date(byAdding: .second, value: 10, to: Date())!
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
}
