//
//  TopViewModel.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/11.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import RxSwift
import RxCocoa
import CalculateCalendarLogic

struct DetailView {
    var title : String
    var hour : String
    var detail : [String]
}

class TopViewModel {
    
    private let calendarTapEventSubject = PublishSubject<DetailView>()
    public var calendarTapEvent: Observable<DetailView> { return calendarTapEventSubject }
    private let formatter = DateFormatter()
    
    func updateDetailView(_ date :Date) {
        let title = self.getTitle(date)
        let hour = self.getHour(targetDate: date)
        let detail = self.getDetail(targetDate: date)
        let detailView = DetailView(title: title, hour: hour, detail: detail)
        calendarTapEventSubject.onNext(detailView)
    }
    
    /**
     * 詳細画面のタイトルを取得
     * @return String
     */
    func getTitle(_ date: Date) -> String {
        formatter.dateFormat = Localizable.Calendar.titleDateFormat.localized
        return formatter.string(from: date)
    }
    
    func getHour(targetDate :Date) -> String {
        return Util.getHour()
    }
    
    func getDetail(targetDate :Date) -> [String] {
        return ["・国語勉強\n・理科勉強\n・Swift勉強\n・Go勉強\n・読書","・ひたすら勉強か"]
    }
    
    /**
     * 日付の文字色を取得する
     * 土/日/祝日で色を変える
     * @return UIColor?
     */
    func getColorForDate(_ date: Date) -> UIColor?{
        let weekIdx = self.getWeekIdx(date)
        if self.isHoliday(date) || weekIdx == 1 {
            return .red
        } else if weekIdx == 7 {
            return .blue
        }
        return nil
    }
}

// MARK - private method
extension TopViewModel {
    
    /**
     * 祝日判定
     * TODO: 多言語対応時、日本の祝日が表示されてしまうので他国では表示しないようにする
     * @return Bool true: 祝日, false: 祝日ではない
     */
    private func isHoliday(_ date: Date) -> Bool {
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
    private func getWeekIdx(_ date: Date) -> Int{
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.weekday, from: date)
    }
    
}
