//
//  UICollectionView+Extension.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/4/21.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Fatal error for reuseable cell at : \(indexPath)")
        }
        return cell
    }
}
