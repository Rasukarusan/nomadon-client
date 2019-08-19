//
//  DetailEditView.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/18.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit
import HGCircularSlider

class DetailEditView: UIView {
    
    public let dayDetailTitle = UILabel()
    public let circularSlider = CircularSlider()
    public let hourLbl = UILabel()
    public let doneBtn = UIButton()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        let paddingLeft : CGFloat = 20.0
        let fontRicty = Util.getFontName()
        let fontRictyBold = Util.getFontName(isBold: true)
        
        let view = UIView(frame:CGRect(x: 0, y: 0, width: frame.width*0.95, height: frame.height*0.95 - Util.getStatusBarHeight() - Util.getSafeAreaBottom()))
        view.backgroundColor = .white
        view.center = center
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10.0
        addSubview(view)
        
        // タイトル左のアイコン
        let iconImgView = UIImageView()
        iconImgView.frame = CGRect(
            x:paddingLeft,
            y:frame.height/30,
            width:20,
            height:20
        )
        iconImgView.image = UIImage(named:"edit")
        iconImgView.center.x = view.center.x
        view.addSubview(iconImgView)
        
        // タイトル
        dayDetailTitle.frame = CGRect(
            x: 0,//iconImgView.frame.maxX + paddingLeft,
//            y: frame.height*0.8,
            y: frame.height/30,
            width: frame.width - paddingLeft*2,
            height: frame.height/10
        )
        dayDetailTitle.textColor = UIColor(red: 0.1441, green: 0.3364, blue: 0.8777, alpha: 1)
        dayDetailTitle.text = "2019年8月15日"
        dayDetailTitle.center.x = view.center.x
        dayDetailTitle.font = UIFont(name: fontRictyBold, size: 30)
        dayDetailTitle.textAlignment = .center
//        dayDetailTitle.sizeToFit()
        view.addSubview(dayDetailTitle)
        
        // 時計の画像
        let clockImg = UIImageView()
        clockImg.frame = CGRect(x: 0, y: dayDetailTitle.frame.maxY + 10, width: view.frame.width*0.7-50, height: view.frame.width*0.7-50)
        clockImg.center.x = view.center.x
        
        clockImg.image = UIImage(named: "hour")
        clockImg.backgroundColor = .clear
        view.addSubview(clockImg)
        
        let fillColor = UIColor(red: 0.1441, green: 0.3364, blue: 0.8777, alpha: 0.2)
        circularSlider.frame = CGRect(x: 0, y: dayDetailTitle.frame.maxY + 10, width: view.frame.width*0.7, height: view.frame.width*0.7)
        circularSlider.center.x = view.center.x
        circularSlider.minimumValue = 0.0
        circularSlider.maximumValue = 24.0
        circularSlider.numberOfRounds = 2
        circularSlider.diskFillColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 0.5) // スライダーを動かした時に円が塗りつぶされる色
        circularSlider.diskColor = .clear // 円の中の色
        circularSlider.trackColor = UIColor(red: 0.274, green: 0.288, blue: 0.297, alpha: 0.1)
        circularSlider.trackFillColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
        circularSlider.backtrackLineWidth = 18.0
        circularSlider.lineWidth = 18.0 // スライダーで塗りつぶされる線の太さ
        circularSlider.thumbRadius = 6.0 // スライダーの半径
        circularSlider.endThumbStrokeColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1) // スライダーが止まっている時の色
        circularSlider.endThumbStrokeHighlightedColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1) // スライダーを動かしている時の色
        circularSlider.backgroundColor = .clear
        circularSlider.endPointValue = 0.0
        view.addSubview(circularSlider)
        
        clockImg.center.y = circularSlider.center.y
        
        // 時間
        hourLbl.frame = CGRect(
            x: 0, y: 0, width: view.frame.width/3, height: view.frame.height/15)
//        hourLbl.backgroundColor = .ngreen
        hourLbl.center = circularSlider.center
        hourLbl.text = "4.5h"
        hourLbl.font = UIFont(name: fontRicty, size: 36)
        hourLbl.textAlignment = .center
        view.addSubview(hourLbl)
        
        // todoアイコン
        let todoImgView = UIImageView()
        todoImgView.frame = CGRect(
            x:paddingLeft,
            y:circularSlider.frame.maxY,
            width:20,
            height:20
        )
        todoImgView.image = UIImage(named:"todo")
        view.addSubview(todoImgView)
        
        // タイトル
        let todoTitle = UILabel()
        todoTitle.frame = CGRect(
            x: todoImgView.frame.maxX + paddingLeft/2,
            y: circularSlider.frame.maxY,
            width: frame.width - paddingLeft*2,
            height: frame.height/10
        )
        todoTitle.textColor = .gray
        todoTitle.text = "作業一覧"
        todoTitle.font = UIFont(name: fontRicty, size: 18)
        todoTitle.sizeToFit()
        view.addSubview(todoTitle)
        
        // 作業一覧
        let todoTextView = UITextView()
        todoTextView.frame = CGRect(
            x: paddingLeft,
            y: todoTitle.frame.maxY + 10,
            width: view.frame.width*0.95 - paddingLeft,
            height: view.frame.height*0.4 - Util.getSafeAreaBottom() - Util.getStatusBarHeight()
        )
        todoTextView.layer.cornerRadius = 10.0
        todoTextView.layer.borderWidth = 1.0
        todoTextView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(todoTextView)
        
        // 完了ボタン
        doneBtn.frame = CGRect(x: 0, y: 0, width: view.frame.width*0.3, height: view.frame.height*0.05)
        doneBtn.center = CGPoint(x: view.frame.width/2, y: view.frame.height*0.95)
        doneBtn.setTitle("完了", for: .normal)
        doneBtn.titleLabel?.font = UIFont.init(name: fontRicty, size: 18)
        doneBtn.backgroundColor = .ngreen
        doneBtn.layer.cornerRadius = 5.0
        doneBtn.layer.borderWidth = 1.0
        doneBtn.layer.borderColor = UIColor.clear.cgColor
        view.addSubview(doneBtn)
    }
}
