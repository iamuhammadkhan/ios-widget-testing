//
//  UITableView+Extension.swift
//  oneaday
//
//  Created by Muhammad Khan on 5/3/21.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Fatal error for reuseable cell at : \(indexPath)")
        }
        return cell
    }
}
