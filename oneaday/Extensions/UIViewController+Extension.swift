//
//  UIViewController+Extension.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/3/21.
//

import UIKit

extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func showLocationAlert() {
        let alert = UIAlertController(title: "Location Access Pending", message: "It will enable us to get prayer times in your area", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (_) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        present(alert, animated: true)
    }
    
    func shareActivity(with message: String = "The best way to know Prayer timinigs in your area", and link: String = "https://apps.apple.com/us/app/one-a-day-ramadan-2016-prayer-times-daily-wisdom/id1122975911") {
            let activityVC = UIActivityViewController(activityItems: [message, link], applicationActivities: nil)
            present(activityVC, animated: true)
        }
}
