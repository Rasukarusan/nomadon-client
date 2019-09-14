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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(DetailCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    convenience init(frame: CGRect) {
        let layout = PagingPerCellFlowLayout()
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.scrollDirection = .horizontal
        self.init(frame: frame, collectionViewLayout: layout)
    }
}

