//
//  PrayerManager.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/5/21.
//

import UIKit
import CoreLocation
import Adhan

final class PrayerManager: NSObject {
    private static var singleton: PrayerManager?
    private override init() {}
    
    static var shared: PrayerManager {
        if PrayerManager.singleton == nil {
            PrayerManager.singleton = PrayerManager()
        }
        let lock = DispatchQueue(label: "PrayerManager")
        return lock.sync { return PrayerManager.singleton! }
    }
        
    private let formatter: DateFormatter = {
        let fm = DateFormatter()
        fm.timeZone = .current
        fm.timeStyle = .short
        return fm
    }()
    
    func getPrayerTimeString(_ date: Date) -> String {
        return formatter.string(from: date)
    }
    
    func getNextPrayerRemainingSeconds(_ date: Date) -> DateComponents {
        return Calendar.current.dateComponents([.second], from: Date(), to: date)
    }
    
    func getNextPrayerRemainingTime(_ date: Date) -> DateComponents {
        return Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: date)
    }
    
    func getIslamicDate() -> String? {
        let calendar = Calendar(identifier: .islamicCivil)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.locale = Locale.current
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: Date())
    }
    
    func getPrayers(_ location: CLLocation) -> PrayerTimes? {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.locale = Locale.current
        let date = calendar.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        var params = CalculationMethod.moonsightingCommittee.params
        params.madhab = .hanafi
        if let prayerTimess = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            return prayerTimess
        }
        return nil
    }
}
