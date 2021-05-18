//
//  PrayerListCollectionViewCell.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/5/21.
//

import UIKit

final class PrayerListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var islamicDateLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var countDownToNextPrayerLabel: UILabel!
    @IBOutlet weak var nextPrayerNameLabel: UILabel!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var maghribTimeLabel: UILabel!
    @IBOutlet weak var dhuhrTimeLabel: UILabel!
    @IBOutlet weak var ishaTimeLabel: UILabel!
    @IBOutlet weak var fajrTimeLabel: UILabel!
    @IBOutlet weak var asrTimeLabel: UILabel!
}
