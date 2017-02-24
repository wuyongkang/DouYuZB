//
//  YKRecommentHeader.swift
//  dy
//
//  Created by Eric.Wu on 17/2/24.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit
fileprivate let kmargin : CGFloat = 10
fileprivate let itemW = (srceenW - (5 * KMargin)) / 4
fileprivate let itemH = (YKCycleViewH + YKGameViewH - 3 * KMargin) / 2

class YKRecommentHeader: UIView {

    
    fileprivate var collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: itemW, height: itemH)
        let rect = CGRect(x: 0, y: 0, width: srceenW, height: YKCycleViewH + YKGameViewH)
        
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension YKRecommentHeader {
    func setUI()  {
        
        self.addSubview(collectionView)
    }
}
