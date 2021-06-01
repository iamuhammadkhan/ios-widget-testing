//
//  MainViewController.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/3/21.
//

import UIKit
import CoreLocation
import WidgetKit
import Adhan

final class MainViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private lazy var nextPrayerDate: Date? = nil
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
        collectionView.delegate = self
        collectionView.dataSource = self
        LocationManager.shared.delegate = self
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
            nextPrayerDate = prayers?.time(for: nextPrayer ?? Prayer.fajr)
            nextPrayerTime = PrayerManager.shared.getPrayerTimeString(nextPrayerDate!)
            timeRemaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: nextPrayerDate!)
        }
        LocationManager.shared.getCityCountry(location) { [weak self] location in
            self?.currentLocation = location
            self?.collectionView.reloadData()
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func authorizationSuccess() {
        print("Location request successful")
    }
    
    func authorizationFailed() {
        WidgetCenter.shared.reloadAllTimelines()
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
                let prayerName = "\(nextPrayer)".capitalized
                cell.nextPrayerNameLabel.text = "until \(prayerName)"
                cell.createTimer(nextPrayerDate ?? Date())
            } else if let prayers = prayers {
                let nextPrayerDate = prayers.time(for: Prayer.fajr)
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextPrayerDate)!
                let nextPrayerTime = PrayerManager.shared.getPrayerTimeString(nextDate)
                
                cell.backgroundImageView.image = UIImage(named: "\(Prayer.fajr)")
                cell.nextPrayerTimeLabel.text = "at \(nextPrayerTime)"
                let prayerName = "\(Prayer.fajr)".capitalized
                cell.nextPrayerNameLabel.text = "until \(prayerName)"
                cell.createTimer(nextDate)
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
                let prayerName = "\(nextPrayer)".capitalized
                cell.nextPrayerNameLabel.text = "until \(prayerName)"
                cell.createTimer(nextPrayerDate ?? Date())
            } else {
                let nextPrayerDate = prayers.time(for: Prayer.fajr)
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextPrayerDate)!
                
                cell.backgroundImageView.image = UIImage(named: "\(Prayer.fajr)")
                let prayerName = "\(Prayer.fajr)".capitalized
                cell.nextPrayerNameLabel.text = "until \(prayerName)"
                cell.createTimer(nextDate)
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
