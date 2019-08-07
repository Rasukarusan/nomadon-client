//
//  ViewController.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/07.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic

class ViewController: UIViewController,FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance {
    
    fileprivate weak var calendar: FSCalendar!
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     * カレンダータップ時の処理
     */
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
    }

    /**
     * 日付の文字色を設定
     */
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return self.getColorForDate(date)
    }
    
    
    /**
     * 日付の文字色を取得する
     * @return UIColor?
     */
    private func getColorForDate(_ date: Date) -> UIColor?{
        let weekIdx = CalendarModel.getWeekIdx(date)
        //祝日判定
        if CalendarModel.isHoliday(date) || weekIdx == 1{
            return .red
        }else if weekIdx == 7 {
            return .blue
        }
        return nil
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let calendar = FSCalendar()
        calendar.frame = CGRect(x: 0, y: Util.getStatusBarHeight(), width: self.view.frame.width, height: self.view.frame.height/2 - Util.getSafeAreaBottom())
        calendar.dataSource = self
        calendar.delegate = self
        calendar.setScope(.week, animated: true)
        calendar.appearance.headerDateFormat = "yyyy/MM"
        view.addSubview(calendar)
        self.calendar = calendar
    }
}


