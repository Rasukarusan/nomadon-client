//
//  Localizable.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/07.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import Foundation

protocol LocalizableDelegate {
    var rawValue: String { get }
    var table: String? { get }
    var localized: String { get }
}
extension LocalizableDelegate {

    var localized: String {
        return Bundle.main.localizedString(forKey: rawValue, value: nil, table: table)
    }
    var table: String? {
        return nil
    }
}

enum Localizable {
    
    enum Toolbar : String, LocalizableDelegate {
        case buttonLabelHome = "toolbarButtonLabelHome"
        case buttonLabelList = "toolbarButtonLabelList"
        case buttonLabelChart = "toolbarButtonLabelChart"
        case buttonLabelSetting = "toolbarButtonLabelSetting"
    }

    enum Global: String, LocalizableDelegate {
        case ok, cancel, close
        case alertTitleBePremium, alertMessageBePremium
    }

    enum Calendar: String, LocalizableDelegate {
        case headerDateFormat
        case titleDateFormat
    }
    
    enum EditView: String, LocalizableDelegate {
        case todoLabelTitle
        case doneBtnTitle
    }
}
