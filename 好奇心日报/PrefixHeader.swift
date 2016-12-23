//
//  PrefixHeader.swift
//  好奇心日报
//
//  Created by chenyn on 16/11/2.
//  Copyright © 2016年 chenyn. All rights reserved.
//

import Foundation
import UIKit

let kScreenSize : CGSize = UIScreen.main.bounds.size
let kScreenFrame : CGRect = UIScreen.main.bounds


extension UINib {
    enum CY_nib: String {
        case CYBlurEffectView
    }
}

extension UITableViewCell {
    enum CY_identifier: String {
        case baseCell
    }
}

protocol UITableViewCellDelegate {
    static var CY_identifier: String { get }
}

extension UITableViewCellDelegate where Self: UITableViewCell {
    static var identifier: String {
        return UITableViewCell.CY_identifier.baseCell.rawValue
    }
}

protocol CY_UIIdentifier {
    static var CY_identifier: String { get }
}

extension CY_UIIdentifier where Self: UIView {
    static var CY_identifier: String {
        return String(describing: self)
    }
}


