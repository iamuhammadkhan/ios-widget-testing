//
//  LocationManager.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/4/21.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func locationUpdated(_ location: CLLocation)
    func authorizationSuccess()
    func authorizationFailed()
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    private static var singleton: LocationManager?
    static var shared: LocationManager {
        if LocationManager.singleton == nil {
            LocationManager.singleton = LocationManager()
        }
        let lock = DispatchQueue(label: "LocationManager")
        return lock.sync { return LocationManager.singleton! }
    }
    private lazy var locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    private override init() {
        super.init()
        requestAuthorization()
    }
    
    private func requestAuthorization() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        saveCoordinates()
        requestLocationAccess()
    }
    
    private func requestLocationAccess() {
        if CLLocationManager.locationServicesEnabled() {
            switch locationAuthorizationStatus() {
            case .restricted, .denied:
                delegate?.authorizationFailed()
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startMonitoringSignificantLocationChanges()
                locationManager.startUpdatingLocation()
                delegate?.authorizationSuccess()
            default:
                break
            }
        } else {
            requestLocationAccess()
        }
    }
    
    private func locationAuthorizationStatus() -> CLAuthorizationStatus {
        let locationManager = CLLocationManager()
        var locationAuthorizationStatus : CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            locationAuthorizationStatus =  locationManager.authorizationStatus
        } else {
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        return locationAuthorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        status == .authorizedWhenInUse ? manager.startUpdatingLocation() : requestLocationAccess()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            saveCoordinates(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            delegate?.locationUpdated(location)
            manager.stopUpdatingLocation()
        }
    }
    
    func getCityCountry(_ location: CLLocation, completion: @escaping (String) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if error == nil, let placemark = placemarks?.first, let city = placemark.locality, let country = placemark.country {
                completion("\(city), \(country)")
            }
        }
    }
    
    func saveCoordinates(lat: Double = 21.3891, lng: Double = 39.8579) {
        UserDefaults.standard.set(lat, forKey: Constants.locationLatKey)
        UserDefaults.standard.set(lng, forKey: Constants.locationLngKey)
    }
    
    func getLocation() -> CLLocation {
        let lat = UserDefaults.standard.double(forKey: Constants.locationLatKey)
        let lng = UserDefaults.standard.double(forKey: Constants.locationLngKey)
        return CLLocation(latitude: lat, longitude: lng)
    }
}
