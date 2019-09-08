//
//  DetailCellCollectionViewCell.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/09/04.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit
import HGCircularSlider

class DetailCell: UICollectionViewCell {
    
    public let circularSlider = CircularSlider()
    public let dayDetailTitle = UILabel()
    public let dayDetailHour = UILabel()
    public let detailTextView = UITextView()
    public let editBtn = UIButton()
    
    private let paddingLeft : CGFloat = 10.0
    private let iconTitleImgView = UIImageView()
    private let clockImg = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutDetailTitle()
        layoutClock()
        layoutEditBtn()
        layoutDetailText()
    }

    func setup() {
        let fontRicty = Util.getFontName()
        let fontRictyBold = Util.getFontName(isBold: true)
        
        // cell枠線
        let border = CAShapeLayer()
        border.strokeColor = UIColor.gray.cgColor
        border.fillColor = UIColor.clear.cgColor
        border.path = UIBezierPath(roundedRect:self.contentView.bounds, cornerRadius: 10).cgPath
        self.contentView.layer.addSublayer(border)
        
        // タイトル左のアイコン
        iconTitleImgView.image = UIImage(named:"edit")
        self.contentView.addSubview(iconTitleImgView)

        // タイトル
        dayDetailTitle.textColor = UIColor(red: 0.1441, green: 0.3364, blue: 0.8777, alpha: 1)
        dayDetailTitle.text = "2019年8月15日"
        dayDetailTitle.font = UIFont(name: fontRictyBold, size: 18)
        self.contentView.addSubview(dayDetailTitle)

        // 時計の画像
        clockImg.image = UIImage(named: "hour")
        clockImg.layer.borderColor = UIColor.clear.cgColor
        clockImg.layer.borderWidth = 0.5
        // TODO : テーマによって時計の画像を差し替える
        clockImg.backgroundColor = .clear
        clockImg.layer.backgroundColor = UIColor.clear.cgColor
        self.contentView.addSubview(clockImg)

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
        self.contentView.addSubview(circularSlider)

        // 時間テキスト
        dayDetailHour.text = "4.5h"
        dayDetailHour.font = UIFont(name: fontRicty, size: 18)
        dayDetailHour.textAlignment = .center
        self.contentView.addSubview(dayDetailHour)

        // 詳細
        detailTextView.textColor = .black
        detailTextView.text = "\nほげ\nhogehoghe\nhgohge\nほげ\nhogehoghe\nhgohgehogheohgoehgoehgoehgoheoghoege"
        detailTextView.font = UIFont(name: fontRicty, size:18)
        detailTextView.isEditable = false
        self.contentView.addSubview(detailTextView)

        // 編集ボタン
        editBtn.backgroundColor = .white
        editBtn.layer.borderWidth = 1.0
        editBtn.setImage(UIImage(named:"edit"), for: .normal)
        editBtn.imageView?.contentMode = .scaleAspectFit
        editBtn.contentHorizontalAlignment = .fill
        editBtn.contentVerticalAlignment = .fill
        self.contentView.addSubview(editBtn)
    }
    
    private func layoutDetailTitle() {
        // 詳細タイトルのアイコン
        iconTitleImgView.frame = CGRect(
            x:paddingLeft,
            y:self.contentView.frame.height/20,
            width:20,
            height:20
        )
        // 詳細タイトル
        dayDetailTitle.frame = CGRect(
            x: iconTitleImgView.frame.maxX + paddingLeft,
            y: self.contentView.frame.height/20,
            width: self.contentView.frame.width - paddingLeft*2,
            height: self.contentView.frame.height/10
        )
        dayDetailTitle.sizeToFit()
    }
    
    private func layoutClock() {
        clockImg.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: self.contentView.frame.width*0.45 - 50,
            height: self.contentView.frame.width*0.45 - 50
        )
        clockImg.center.x = self.contentView.center.x
        clockImg.layer.cornerRadius = clockImg.frame.width/2

        circularSlider.frame = CGRect(
            x: 0,
            y: dayDetailTitle.frame.maxY,
            width: self.contentView.frame.width*0.35,
            height: self.contentView.frame.width*0.35
        )
        circularSlider.center.x = self.contentView.center.x
        // 時計画像とスライダーの位置を合わせるため両方の位置を定義に設定する
        clockImg.center.y = circularSlider.center.y
        
        
        dayDetailHour.frame = CGRect(
            x: 0,
            y: 0,
            width: self.contentView.frame.width/3,
            height: self.contentView.frame.height/15
        )
        dayDetailHour.center = circularSlider.center
    }

    private func layoutEditBtn() {
        let edge : CGFloat = 10
        editBtn.frame = CGRect(
            x: 0,
            y: self.contentView.frame.maxY - self.contentView.frame.height/16,
            width: self.contentView.frame.width/8,
            height: self.contentView.frame.width/8
        )
        editBtn.center.x = self.contentView.center.x
        editBtn.layer.cornerRadius = editBtn.frame.width/2
        editBtn.imageEdgeInsets = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge);
    }
    
    private func layoutDetailText() {
        detailTextView.frame = CGRect(
            x: paddingLeft,
            y: circularSlider.frame.maxY,
            width: self.contentView.frame.width - paddingLeft*2,
            height: self.contentView.frame.maxY - circularSlider.frame.maxY - editBtn.frame.height/2
        )
    }
}
