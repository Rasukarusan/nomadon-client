//
//  BaseViewController.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/25.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

class BaseViewController : UIViewController,TransitionProtocol,ToolBarProtocol {
    /**
     * ToolBarButtonのアクション
     */
    @objc func toolBarButtonAction(sender:UIButton) {
        transitionController(tag: sender.tag)
    }
}
