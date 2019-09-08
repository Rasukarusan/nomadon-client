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
    public var detailPagingView:DetailPagingView!
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
        layoutDetailPagingView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // カレンダー
        calendar.setScope(.week, animated: true)
        calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 0)
        calendar.appearance.borderRadius = 10
        calendar.appearance.headerTitleFont = UIFont(name: Util.getFontName(),size: 18)
        calendar.appearance.weekdayFont = UIFont(name: Util.getFontName(), size: 18)
        calendar.appearance.titleFont = UIFont(name: Util.getFontName(), size: 18)
        calendar.appearance.headerDateFormat = Localizable.Calendar.headerDateFormat.localized
        calendar.appearance.subtitleSelectionColor = .black
        calendar.appearance.subtitleTodayColor = .black
        self.addSubview(calendar)
        
        detailPagingView = DetailPagingView(frame:CGRect(
            x: 0,
            y: Util.getStatusBarHeight(),
            width: frame.width*0.9,
            height: frame.height/2
                - frame.height/25
                - Util.getStatusBarHeight()
        ))

        detailPagingView.contentInset = .zero
        self.addSubview(detailPagingView)
    }

    private func layoutCalendar() {
        calendar.frame = CGRect(
            x: 0,
            y: frame.height/2 - Util.getSafeAreaBottom(),
            width: frame.width,
            height: frame.height/2 - Util.getToolBarHeight() - Util.getSafeAreaBottom()
        )
    }
    
    private func layoutDetailPagingView() {
//        detailPagingView.frame = CGRect(
//            x: 0,
//            y: Util.getStatusBarHeight(),
//            width: frame.width - frame.width/13,
//            height: frame.height/2
//                - frame.height/25
//                - Util.getStatusBarHeight()
////                - Util.getSafeAreaBottom()
//        )
        detailPagingView.center.x = self.center.x
//        detailPagingView.backgroundColor = .green
    }
    
}

