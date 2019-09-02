//
//  ToolBarProtocol.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/25.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

enum ToolBarButton : Int {
    case home
    case setting
    
    var centerX : CGFloat {
        switch self {
        case .home:
            return UIScreen.main.bounds.size.width*0.15
        case .setting:
            return UIScreen.main.bounds.size.width*0.85
        }
    }
    
    var label : String {
        switch self {
        case .home:
            return Localizable.Toolbar.buttonLabelHome.localized
        case .setting:
            return Localizable.Toolbar.buttonLabelSetting.localized
        }
    }
    
    func iconImage(isFilled:Bool = false) -> UIImage {
        return UIImage(named: iconName(isFilled: isFilled))!
    }
    
    private func iconName(isFilled:Bool) -> String {
        switch self {
        case .home:
            return isFilled ? "HomeFilled" : "Home"
        case .setting:
            return isFilled ? "SettingFilled" : "Setting"
        }
    }
}

protocol ToolBarProtocol {
    func buildToolBar() -> UIView
    func changeImageSelected(toolBar: UIView, type: ToolBarButton)
    func changeColorSelected(toolBar: UIView, type: ToolBarButton)
}

extension ToolBarProtocol where Self: UIViewController {

    /**
     * ToolBarを生成
     */
    func buildToolBar() -> UIView {
        let toolBarHeight = Util.getToolBarHeight()
        let toolBar = UIView()
        let height = toolBarHeight + Util.getSafeAreaBottom()
        toolBar.frame = CGRect(x: 0, y: self.view.frame.height - height, width: self.view.frame.width, height: height)
        toolBar.backgroundColor = .white
        
        // UpperLine
        let borderView = CALayer()
        borderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1.0)
        borderView.backgroundColor = UIColor.lightGray.cgColor
        toolBar.layer.addSublayer(borderView)
        
        // ToolBarButton
        let homeBtn = createToolBarButton(type: .home)
        let settingBtn = createToolBarButton(type: .setting)
        toolBar.addSubview(homeBtn)
        toolBar.addSubview(settingBtn)
        
        // ToolBarButtonLabel
        toolBar.addSubview(createButtonLabel(targetBtn: homeBtn, type: .home))
        toolBar.addSubview(createButtonLabel(targetBtn: settingBtn, type: .setting))
        
        return toolBar
    }

    
    /**
     * 指定したボタンの画像をFilledのものに差し替える
     */
    func changeImageSelected(toolBar: UIView, type: ToolBarButton) {
        let targetBtn:UIButton = toolBar.findButtons(tag: type.rawValue).first!
        targetBtn.setBackgroundImage(type.iconImage(isFilled: true), for: .normal)
    }
    
    /**
     * 指定したラベルのテキスト色を変更
     */
    func changeColorSelected(toolBar: UIView, type: ToolBarButton) {
        let targetLbl:UILabel = toolBar.findLabels(text: type.label).first!
        targetLbl.textColor = UIColor.hexStr("#3498db", alpha: 1.0)
    }
    
    /**
     * ToolBarボタンを生成
     *
     * @return UIButton
     */
    private func createToolBarButton(type: ToolBarButton) -> UIButton {
        let button = UIButton()
        button.frame.size = CGSize(width: 32, height: 32)
        button.frame.origin.y = 4
        button.center.x = type.centerX
        button.tag = type.rawValue
        button.setBackgroundImage(type.iconImage(), for: .normal)
        button.addTarget(self, action: #selector(BaseViewController.toolBarButtonAction), for: .touchUpInside)
        return button
    }
    
    /**
     * ToolBarボタンのラベル生成
     *
     * @return UILabel
     */
    private func createButtonLabel(targetBtn: UIButton, type:ToolBarButton) -> UILabel {
        let label = UILabel()
        label.frame.size = CGSize(width: 50, height: 10)
        label.frame.origin.y = targetBtn.frame.maxY + 1
        label.center.x = targetBtn.center.x
        label.text = type.label
        label.font = .systemFont(ofSize: 9)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }
}
