//
//  UIStoryBoard+Extension.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/3/21.
//

import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case main = "Main"
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<VC: UIViewController>() -> VC {
        guard let viewController = instantiateViewController(withIdentifier: VC.identifier) as? VC else {
            fatalError("Couldn't instantiate view controller with identifier \(VC.identifier) ")
        }
        return viewController
    }
}
