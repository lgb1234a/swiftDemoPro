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
    enum nib: String {
        case CYBlurEffectView
    }
}

extension UITableViewCell {
    enum identifier: String {
        case baseCell
    }
}

protocol CY_UIIdentifier {
    static var identifier: String { get }
}

extension CY_UIIdentifier where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
