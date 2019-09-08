//
//  DetailPagingView.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/09/04.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

class DetailPagingView: UICollectionView {
    let cellIdentifier = "carousel"
    let pageCount = 5
    let colors:[UIColor] = [.blue,.yellow,.red,.green,.gray]
    let isInfinity = true
    var cellItemsWidth: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(DetailCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    convenience init(frame: CGRect) {
        let layout = PagingPerCellFlowLayout()
        layout.itemSize = CGSize(width: frame.width*0.99, height: frame.height*0.9)
        layout.scrollDirection = .horizontal

        self.init(frame: frame, collectionViewLayout: layout)
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 画面内に表示されているセルを取得
        let cells = self.visibleCells
        for cell in cells {
            // ここでセルのScaleを変更する
            transformScale(cell: cell)
        }
    }
    
    func transformScale(cell: UICollectionViewCell) {
        let cellCenter:CGPoint = self.convert(cell.center, to: nil) //セルの中心座標
        let screenCenterX:CGFloat = UIScreen.main.bounds.width / 2  //画面の中心座標x
        let reductionRatio:CGFloat = -0.0005                        //縮小率
        let maxScale:CGFloat = 1                                    //最大値
        let cellCenterDisX:CGFloat = abs(screenCenterX - cellCenter.x)   //中心までの距離
        let newScale = reductionRatio * cellCenterDisX + maxScale   //新しいスケール
        cell.transform = CGAffineTransform(scaleX:newScale, y:newScale)
        cell.frame.origin.y = 1
    }
}

extension DetailPagingView: UICollectionViewDelegate {
    
}

extension DetailPagingView: UICollectionViewDataSource {
    // セクションごとのセル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isInfinity ? pageCount * 3 : pageCount
    }
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DetailCell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DetailCell
        print(cell)
        
        return cell
    }
}
