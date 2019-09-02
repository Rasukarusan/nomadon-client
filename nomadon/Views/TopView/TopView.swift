//
//  TopView.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/09/02.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit
import FSCalendar
import HGCircularSlider

class TopView: UIView {
    public let calendar =  FSCalendar()
    public let dayDetailView = UIView()
    public let circularSlider = CircularSlider()
    public let dayDetailTitle = UILabel()
    public let dayDetailHour = UILabel()
    public let detailTextView = UITextView()
    public let editBtn = UIButton()
    
    private let paddingLeft : CGFloat = 10.0
    private let iconTitleImgView = UIImageView()
    private let clockImg = UIImageView()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCalendar()
        layoutDetailView()
        layoutDetailTitle()
        layoutClock()
        layoutDetailText()
        layoutEditBtn()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let fontRicty = Util.getFontName()
        let fontRictyBold = Util.getFontName(isBold: true)
        // カレンダー
        calendar.setScope(.week, animated: true)
        calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 0)
        calendar.appearance.borderRadius = 10
        calendar.appearance.headerTitleFont = UIFont(name: fontRicty,size: 18)
        calendar.appearance.weekdayFont = UIFont(name: fontRicty, size: 18)
        calendar.appearance.titleFont = UIFont(name: fontRicty, size: 18)
        calendar.appearance.headerDateFormat = Localizable.Calendar.headerDateFormat.localized
        calendar.appearance.subtitleSelectionColor = .black
        calendar.appearance.subtitleTodayColor = .black
        self.addSubview(calendar)
        
        // 詳細画面
        dayDetailView.backgroundColor = .white
        dayDetailView.layer.borderColor = UIColor.black.cgColor
        dayDetailView.layer.borderWidth = 0.5
        dayDetailView.layer.cornerRadius = 10.0
        self.addSubview(dayDetailView)
        
        // タイトル左のアイコン
        iconTitleImgView.image = UIImage(named:"edit")
        dayDetailView.addSubview(iconTitleImgView)
        
        // タイトル
        dayDetailTitle.textColor = UIColor(red: 0.1441, green: 0.3364, blue: 0.8777, alpha: 1)
        dayDetailTitle.text = "2019年8月15日"
        dayDetailTitle.font = UIFont(name: fontRictyBold, size: 18)
        dayDetailView.addSubview(dayDetailTitle)
        
        // 時計の画像
        clockImg.image = UIImage(named: "hour")
        clockImg.layer.borderColor = UIColor.clear.cgColor
        clockImg.layer.borderWidth = 0.5
        // TODO : テーマによって時計の画像を差し替える
        clockImg.backgroundColor = .clear
        clockImg.layer.backgroundColor = UIColor.clear.cgColor
        dayDetailView.addSubview(clockImg)
        
        // スライダー
        circularSlider.minimumValue = 0.0
        circularSlider.maximumValue = 24.0
        circularSlider.numberOfRounds = 2
        circularSlider.diskFillColor = UIColor.HourCircle.diskFill
        circularSlider.diskColor = UIColor.HourCircle.disk
        circularSlider.trackColor = UIColor.HourCircle.track
        circularSlider.trackFillColor = UIColor.HourCircle.trackFill
        circularSlider.backtrackLineWidth = 9.0
        circularSlider.lineWidth = 9.0 // スライダーで塗りつぶされる線の太さ
        circularSlider.thumbRadius = 0.0 // スライダーの半径
        circularSlider.endThumbStrokeColor = UIColor.HourCircle.endThumbStroke
        circularSlider.endThumbStrokeHighlightedColor = UIColor.HourCircle.endThumbStrokeHighlighted
        circularSlider.backgroundColor = .clear
        circularSlider.endPointValue = 4.5
        circularSlider.isEnabled = false
        dayDetailView.addSubview(circularSlider)
        
        // 時間テキスト
        dayDetailHour.text = "4.5h"
        dayDetailHour.font = UIFont(name: fontRicty, size: 18)
        dayDetailHour.textAlignment = .center
        dayDetailView.addSubview(dayDetailHour)
        
        // 詳細
        detailTextView.textColor = .black
        detailTextView.font = UIFont(name: fontRicty, size:18)
        dayDetailView.addSubview(detailTextView)
        
        // 編集ボタン
        editBtn.backgroundColor = .white
        editBtn.layer.borderWidth = 1.0
        editBtn.setImage(UIImage(named:"edit"), for: .normal)
        editBtn.imageView?.contentMode = .scaleAspectFit
        editBtn.contentHorizontalAlignment = .fill
        editBtn.contentVerticalAlignment = .fill
        self.addSubview(editBtn)
    }
    
    private func layoutCalendar() {
        calendar.frame = CGRect(
            x: 0,
            y: frame.height/2 - Util.getSafeAreaBottom(),
            width: frame.width,
            height: frame.height/2 - Util.getToolBarHeight() - Util.getSafeAreaBottom()
        )
    }
    
    private func layoutDetailView() {
        dayDetailView.frame = CGRect(
            x: 0,
            y: Util.getStatusBarHeight(),
            width: frame.width - frame.width/13,
            height: frame.height/2 - frame.height/25 - Util.getStatusBarHeight() - Util.getSafeAreaBottom()
        )
        dayDetailView.center.x = self.center.x
    }
    
    private func layoutDetailTitle() {
        // 詳細タイトルのアイコン
        iconTitleImgView.frame = CGRect(
            x:paddingLeft,
            y:dayDetailView.frame.height/20,
            width:20,
            height:20
        )
        // 詳細タイトル
        dayDetailTitle.frame = CGRect(
            x: iconTitleImgView.frame.maxX + paddingLeft,
            y: dayDetailView.frame.height/20,
            width: dayDetailView.frame.width - paddingLeft*2,
            height: dayDetailView.frame.height/10
        )
        dayDetailTitle.sizeToFit()
    }
    
    private func layoutClock() {
        clockImg.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: dayDetailView.frame.width*0.5-50,
            height: dayDetailView.frame.width*0.5-50
        )
        clockImg.center.x = dayDetailView.center.x
        clockImg.layer.cornerRadius = clockImg.frame.width/2
        
        circularSlider.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: dayDetailView.frame.width*0.4,
            height: dayDetailView.frame.width*0.4
        )
        circularSlider.center.x = dayDetailView.center.x
        // 時計画像とスライダーの位置を合わせるため両方の位置を定義に設定する
        clockImg.center.y = circularSlider.center.y
        
        dayDetailHour.frame = CGRect(
            x: 0,
            y: 0,
            width: dayDetailView.frame.width/3,
            height: dayDetailView.frame.height/15
        )
        dayDetailHour.center = circularSlider.center
    }
    

    private func layoutDetailText() {
        detailTextView.frame = CGRect(
            x: 0,
            y: circularSlider.frame.maxY,
            width: dayDetailView.frame.width,
            height: dayDetailView.frame.height/5
        )
        detailTextView.sizeToFit()
    }
    
    private func layoutEditBtn() {
        editBtn.frame = CGRect(
            x: 0,
            y: dayDetailView.frame.maxY - dayDetailView.frame.width/16,
            width: dayDetailView.frame.width/8,
            height: dayDetailView.frame.width/8
        )
        editBtn.center.x = dayDetailView.center.x
        editBtn.layer.cornerRadius = editBtn.frame.width/2
        let edge : CGFloat = 10
        editBtn.imageEdgeInsets = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge);
    }
}

