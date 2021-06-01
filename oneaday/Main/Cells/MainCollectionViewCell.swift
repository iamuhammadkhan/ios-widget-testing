//
//  MainCollectionViewCell.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/4/21.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nextPrayerNameLabel: UILabel!
    @IBOutlet weak var countDownToNextPrayerLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nextPrayerTimeLabel: UILabel!
    
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
    }
}
