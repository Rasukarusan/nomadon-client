//
//  Localizable.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/07.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import Foundation

protocol LocalizableDelegate {
    var rawValue: String { get }    //localize key
    var table: String? { get }
    var localized: String { get }
}
extension LocalizableDelegate {
    
    //returns a localized value by specified key located in the specified table
    var localized: String {
        return Bundle.main.localizedString(forKey: rawValue, value: nil, table: table)
    }
    
    // file name, where to find the localized key
    // by default is the Localizable.string table
    var table: String? {
        return nil
    }
}

enum Localizable {
    
    enum Global: String, LocalizableDelegate {
        case ok, cancel, close
        case alertTitleBePremium, alertMessageBePremium
    }
    
    enum Calendar: String, LocalizableDelegate {
        case headerDateFormat
    }
    
}
