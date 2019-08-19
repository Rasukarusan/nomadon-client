//
//  ViewController.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/07.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit
import FSCalendar
import RxSwift
import RxCocoa

class TopViewController: UIViewController,FSCalendarDelegateAppearance, FSCalendarDataSource, FSCalendarDelegate {
    
    let calendar =  FSCalendar()
    var dayDetailTitle = UILabel()
    let dayDetailHour = UILabel()
    let detail = UILabel()
    let editBtn = UIButton()
    
    private let viewModel =  TopViewModel()
    private let disposeBag = DisposeBag()
    
    
    var editView:DetailEditView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editView = DetailEditView(frame:self.view.frame)
        editView.center = self.view.center
        self.view.addSubview(editView)
        
        editView.circularSlider.rx.controlEvent(.valueChanged)
        .subscribe(onNext: { _ in
            self.updateTexts(endPointValue: self.editView.circularSlider.endPointValue)
        }).disposed(by: disposeBag)
        
        editView.doneBtn.rx.tap.subscribe(onNext: { _ in
            self.editView.isHidden = true
        }).disposed(by: disposeBag)
        
        editBtn.rx.tap.subscribe(onNext: { _ in

        }).disposed(by: disposeBag)
        
        viewModel.calendarTapEvent.subscribe(onNext: { (detailView) in
            self.updateDetailView(detailView)
        }).disposed(by: disposeBag)
    }
    
    func updateTexts(endPointValue:CGFloat) {
        let decimal = endPointValue * 10
        let hour = round(decimal/5) * 5 / 10
        if hour > 12 && hour <= 24{ // 2周目以降の色を変える
            self.editView.circularSlider.diskColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 0.5)
            self.editView.circularSlider.trackColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 0.5)
            self.editView.circularSlider.trackFillColor = UIColor(red: 0.6764, green: 0.447, blue: 0.7647, alpha: 1)
            self.editView.circularSlider.endThumbStrokeColor = UIColor(red: 0.6764, green: 0.447, blue: 0.7647, alpha: 1)
           self.editView.circularSlider.endThumbStrokeHighlightedColor = UIColor(red: 0.6764, green: 0.447, blue: 0.7647, alpha: 1)
           self.editView.circularSlider.diskFillColor = UIColor(red: 0.6764, green: 0.447, blue: 0.7647, alpha: 0.5)
        }else if hour == 12 {
            self.editView.circularSlider.diskColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 0.5)
            self.editView.circularSlider.trackColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
            self.editView.circularSlider.trackFillColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
            self.editView.circularSlider.endThumbStrokeColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
            self.editView.circularSlider.endThumbStrokeHighlightedColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
            self.editView.circularSlider.diskFillColor = .clear
        } else if hour >= 0 && hour < 12 {
            self.editView.circularSlider.diskColor = .clear
            self.editView.circularSlider.trackColor = UIColor(red: 0.274, green: 0.288, blue: 0.297, alpha: 0.1)
            self.editView.circularSlider.trackFillColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
            self.editView.circularSlider.endThumbStrokeColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
            self.editView.circularSlider.endThumbStrokeHighlightedColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
            self.editView.circularSlider.diskFillColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 0.5)
        }
        self.editView.hourLbl.text = hour.description + "h"
    }
    
    private func updateDetailView(_ detailView : DetailView) {
        self.dayDetailTitle.text = detailView.title
        self.dayDetailHour.text = detailView.hour
        self.detail.text = detailView.detail.joined(separator: "\n")
        self.dayDetailTitle.sizeToFit()
    }
    
    /**
     * カレンダータップ時の処理
     */
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        viewModel.updateDetailView(date)
    }

    /**
     * 日付の文字色を設定
     * @return UIColor?
     */
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return viewModel.getColorForDate(date)
    }
    
    /**
     * 日付の文字色を設定
     * @return UIColor?
     */
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return viewModel.getHour(targetDate: date)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buildUI()
        viewModel.updateDetailView(Date())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
