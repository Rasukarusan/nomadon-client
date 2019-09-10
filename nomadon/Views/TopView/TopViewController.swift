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
    
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView = TopView(frame:self.view.frame)
        topView.calendar.delegate = self
        topView.calendar.dataSource = self
        topView.detailPagingView.delegate = self
        topView.detailPagingView.dataSource = self
        self.view.addSubview(topView)
        
        editView = DetailEditView(frame:self.view.frame)
        editView.isHidden = true
        self.view.addSubview(editView)

        // 編集ボタンタップ時
        topView.editBtn.rx.tap.subscribe(onNext: { _ in
            self.showEditView()
            let detail = self.detailEditViewModel.getDetail(self.topView.dayDetailTitle.text!)
            self.redrawDetailEditView(detail)
        }).disposed(by: disposeBag)
        
        // 時計のスライダーを変更時
        editView.circularSlider.rx.controlEvent(.valueChanged)
        .subscribe(onNext: { _ in
            self.redrawEditViewHourCircle(endPointValue: self.editView.circularSlider.endPointValue)
        }).disposed(by: disposeBag)
        
        // Doneボタンタップ時
        editView.doneBtn.rx.tap.subscribe(onNext: { _ in
            self.hideEditView()
        }).disposed(by: disposeBag)
    }
    
    /// 編集画面を表示する
    private func showEditView() {
        self.editView.isHidden = false
        self.editView.animation = "fadeInUp"
        self.editView.animate()
    }
    
    /// 編集画面を非表示にする
    private func hideEditView() {
        self.editView.animation = "fadeOut"
        self.editView.force = 5.0
        self.editView.animate()
    }

    /// 編集画面の時計を描画し直す
    ///
    /// - Parameter endPointValue: スライダーの値
    private func redrawEditViewHourCircle(endPointValue:CGFloat) {
        let hourCircleColors = detailEditViewModel.getHourCircleColorsByHour(endPointValue: endPointValue)
        self.editView.circularSlider.diskColor = hourCircleColors.disk
        self.editView.circularSlider.diskFillColor = hourCircleColors.diskFill
        self.editView.circularSlider.trackColor = hourCircleColors.track
        self.editView.circularSlider.trackFillColor = hourCircleColors.trackFill
        self.editView.circularSlider.endThumbStrokeColor = hourCircleColors.endThumbStroke
        self.editView.circularSlider.endThumbStrokeHighlightedColor = hourCircleColors.endThumbStrokeHighlighted
        let hour = detailEditViewModel.calculateHour(endPointValue: endPointValue)
        self.editView.hourLbl.text = hour.description + "h"
    }
    
    /// 詳細画面を更新する
    ///
    /// - Parameter detailView: 詳細画面オブジェクト
    private func redrawDetailView(_ detailView : DetailView) {
        self.topView.dayDetailTitle.text = detailView.title
        self.topView.dayDetailHour.text = "\(detailView.hour)h"
        self.topView.circularSlider.endPointValue = CGFloat(Double(detailView.hour) ?? 0)
        self.topView.detailTextView.text = detailView.detail.joined(separator: "\n")
        self.topView.dayDetailTitle.sizeToFit()
    }
    
    /// 詳細編集画面を更新する
    ///
    /// - Parameter detailView: 詳細画面オブジェクト
    private func redrawDetailEditView(_ detailView : DetailView) {
        self.editView.dayDetailTitle.text = detailView.title
        self.editView.hourLbl.text = "\(detailView.hour)h"
        self.editView.circularSlider.endPointValue = CGFloat(Double(detailView.hour) ?? 0)
        self.editView.todoTextView.text = detailView.detail.joined(separator: "\n")
        self.editView.dayDetailTitle.sizeToFit()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewModel.updateDetailView(Date())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let toolBar = buildToolBar()
        changeImageSelected(toolBar: toolBar, type: .home)
        changeColorSelected(toolBar: toolBar, type: .home)
        self.view.addSubview(toolBar)
    }
}

extension TopViewController : FSCalendarDelegateAppearance, FSCalendarDataSource, FSCalendarDelegate {

    /**
     * カレンダータップ時の処理
     */
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let detailView = topViewModel.updateDetailView(date)
        self.redrawDetailView(detailView)
        topView.detailPagingView.scrollToItem(at: IndexPath(row: count, section: 0), at: .left, animated: true)
    }
    
    /**
     * 日付の文字色を設定
     */
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return topViewModel.getColorForDate(date)
    }
    
    /**
     * 日付の文字色を設定
     */
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return topViewModel.getHour(targetDate: date)
    }
}

extension TopViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // セクションごとのセル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topView.detailPagingView.pageCount * 3
    }
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell:\(indexPath)")
        let cell:DetailCell = topView.detailPagingView.dequeueReusableCell(withReuseIdentifier: topView.detailPagingView.cellIdentifier, for: indexPath) as! DetailCell
        
        let today = Date()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: count, to: today)!
        let detailView = topViewModel.updateDetailView(modifiedDate)
        cell.dayDetailTitle.text = detailView.title
        cell.dayDetailHour.text = detailView.hour
        cell.detailTextView.text = detailView.detail.joined(separator: "\n")

        // 編集ボタンタップ時
        cell.editBtn.rx.tap.subscribe(onNext: { _ in
            self.showEditView()
            let detail = self.detailEditViewModel.getDetail(cell.dayDetailTitle.text!)
            self.redrawDetailEditView(detail)
        }).disposed(by: disposeBag)
        count += 1
        return cell
    }
}
