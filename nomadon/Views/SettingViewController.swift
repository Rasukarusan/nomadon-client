//
//  SettingViewController.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/25.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // ToolBar
        let toolBar = buildToolBar()
        changeImageSelected(toolBar: toolBar, type: .setting)
        changeColorSelected(toolBar: toolBar, type: .setting)
        self.view.addSubview(toolBar)
    }
}
