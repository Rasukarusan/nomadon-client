//
//  TopView.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/09/02.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit
import FSCalendar

class TopView: UIView {
    let fontRicty = Util.getFontName()
    let fontRictyBold = Util.getFontName(isBold: true)
    let paddingLeft : CGFloat = 10.0
    
    public let calendar =  FSCalendar()
    public let dayDetailView = UIView()
    public var dayDetailTitle = UILabel()
    public let dayDetailHour = UILabel()
    public let detail = UILabel()
    public let editBtn = UIButton()
    
    private let iconTitleImgView = UIImageView()
    private let clockView = UIView()
    private let clock = ClockView()
    private let detailScrollView = UIScrollView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCalendar()
        layoutDetailView()
        layoutDetailTitle()
        layoutClock()
        layoutDetail()
        layoutEditBtn()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        // 時計を表示するView
        // ClockView()をそのままcenter.xなどで移動すると、円だけが移動してしまうため
        // ClockView()を載せるためのViewを作り、それを移動させる手段を取った
        clockView.backgroundColor = .clear
        dayDetailView.addSubview(clockView)
        
        // 時計
        clock.endAngle = 30
        clockView.addSubview(clock)
        
        // 作業時間
        dayDetailHour.backgroundColor = .clear
        dayDetailHour.textColor = .black
        dayDetailHour.text = "5.5h"
        dayDetailHour.textAlignment = .center
        dayDetailHour.font = UIFont(name: fontRicty, size: frame.height/30)
        dayDetailView.addSubview(dayDetailHour)
        
        // 詳細
        detailScrollView.showsVerticalScrollIndicator = false
        dayDetailView.addSubview(detailScrollView)
        
        // 詳細の1つ(TODO: 1つのLabelに載せるか、複数のLabelに1つずつ載せるか未定。今は1つのLabelに全載せ)
        detail.textColor = .black
        detail.text = "・個人アプリ開発\n・カレンダー機能の実装\n・Golangでサーバー作り"
        detail.font = UIFont(name: fontRicty, size:18)
        detail.numberOfLines = 0
        detailScrollView.addSubview(detail)
        
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
        // 時計を載せるView
        clockView.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: dayDetailView.frame.width/4,
            height: dayDetailView.frame.height/4
        )
        clockView.center.x = dayDetailView.center.x - paddingLeft
        // 時計
        clock.frame = CGRect(
            x: 0,
            y: 0,
            width: dayDetailView.frame.width/4,
            height: dayDetailView.frame.height/4
        )
        clock.radius = clock.frame.width/3
        // 時計の時間テキスト
        dayDetailHour.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: dayDetailView.frame.width/4,
            height: dayDetailView.frame.height/4
        )
        dayDetailHour.center.x = dayDetailView.center.x - paddingLeft
    }
    
    private func layoutDetail() {
        // 詳細ラベルを載せるスクロールView
        detailScrollView.frame = CGRect(
            x: paddingLeft,
            y: dayDetailHour.frame.maxY + dayDetailView.frame.height/20,
            width: dayDetailView.frame.width - paddingLeft*2,
            height: dayDetailView.frame.height - dayDetailHour.frame.maxY
        )
        detailScrollView.contentSize = CGSize(width: detailScrollView.frame.width, height:dayDetailView.frame.height*3)
        
        // 詳細ラベル
        detail.frame = CGRect(
            x: 0,
            y: 0,
            width: detailScrollView.frame.width,
            height: detailScrollView.frame.height/5
        )
        detail.sizeToFit()
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

