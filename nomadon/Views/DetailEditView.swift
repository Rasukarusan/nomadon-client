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
        
//        let clockImg = UIImageView()
//        clockImg.frame = CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.height/2)
//        clockImg.backgroundColor = .blue
//        clockImg.image = UIImage(named: "hour")
//        clockImg.contentMode = .scaleAspectFill
//        view.addSubview(clockImg)
        
        let circularSlider = CircularSlider()
        let fillColor = UIColor(red: 0.1441, green: 0.3364, blue: 0.8777, alpha: 0.2)
        circularSlider.frame = CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.height/2)
        circularSlider.center.x = view.center.x
        circularSlider.minimumValue = 0.0
        circularSlider.maximumValue = 12.0
        circularSlider.numberOfRounds = 2
        circularSlider.thumbOffset = 0.5
        circularSlider.diskFillColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 0.5) // スライダーを動かした時に円が塗りつぶされる色
        circularSlider.diskColor = .clear // 円の中の色
        circularSlider.trackColor = UIColor(red: 0.274, green: 0.288, blue: 0.297, alpha: 0.5)
        circularSlider.trackFillColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1)
        circularSlider.backtrackLineWidth = 4.0
        circularSlider.lineWidth = 2.0
        circularSlider.thumbRadius = 4.0 // スライダーの半径
        circularSlider.endThumbStrokeColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1) // スライダーが止まっている時の色
        circularSlider.endThumbStrokeHighlightedColor = UIColor(red: 0.1512, green: 0.8393, blue: 0.9916, alpha: 1) // スライダーを動かしている時の色
        circularSlider.backgroundColor = .clear
        
        circularSlider.endPointValue = 0.5
        view.addSubview(circularSlider)
        
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
        
        let todoTextView = UITextView()
        todoTextView.frame = CGRect(
            x: paddingLeft,
            y: todoTitle.frame.maxY + 10,
            width: view.frame.width*0.95 - paddingLeft,
            height: view.frame.height*0.4 - Util.getSafeAreaBottom() - Util.getStatusBarHeight()
        )
//        todoTextView.center.x = view.center.x
        todoTextView.layer.cornerRadius = 10.0
        todoTextView.layer.borderWidth = 1.0
        todoTextView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(todoTextView)
        
        let doneBtn = UIButton()
        doneBtn.frame = CGRect(x: 0, y: 0, width: view.frame.width*0.3, height: view.frame.height*0.05)
        doneBtn.center = CGPoint(x: view.frame.width/2, y: view.frame.height*0.95)
        doneBtn.setTitle("完了", for: .normal)
        doneBtn.backgroundColor = .blue
        view.addSubview(doneBtn)
    }
}
