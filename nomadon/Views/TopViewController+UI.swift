//
//  ViewControlle+UI.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/10.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit
import FSCalendar

extension TopViewController {
    @objc func buildUI() {
        let fontRicty = Util.getFontName()
        let fontRictyBold = Util.getFontName(isBold: true)
        let paddingLeft : CGFloat = 10.0

        // カレンダー
        calendar.frame = CGRect(
            x: 0,
            y: self.view.frame.height/2 - Util.getSafeAreaBottom(),
            width: self.view.frame.width,
            height: self.view.frame.height/2 - Util.getSafeAreaBottom() - Util.getToolBarHeight()
        )
        calendar.dataSource = self
        calendar.delegate = self
        calendar.setScope(.week, animated: true)
        calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 0)
        calendar.appearance.borderRadius = 10
        calendar.appearance.headerTitleFont = UIFont(name: fontRicty,size: 18)
        calendar.appearance.weekdayFont = UIFont(name: fontRicty, size: 18)
        calendar.appearance.titleFont = UIFont(name: fontRicty, size: 18)
        calendar.appearance.headerDateFormat = Localizable.Calendar.headerDateFormat.localized
        calendar.appearance.subtitleSelectionColor = .black
        calendar.appearance.subtitleTodayColor = .black
        self.view.addSubview(calendar)
        
        // 詳細画面
        let dayDetailView = UIView()
        dayDetailView.frame = CGRect(
            x: 0,
            y: Util.getStatusBarHeight(),
            width: self.view.frame.width - self.view.frame.width/13,
            height: self.view.frame.height/2 - Util.getStatusBarHeight() - Util.getSafeAreaBottom() - self.view.frame.height/25
        )
        dayDetailView.center.x = self.view.center.x
        dayDetailView.backgroundColor = .white
        dayDetailView.layer.borderColor = UIColor.black.cgColor
        dayDetailView.layer.borderWidth = 0.5
        dayDetailView.layer.cornerRadius = 10.0
        self.view.addSubview(dayDetailView)
        
        let tmpColor : UIColor = .white
        
        // タイトル左のアイコン
        let iconImgView = UIImageView()
        iconImgView.frame = CGRect(
            x:paddingLeft,
            y:dayDetailView.frame.height/20,
            width:20,
            height:20
        )
        iconImgView.image = UIImage(named:"edit")
        dayDetailView.addSubview(iconImgView)
        
        // タイトル
        dayDetailTitle.frame = CGRect(
            x: iconImgView.frame.maxX + paddingLeft,
            y: dayDetailView.frame.height/20,
            width: dayDetailView.frame.width - paddingLeft*2,
            height: dayDetailView.frame.height/10
        )
        dayDetailTitle.backgroundColor = tmpColor
        dayDetailTitle.textColor = UIColor(red: 0.1441, green: 0.3364, blue: 0.8777, alpha: 1)
        dayDetailTitle.text = "2019年8月15日"
        dayDetailTitle.font = UIFont(name: fontRictyBold, size: 18)
        dayDetailTitle.sizeToFit()
        dayDetailView.addSubview(dayDetailTitle)
        
        // 時計
        // ClockView()をそのままcenter.xなどで移動すると、円だけが移動してしまうため
        // ClockView()を載せるためのViewを作り、それを移動させる手段を取った
        let clockView = UIView()
        clockView.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: dayDetailView.frame.width/4,
            height: dayDetailView.frame.height/4
        )
        clockView.backgroundColor = .clear
        clockView.center.x = dayDetailView.center.x - paddingLeft
        dayDetailView.addSubview(clockView)
        
        let clock = ClockView()
        clock.frame = CGRect(
            x: 0,
            y: 0,
            width: dayDetailView.frame.width/4,
            height: dayDetailView.frame.height/4
        )
        clock.endAngle = 30
        clock.radius = clock.frame.width/3
        clockView.addSubview(clock)
        
        // 作業時間
        dayDetailHour.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: dayDetailView.frame.width/4,
            height: dayDetailView.frame.height/4
        )
        dayDetailHour.center.x = dayDetailView.center.x - paddingLeft
        dayDetailHour.backgroundColor = .clear
        dayDetailHour.textColor = .black
        dayDetailHour.text = "5.5h"
        dayDetailHour.textAlignment = .center
        dayDetailHour.font = UIFont(name: fontRicty, size: self.view.frame.height/30)
        dayDetailView.addSubview(dayDetailHour)
        
        // 詳細
        let detailScrollView = UIScrollView()
        detailScrollView.frame = CGRect(
            x: paddingLeft,
            y: dayDetailHour.frame.maxY + dayDetailView.frame.height/20,
            width: dayDetailView.frame.width - paddingLeft*2,
            height: dayDetailView.frame.height - dayDetailHour.frame.maxY
        )
        detailScrollView.contentSize = CGSize(width: detailScrollView.frame.width, height:dayDetailView.frame.height*3)
        detailScrollView.backgroundColor = tmpColor
        detailScrollView.showsVerticalScrollIndicator = false
        dayDetailView.addSubview(detailScrollView)
        
        // 詳細の1つ
        detail.frame = CGRect(
            x: 0,
            y: 0,
            width: detailScrollView.frame.width,
            height: detailScrollView.frame.height/5
        )
        detail.backgroundColor = tmpColor
        detail.textColor = .black
        detail.text = "・個人アプリ開発\n・カレンダー機能の実装\n・Golangでサーバー作り"
        detail.font = UIFont(name: fontRicty, size:18)
        detail.numberOfLines = 0
        detail.sizeToFit()
        detailScrollView.addSubview(detail)
        
        // 編集ボタン
        editBtn.frame = CGRect(
            x: 0,
            y: dayDetailView.frame.maxY - dayDetailView.frame.width/16,
            width: dayDetailView.frame.width/8,
            height: dayDetailView.frame.width/8
        )
        editBtn.center.x = dayDetailView.center.x
        editBtn.backgroundColor = .white
        editBtn.layer.borderWidth = 1.0
        editBtn.setImage(UIImage(named:"edit"), for: .normal)
        editBtn.imageView?.contentMode = .scaleAspectFit
        editBtn.contentHorizontalAlignment = .fill
        editBtn.contentVerticalAlignment = .fill
        editBtn.layer.cornerRadius = editBtn.frame.width/2
        let edge : CGFloat = 10
        editBtn.imageEdgeInsets = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge);
        self.view.addSubview(editBtn)
    }
}
