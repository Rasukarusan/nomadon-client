//
//  TransitionProtocol.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/25.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

enum StoryBoard :String {
    case home = "HomeView"
    case setting = "SettingView"
}

protocol TransitionProtocol {
    func transitionController(tag:Int)
}

extension TransitionProtocol where Self: UIViewController {
    func transitionController(tag:Int) {
        switch tag {
        case 0:
            goHomeView()
        case 1:
            goSettingView()
        default:
            return
        }
    }
    
    func goHomeView() {
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: StoryBoard.home.rawValue) as! TopViewController
        self.present(homeView, animated:false, completion:nil)
    }
    
    func goSettingView() {
        let settingView = self.storyboard?.instantiateViewController(withIdentifier: StoryBoard.setting.rawValue) as! SettingViewController
        self.present(settingView, animated:false, completion:nil)
//        self.navigationController?.pushViewController(settingView, animated: true)
    }
    
}

