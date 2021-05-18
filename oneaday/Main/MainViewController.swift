//
//  MainViewController.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/3/21.
//

import UIKit
import CoreLocation
import Adhan

final class MainViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private lazy var timeRemaining: DateComponents? = nil
    private lazy var currentLocation: String? = nil
    private lazy var nextPrayerTime: String? = nil
    private lazy var prayers: PrayerTimes? = nil
    private lazy var nextPrayer: Prayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        LocationManager.shared.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: MainCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: PrayerListCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: PrayerListCollectionViewCell.identifier)
    }
    
    @IBAction private func shareButtonTapped(_ sender: UIButton) {
        shareActivity()
    }
}

extension MainViewController: LocationManagerDelegate {
    func locationUpdated(_ location: CLLocation) {
        if let prayerTimes = PrayerManager.shared.getPrayers(location) {
            prayers = prayerTimes
            nextPrayer = prayers?.nextPrayer()
            let nextPrayerDate = prayers?.time(for: nextPrayer ?? Prayer.fajr)
            nextPrayerTime = PrayerManager.shared.getPrayerTimeString(nextPrayerDate!)
            
            print("Countdown:", nextPrayerDate)
            timeRemaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: nextPrayerDate!)
            print("Time remaining", timeRemaining)
        }
        LocationManager.shared.getCityCountry(location) { [weak self] location in
            self?.currentLocation = location
            self?.collectionView.reloadData()
        }
    }
    
    func authorizationSuccess() {
        print("Location request successful")
    }
    
    func authorizationFailed() {
        showLocationAlert()
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            if let nextPrayer = nextPrayer, let nextPrayerTime = nextPrayerTime {
                cell.backgroundImageView.image = UIImage(named: "\(nextPrayer)")
                cell.nextPrayerTimeLabel.text = "at \(nextPrayerTime)"
                cell.nextPrayerNameLabel.text = "until \(nextPrayer)".capitalized
                cell.countDownToNextPrayerLabel.text = "\(timeRemaining?.hour ?? 0)hr \(timeRemaining?.minute ?? 0)min \(timeRemaining?.second ?? 0)sec"
            } else if let prayers = prayers {
                let nextPrayerDate = prayers.time(for: Prayer.fajr)
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextPrayerDate)!
                let nextPrayerTime = PrayerManager.shared.getPrayerTimeString(nextDate)
                let timeRemaining = PrayerManager.shared.getNextPrayerRemainingTime(nextDate)
                
                cell.backgroundImageView.image = UIImage(named: "\(Prayer.fajr)")
                cell.nextPrayerTimeLabel.text = "at \(nextPrayerTime)"
                cell.nextPrayerNameLabel.text = "until \(Prayer.fajr)".capitalized
                cell.countDownToNextPrayerLabel.text = "\(timeRemaining.hour ?? 0)hr \(timeRemaining.minute ?? 0)min \(timeRemaining.second ?? 0)sec"
            }
            return cell
        }
        let cell: PrayerListCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        if let prayers = prayers {
            cell.fajrTimeLabel.text = PrayerManager.shared.getPrayerTimeString(prayers.fajr)
            cell.sunriseTimeLabel.text = PrayerManager.shared.getPrayerTimeString(prayers.sunrise)
            cell.dhuhrTimeLabel.text = PrayerManager.shared.getPrayerTimeString(prayers.dhuhr)
            cell.asrTimeLabel.text = PrayerManager.shared.getPrayerTimeString(prayers.asr)
            cell.maghribTimeLabel.text = PrayerManager.shared.getPrayerTimeString(prayers.maghrib)
            cell.ishaTimeLabel.text = PrayerManager.shared.getPrayerTimeString(prayers.isha)
            cell.islamicDateLabel.text = PrayerManager.shared.getIslamicDate()
            cell.addressLabel.text = currentLocation
            if let nextPrayer = nextPrayer {
                cell.backgroundImageView.image = UIImage(named: "\(nextPrayer)")
                cell.nextPrayerNameLabel.text = "until \(nextPrayer)".capitalized
                cell.countDownToNextPrayerLabel.text = "\(timeRemaining?.hour ?? 0)hr \(timeRemaining?.minute ?? 0)min \(timeRemaining?.second ?? 0)sec"
            } else {
                let nextPrayerDate = prayers.time(for: Prayer.fajr)
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextPrayerDate)!
                let timeRemaining = PrayerManager.shared.getNextPrayerRemainingTime(nextDate)
                
                cell.backgroundImageView.image = UIImage(named: "\(Prayer.fajr)")
                cell.nextPrayerNameLabel.text = "until \(Prayer.fajr)".capitalized
                cell.countDownToNextPrayerLabel.text = "\(timeRemaining.hour ?? 0)hr \(timeRemaining.minute ?? 0)min \(timeRemaining.second ?? 0)sec"
            }
        }
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
