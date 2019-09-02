//
//  UIView+Extension.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/25.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

extension UIView {
    var recursiveSubviews: [UIView] {
        return subviews + subviews.flatMap { $0.recursiveSubviews }
    }
    
    func findViews<T: UIView>(subclassOf: T.Type) -> [T] {
        return recursiveSubviews.compactMap { $0 as? T }
    }
    
    func findLabels(text: String) -> [UILabel] {
        return findViews(subclassOf: UILabel.self).filter { $0.text == text }
    }
    
    func findButtons(tag: Int) -> [UIButton] {
        return findViews(subclassOf: UIButton.self).filter { $0.tag == tag }
    }
}
