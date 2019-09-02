//
//  Util.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/07.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

class Util {
    
    /**
     * ステータスバーの高さを取得する
     * iPhoneX以下なら0が返る
     *
     * @return CGFloat
     */
    class func getStatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    /**
     * iPhoneX以降のセーフティエリアのサイズを取得
     * viewDidLayoutSubviews()以降でないと取得できない(viewDidload内では取得できない)
     *
     * @return CGFloat
     */
    class func getSafeAreaBottom() -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    
    class func getToolBarHeight() -> CGFloat {
        return 50
    }
    
    /**
     * フォント名を返す
     *
     * @return String
     */
    class func getFontName(isBold : Bool = false) -> String {
        if isBold {
            return "Ricty-Bold"
        }
        return "Ricty-Regular"
    }
    
}
