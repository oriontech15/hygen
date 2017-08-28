//
//  CustomCollectionViewLayout.swift
//  DHS
//
//  Created by Justin Smith on 6/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
        
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
        ) -> CGPoint {
        
        guard
            let collectionView = collectionView
            else {
                return super.targetContentOffset(
                    forProposedContentOffset: proposedContentOffset,
                    withScrollingVelocity: velocity
                )
        }
        
        let realOffset = CGPoint(
            x: proposedContentOffset.x + collectionView.contentInset.left,
            y: proposedContentOffset.y + collectionView.contentInset.top
        )
        
        let targetRect = CGRect(origin: proposedContentOffset, size: collectionView.bounds.size)
        
        var offset = (scrollDirection == .horizontal)
            ? CGPoint(x: CGFloat.greatestFiniteMagnitude, y:0.0)
            : CGPoint(x:0.0, y:CGFloat.greatestFiniteMagnitude)
        
        offset = self.layoutAttributesForElements(in: targetRect)?.reduce(offset) {
            (offset, attr) in
            let itemOffset = attr.frame.origin
            return CGPoint(
                x: abs(itemOffset.x - realOffset.x) < abs(offset.x) ? itemOffset.x - realOffset.x : offset.x,
                y: abs(itemOffset.y - realOffset.y) < abs(offset.y) ? itemOffset.y - realOffset.y : offset.y
            )
            } ?? .zero
        
        return CGPoint(x: proposedContentOffset.x + offset.x, y: proposedContentOffset.y + offset.y)
    }
}
