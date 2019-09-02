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
import Spring

class TopViewController: BaseViewController {
    private var topView:TopView!
    private var editView:DetailEditView!
    
    private let topViewModel =  TopViewModel()
    private let detailEditViewModel = DetailEditViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView = TopView(frame:self.view.frame)
        topView.calendar.delegate = self
        topView.calendar.dataSource = self
        self.view.addSubview(topView)
        
        editView = DetailEditView(frame:self.view.frame)
        self.editView.isHidden = true
        self.view.addSubview(editView)
        
        // 編集ボタンタップ時
        topView.editBtn.rx.tap.subscribe(onNext: { _ in
            self.showEditView()
        }).disposed(by: disposeBag)
        
        // 時計のスライダーを変更時
        editView.circularSlider.rx.controlEvent(.valueChanged)
        .subscribe(onNext: { _ in
            self.drawHourCircle(endPointValue: self.editView.circularSlider.endPointValue)
        }).disposed(by: disposeBag)
        
        // Doneボタンタップ時
        editView.doneBtn.rx.tap.subscribe(onNext: { _ in
            self.hideEditView()
        }).disposed(by: disposeBag)
        
        // カレンダータップ時
        topViewModel.calendarTapEvent.subscribe(onNext: { (detailView) in
            self.updateDetailView(detailView)
        }).disposed(by: disposeBag)
    }
    
    /**
     * 編集画面を表示する
     */
    private func showEditView() {
        self.editView.isHidden = false
        self.editView.animation = "fadeInUp"
        self.editView.animate()
    }
    
    /**
     * 編集画面を非表示にする
     */
    private func hideEditView() {
        self.editView.animation = "fadeOut"
        self.editView.force = 5.0
        self.editView.animate()
    }
    
    /**
     * 編集画面の時計を描画し直す
     * @param CGFloat スライダーの値
     */
    private func drawHourCircle(endPointValue:CGFloat) {
        let hourCircleColors = detailEditViewModel.getHourCircleColorsByHour(endPointValue: endPointValue)
        self.editView.circularSlider.diskColor = hourCircleColors.disk
        self.editView.circularSlider.diskFillColor = hourCircleColors.diskFill
        self.editView.circularSlider.trackColor = hourCircleColors.track
        self.editView.circularSlider.trackFillColor = hourCircleColors.trackFill
        self.editView.circularSlider.endThumbStrokeColor = hourCircleColors.endThumbStroke
        self.editView.circularSlider.endThumbStrokeHighlightedColor = hourCircleColors.endThumbStrokeHighlighted

        let hour = detailEditViewModel.getHour(endPointValue: endPointValue)
        self.editView.hourLbl.text = hour.description + "h"
    }
    
    /**
     * 詳細画面を更新する
     * @param DetailView 更新後の詳細画面オブジェクト
     */
    private func updateDetailView(_ detailView : DetailView) {
        self.topView.dayDetailTitle.text = detailView.title
        self.topView.dayDetailHour.text = detailView.hour
        self.topView.detail.text = detailView.detail.joined(separator: "\n")
        self.topView.dayDetailTitle.sizeToFit()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewModel.updateDetailView(Date())
        
        // ToolBar
        let toolBar = buildToolBar()
        changeImageSelected(toolBar: toolBar, type: .home)
        changeColorSelected(toolBar: toolBar, type: .home)
        self.view.addSubview(toolBar)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension TopViewController : FSCalendarDelegateAppearance, FSCalendarDataSource, FSCalendarDelegate {

    /**
     * カレンダータップ時の処理
     */
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        topViewModel.updateDetailView(date)
    }
    
    /**
     * 日付の文字色を設定
     * @return UIColor?
     */
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return topViewModel.getColorForDate(date)
    }
    
    /**
     * 日付の文字色を設定
     * @return UIColor?
     */
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return topViewModel.getHour(targetDate: date)
    }
}
