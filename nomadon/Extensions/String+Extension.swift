//
//  String+Extension.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/09/03.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

extension String {
    func toCGFloat() -> CGFloat {
        return CGFloat(Double(self) ?? 0)
    }
    
    func toInt() -> Int {
        return NumberFormatter().number(from: self) as! Int
    }
}
