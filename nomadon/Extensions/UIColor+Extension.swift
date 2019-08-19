//
//  UIColor+Extension.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/18.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

extension UIColor {
    static let ngreen = UIColor(red: 0.1592, green: 0.7239, blue: 0.4518, alpha: 1)
    
    /**
     * disk : 円の中の色
     * track : 円の線の色
     * trackFill : スライダーを動かしているときに塗りつぶされる線の色
     * diskFill : スライダーを動かしている時に塗りつぶされる円の中の色
     * endThumbStroke : スライダーが止まっている時のスライダーの丸の色
     * endThumbStrokeHighlighted : スライダーを動かしている時のスライダーの丸の色
     */
    class HourCircle {
        /*** デフォルト***/
        static let disk                      = UIColor.clear
        static let track                     = UIColor(red: 0.274, green: 0.288, blue: 0.297, alpha: 0.1)
        static let trackFill                 = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
        static let diskFill                  = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 0.5)
        static let endThumbStroke            = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
        static let endThumbStrokeHighlighted = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
    
        /***2周目***/
        static let diskRounded                      = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 0.5)
        static let trackRounded                     = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 0.5)
        static let trackFillRounded                 = UIColor(red: 0.6764, green: 0.447, blue: 0.7647, alpha: 1)
        static let endThumbStrokeRounded            = UIColor(red: 0.6764, green: 0.447, blue: 0.7647, alpha: 1)
        static let endThumbStrokeHighlightedRounded = UIColor(red: 0.6764, green: 0.447, blue: 0.7647, alpha: 1)
        static let diskFillRounded                  = UIColor(red: 0.6764, green: 0.447, blue: 0.7647, alpha: 0.5)
    }
}
