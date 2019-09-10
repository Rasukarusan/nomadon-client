//
//  PagingPerCellFlowLayout.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/09/04.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit

class PagingPerCellFlowLayout: UICollectionViewFlowLayout {

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        let largeFlickVelocityThreshold: CGFloat = 2.0
        let minimumFlickVelocityThreshold: CGFloat = 0.5
        let pageWidth = itemSize.width + minimumLineSpacing
        let currentPage = collectionView.contentOffset.x / pageWidth

        if abs(velocity.x) > largeFlickVelocityThreshold {
            // velocityが大きいときは2つ動かす
            let nextPage = (velocity.x > 0.0) ? ceil(currentPage) + 1 : floor(currentPage) - 1
            return CGPoint(x: nextPage * pageWidth, y: proposedContentOffset.y)
        } else if abs(velocity.x) > minimumFlickVelocityThreshold {
            // 1つ動かす
            let nextPage = (velocity.x > 0.0) ? ceil(currentPage) : floor(currentPage)
            return CGPoint(x: nextPage * pageWidth, y: proposedContentOffset.y)
        }
        // velocityが小さすぎるときは近いほうへ
        return CGPoint(x: round(currentPage) * pageWidth, y: proposedContentOffset.y)
    }
}
