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
    private let formatter = DateFormatter()
    
    func getDetail(_ dateStr: String) -> DetailView{
        let date = self.convertDateStr(dateStr)
        let hour = self.getHour(targetDate: date)
        let detail = self.getDetail(targetDate: date)
        return DetailView(title: dateStr, hour: hour, detail: detail)
    }

    private func convertDateStr(_ dateStr: String) -> Date {
        formatter.dateFormat = Localizable.Calendar.titleDateFormat.localized
        return formatter.date(from: dateStr)!
    }

    private func getHour(targetDate :Date) -> String {
        return Util.getHour()
    }

    private func getDetail(targetDate :Date) -> [String] {
        return ["・国語勉強\n・理科勉強\n・Swift勉強\n・Go勉強\n・読書","・ひたすら勉強か"]
    }

    /**
     * 時間毎の円の色を返す
     * @return HourCircleColors
     */
    func getHourCircleColorsByHour(endPointValue:CGFloat) -> HourCircleColors {
        let hour = self.calculateHour(endPointValue: endPointValue)
        // デフォルト(1周目)
        var hourCircleColors = HourCircleColors(
            disk: UIColor.HourCircle.disk,
            diskFill: UIColor.HourCircle.diskFill,
            track: UIColor.HourCircle.track,
            trackFill: UIColor.HourCircle.trackFill,
            endThumbStroke: UIColor.HourCircle.endThumbStroke,
            endThumbStrokeHighlighted: UIColor.HourCircle.endThumbStrokeHighlighted
        )
        if hour > 12 && hour <= 24 { // 2周目以降
            hourCircleColors.disk = UIColor.HourCircle.diskRounded
            hourCircleColors.diskFill = UIColor.HourCircle.diskFillRounded
            hourCircleColors.track = UIColor.HourCircle.trackRounded
            hourCircleColors.trackFill = UIColor.HourCircle.trackFillRounded
            hourCircleColors.endThumbStroke = UIColor.HourCircle.endThumbStrokeRounded
            hourCircleColors.endThumbStrokeHighlighted = UIColor.HourCircle.endThumbStrokeHighlightedRounded
        } else if hour == 12 { // ちょうど2周目
            hourCircleColors.disk = UIColor.HourCircle.diskFill
            hourCircleColors.diskFill = UIColor.HourCircle.disk
            hourCircleColors.track = UIColor.HourCircle.trackFill
        }
        return hourCircleColors
    }

    /**
     * スライダーの値から時間を計算する
     * @return 時間
     */
    func calculateHour(endPointValue:CGFloat)->CGFloat {
        let decimal = endPointValue * 10
        let hour = round(decimal/5) * 5 / 10
        return hour
    }
}
