//
//  DetailEditViewModel.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/19.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

struct HourCircleColors {
    var disk : UIColor
    var diskFill : UIColor
    var track : UIColor
    var trackFill : UIColor
    var endThumbStroke : UIColor
    var endThumbStrokeHighlighted  : UIColor
    
}

class DetailEditViewModel {
    
    /**
     * 時間毎の円の色を返す
     * @return HourCircleColors
     */
    func getHourCircleColorsByHour(endPointValue:CGFloat) -> HourCircleColors {
        let hour = self.getHour(endPointValue: endPointValue)
        // デフォルト
        var hourCircleColors = HourCircleColors(
            disk: UIColor.HourCircle.disk,
            diskFill: UIColor.HourCircle.diskFill,
            track: UIColor.HourCircle.track,
            trackFill: UIColor.HourCircle.trackFill,
            endThumbStroke: UIColor.HourCircle.endThumbStroke,
            endThumbStrokeHighlighted: UIColor.HourCircle.endThumbStrokeHighlighted
        )
        if hour > 12 && hour <= 24 { // 2周目以降
            hourCircleColors.disk                       = UIColor.HourCircle.diskRounded
            hourCircleColors.diskFill                   = UIColor.HourCircle.diskFillRounded
            hourCircleColors.track                      = UIColor.HourCircle.trackRounded
            hourCircleColors.trackFill                  = UIColor.HourCircle.trackFillRounded
            hourCircleColors.endThumbStroke             = UIColor.HourCircle.endThumbStrokeRounded
            hourCircleColors.endThumbStrokeHighlighted  = UIColor.HourCircle.endThumbStrokeHighlightedRounded
        } else if hour == 12 { // ちょうど2周目
            hourCircleColors.disk     = UIColor.HourCircle.diskFill
            hourCircleColors.diskFill = UIColor.HourCircle.disk
            hourCircleColors.track    = UIColor.HourCircle.trackFill
        }
        return hourCircleColors
    }
    
    /**
     * スライダーの値から時間を計算する
     * @return 時間
     */
    func getHour(endPointValue:CGFloat)->CGFloat {
        let decimal = endPointValue * 10
        let hour = round(decimal/5) * 5 / 10
        return hour
    }
}

// MARK - private method
extension DetailEditViewModel {

    

}
