//
//  CalenderModel.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/07.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import Foundation
import CalculateCalendarLogic

class CalendarModel {

    /**
     * 祝日判定
     * TODO: 多言語対応時、日本の祝日が表示されてしまうので他国では表示しないようにする
     * @return Bool true: 祝日, false: 祝日ではない
     */
    final class func isHoliday(_ date: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let holiday = CalculateCalendarLogic()
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    /**
     * 曜日判定
     * @return Int 1..7, 1:日曜日, 7:土曜日
     */
     final class func getWeekIdx(_ date: Date) -> Int{
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.weekday, from: date)
    }
}
