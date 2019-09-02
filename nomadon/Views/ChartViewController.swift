//
//  ChartViewController.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/09/02.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

class ChartViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // ToolBar
        let toolBar = buildToolBar()
        changeImageSelected(toolBar: toolBar, type: .chart)
        changeColorSelected(toolBar: toolBar, type: .chart)
        self.view.addSubview(toolBar)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
