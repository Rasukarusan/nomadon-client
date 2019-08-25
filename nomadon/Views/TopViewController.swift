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

class TopViewController: UIViewController {
    
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
        self.editView.isHidden = true
        self.view.addSubview(editView)
        
        // 時計のスライダーを変更時
        editView.circularSlider.rx.controlEvent(.valueChanged)
        .subscribe(onNext: { _ in
            self.drawHourCircle(endPointValue: self.editView.circularSlider.endPointValue)
        }).disposed(by: disposeBag)

        // 編集ボタンタップ時
        editBtn.rx.tap.subscribe(onNext: { _ in
            self.showEditView()
        }).disposed(by: disposeBag)
        
        // Doneボタンタップ時
        editView.doneBtn.rx.tap.subscribe(onNext: { _ in
            self.hideEditView()
        }).disposed(by: disposeBag)
        
        // カレンダータップ時
        viewModel.calendarTapEvent.subscribe(onNext: { (detailView) in
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
        self.dayDetailTitle.text = detailView.title
        self.dayDetailHour.text = detailView.hour
        self.detail.text = detailView.detail.joined(separator: "\n")
        self.dayDetailTitle.sizeToFit()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buildUI()
        viewModel.updateDetailView(Date())
        self.view.bringSubviewToFront(self.editView)
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
}
