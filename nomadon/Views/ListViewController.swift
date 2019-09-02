//
//  ListViewController.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/09/02.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // ToolBar
        let toolBar = buildToolBar()
        changeImageSelected(toolBar: toolBar, type: .list)
        changeColorSelected(toolBar: toolBar, type: .list)
        self.view.addSubview(toolBar)
    }
}
