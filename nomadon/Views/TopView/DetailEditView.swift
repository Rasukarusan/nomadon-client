//
//  DetailEditView.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/18.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit
import HGCircularSlider
import Spring

class DetailEditView: SpringView {
    
    public let dayDetailTitle = UILabel()
    public let circularSlider = CircularSlider()
    public let hourLbl = UILabel()
    public let doneBtn = UIButton()
    
    private let paddingLeft : CGFloat = 20.0
    private let view = UIView()
    private let clockImg = UIImageView()
    private let todoImgView = UIImageView()
    private let todoTitle = UILabel()
    private let todoTextView = UITextView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBaseView()
        layoutDayDetailTitle()
        layoutClock()
        layoutTodo()
        layoutDoneBtn()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        let fontRicty = Util.getFontName()
        let fontRictyBold = Util.getFontName(isBold: true)
        
        // 部品を載せていくview
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10.0
        addSubview(view)
        
        // 日付タイトル
        dayDetailTitle.textColor = UIColor(red: 0.1441, green: 0.3364, blue: 0.8777, alpha: 1)
        dayDetailTitle.text = "2019年8月15日"
        dayDetailTitle.font = UIFont(name: fontRictyBold, size: 30)
        dayDetailTitle.textAlignment = .center
        view.addSubview(dayDetailTitle)
        
        // 時計の画像
        clockImg.image = UIImage(named: "hour")
        clockImg.layer.borderColor = UIColor.clear.cgColor
        clockImg.layer.borderWidth = 0.5
        // TODO : テーマによって時計の画像を差し替える
        clockImg.backgroundColor = .clear
        clockImg.layer.backgroundColor = UIColor.clear.cgColor
        view.addSubview(clockImg)
        
        // スライダー
        circularSlider.minimumValue = 0.0
        circularSlider.maximumValue = 24.0
        circularSlider.numberOfRounds = 2
        circularSlider.diskFillColor = UIColor.HourCircle.diskFill
        circularSlider.diskColor = UIColor.HourCircle.disk
        circularSlider.trackColor = UIColor.HourCircle.track
        circularSlider.trackFillColor = UIColor.HourCircle.trackFill
        circularSlider.backtrackLineWidth = 18.0
        circularSlider.lineWidth = 18.0 // スライダーで塗りつぶされる線の太さ
        circularSlider.thumbRadius = 6.0 // スライダーの半径
        circularSlider.endThumbStrokeColor = UIColor.HourCircle.endThumbStroke
        circularSlider.endThumbStrokeHighlightedColor = UIColor.HourCircle.endThumbStrokeHighlighted
        circularSlider.backgroundColor = .clear
        circularSlider.endPointValue = 0.0
        view.addSubview(circularSlider)
        
        // 時間テキスト
        hourLbl.text = "4.5h"
        hourLbl.font = UIFont(name: fontRicty, size: 36)
        hourLbl.textAlignment = .center
        view.addSubview(hourLbl)
        
        // todoアイコン
        todoImgView.image = UIImage(named:"todo")
        view.addSubview(todoImgView)
        
        // 作業一覧タイトル
        todoTitle.textColor = .gray
        todoTitle.text = "作業一覧"
        todoTitle.font = UIFont(name: fontRicty, size: 18)
        view.addSubview(todoTitle)
        
        // 作業一覧
        todoTextView.layer.cornerRadius = 10.0
        todoTextView.layer.borderWidth = 1.0
        todoTextView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(todoTextView)
        
        // 完了ボタン
        doneBtn.setTitle("完了", for: .normal)
        doneBtn.titleLabel?.font = UIFont.init(name: fontRicty, size: 18)
        doneBtn.backgroundColor = .ngreen
        doneBtn.layer.cornerRadius = 5.0
        doneBtn.layer.borderWidth = 1.0
        doneBtn.layer.borderColor = UIColor.clear.cgColor
        view.addSubview(doneBtn)
    }
    
    private func layoutBaseView() {
        view.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.width*0.95,
            height: frame.height*0.95 - Util.getStatusBarHeight() - Util.getSafeAreaBottom() - Util.getToolBarHeight()
        )
        view.center = center
        view.center.y = center.y -  Util.getToolBarHeight()/2
    }
    
    private func layoutDayDetailTitle() {
        dayDetailTitle.frame = CGRect(
            x: 0,
            y: frame.height/70,
            width: frame.width - paddingLeft*2,
            height: frame.height/10
        )
        dayDetailTitle.center.x = view.center.x
    }
    
    private func layoutClock() {
        clockImg.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: view.frame.width*0.7-50,
            height: view.frame.width*0.7-50
        )
        clockImg.center.x = view.center.x
        clockImg.layer.cornerRadius = clockImg.frame.width/2
        
        circularSlider.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: view.frame.width*0.7,
            height: view.frame.width*0.7
        )
        circularSlider.center.x = view.center.x
        // 時計画像とスライダーの位置を合わせるため両方の位置を定義に設定する
        clockImg.center.y = circularSlider.center.y
        
        hourLbl.frame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.width/3,
            height: view.frame.height/15
        )
        hourLbl.center = circularSlider.center
    }
    
    private func layoutTodo() {
        todoImgView.frame = CGRect(
            x:paddingLeft,
            y:circularSlider.frame.maxY,
            width:20,
            height:20
        )
        
        todoTitle.frame = CGRect(
            x: todoImgView.frame.maxX + paddingLeft/2,
            y: circularSlider.frame.maxY,
            width: frame.width - paddingLeft*2,
            height: frame.height/10
        )
        todoTitle.sizeToFit()
        
        todoTextView.frame = CGRect(
            x: paddingLeft,
            y: todoTitle.frame.maxY + 10,
            width: view.frame.width*0.95 - paddingLeft,
            height: view.frame.height - todoTitle.frame.maxY - Util.getSafeAreaBottom() - Util.getStatusBarHeight() - Util.getToolBarHeight()
        )
    }
    
    private func layoutDoneBtn() {
        doneBtn.frame = CGRect(
            x: 0,
            y: todoTextView.frame.maxY + 5,
            width: view.frame.width*0.3,
            height: view.frame.height*0.05
        )
        doneBtn.center = CGPoint(x: view.frame.width/2, y:view.frame.height*0.95)
    }
}
