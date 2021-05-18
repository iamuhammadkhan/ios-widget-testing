//
//  UIScrollView+Extension.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/3/21.
//

import UIKit

extension UIScrollView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        next?.touchesBegan(touches, with: event)
    }
    
    var currentPage: Int {
        return Int(round(contentOffset.x / frame.width))
    }
}
