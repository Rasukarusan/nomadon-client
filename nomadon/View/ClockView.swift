//
//  ClockView.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/10.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

class ClockView: UIView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    func degreesToRadians (number: Int) -> CGFloat {
        return CGFloat(number) * CGFloat(Double.pi) / 180.0
    }

    var endAngle:Int = 0
    {
        didSet {
            if oldValue != endAngle {
                self.setNeedsDisplay()
            }
        }
    }
    
    var radius:CGFloat = 40
    {
        didSet {
            if oldValue != radius {
                self.setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        // 枠線用の丸
        let circleStart: CGFloat = degreesToRadians(number: 0)
        let circleEnd: CGFloat = degreesToRadians(number: 360)
        let circle = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: circleStart,
            endAngle: circleEnd,
            clockwise: true
        )
        UIColor.white.setFill()
        circle.lineWidth = 1.0
        UIColor.black.setStroke()
        circle.stroke()
        circle.addLine(to: center)
        circle.fill()
        
        // 塗りつぶし用
        let startAngle: CGFloat = degreesToRadians(number: -90)
        let pi = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: degreesToRadians(number: endAngle),
            clockwise: true
        )
        UIColor(red: 0.1441, green: 0.3364, blue: 0.8777, alpha: 0.5).setFill()
        pi.addLine(to: center)
        pi.fill()
    }
}
