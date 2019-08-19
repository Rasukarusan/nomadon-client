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
    private let detailEditViewModel = DetailEditViewModel()
    private let disposeBag = DisposeBag()
    
    var editView:DetailEditView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editView = DetailEditView(frame:self.view.frame)
        editView.center = self.view.center
        self.view.addSubview(editView)
        
        editView.circularSlider.rx.controlEvent(.valueChanged)
        .subscribe(onNext: { _ in
            self.drawHourCircle(endPointValue: self.editView.circularSlider.endPointValue)
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
    
    private func drawHourCircle(endPointValue:CGFloat) {
        let hourCircleColors = detailEditViewModel.getHourCircleColorsByHour(endPointValue: endPointValue)
        self.editView.circularSlider.diskColor                      = hourCircleColors.disk
        self.editView.circularSlider.diskFillColor                  = hourCircleColors.diskFill
        self.editView.circularSlider.trackColor                     = hourCircleColors.track
        self.editView.circularSlider.trackFillColor                 = hourCircleColors.trackFill
        self.editView.circularSlider.endThumbStrokeColor            = hourCircleColors.endThumbStroke
        self.editView.circularSlider.endThumbStrokeHighlightedColor = hourCircleColors.endThumbStrokeHighlighted

        let hour = detailEditViewModel.getHour(endPointValue: endPointValue)
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
//        buildUI()
        viewModel.updateDetailView(Date())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
