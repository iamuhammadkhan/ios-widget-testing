//
//  PrayerListCollectionViewCell.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/5/21.
//

import UIKit

final class PrayerListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ishaTimeLabel: UILabel!
    @IBOutlet weak var islamicDateLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var countDownToNextPrayerLabel: UILabel!
    @IBOutlet weak var nextPrayerNameLabel: UILabel!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var maghribTimeLabel: UILabel!
    @IBOutlet weak var dhuhrTimeLabel: UILabel!
    @IBOutlet weak var fajrTimeLabel: UILabel!
    @IBOutlet weak var asrTimeLabel: UILabel!
    
    private lazy var timer: Timer? = nil
    private lazy var date: Date? = nil
    private lazy var seconds = 60

    func createTimer(_ date: Date) {
        self.date = date
        if timer != nil { return }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        let remainingSeconds = PrayerManager.shared.getNextPrayerRemainingSeconds(date)
        seconds = remainingSeconds.second ?? 0
    }
    
    @objc private func startTimer() {
        if seconds == 0 {
            timer?.invalidate()
            return
        }
        seconds -= 1
        
        let timeRemaining = PrayerManager.shared.getNextPrayerRemainingTime(date ?? Date())
        countDownToNextPrayerLabel.text = "\(timeRemaining.hour ?? 0):\(timeRemaining.minute ?? 0):\(timeRemaining.second ?? 0)"
        if let hour = timeRemaining.hour, hour > 0, hour < 10, let minute = timeRemaining.minute, minute > 0, minute < 10 {
            countDownToNextPrayerLabel.text = "0\(timeRemaining.hour ?? 0):0\(timeRemaining.minute ?? 0):\(timeRemaining.second ?? 0)"
        } else if let minute = timeRemaining.minute, minute > 0, minute < 10 {
            countDownToNextPrayerLabel.text = "\(timeRemaining.hour ?? 0):0\(timeRemaining.minute ?? 0):\(timeRemaining.second ?? 0)"
        } else if let hour = timeRemaining.hour, hour > 0, hour < 10 {
            countDownToNextPrayerLabel.text = "0\(timeRemaining.hour ?? 0):\(timeRemaining.minute ?? 0):\(timeRemaining.second ?? 0)"
        }
    }
}
