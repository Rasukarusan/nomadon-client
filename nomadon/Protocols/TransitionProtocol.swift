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
    case list = "ListView"
    case chart = "ChartView"
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
            goListView()
        case 2:
            goChartView()
        case 3:
            goSettingView()
        default:
            return
        }
    }
    
    func goHomeView() {
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: StoryBoard.home.rawValue) as! TopViewController
        self.present(homeView, animated:false, completion:nil)
    }
    
    func goListView() {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: StoryBoard.list.rawValue) as! ListViewController
        self.present(listView, animated:false, completion:nil)
    }
    
    func goChartView() {
        let chartView = self.storyboard?.instantiateViewController(withIdentifier: StoryBoard.chart.rawValue) as! ChartViewController
        self.present(chartView, animated:false, completion:nil)
    }
    
    func goSettingView() {
        let settingView = self.storyboard?.instantiateViewController(withIdentifier: StoryBoard.setting.rawValue) as! SettingViewController
        self.present(settingView, animated:false, completion:nil)
//        self.navigationController?.pushViewController(settingView, animated: true)
    }
    
}

