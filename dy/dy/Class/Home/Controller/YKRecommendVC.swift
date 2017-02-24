//
//  YKRecommendVC.swift
//  dy
//
//  Created by Eric.Wu on 17/2/23.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit
let KMargin : CGFloat = 10

let KItemW : CGFloat = (srceenW - 3 * KMargin) / 2
let kItemH : CGFloat =  200
let YKCycleViewH  = srceenH / 4
// 游戏view
let YKGameViewH : CGFloat = 90
private let ID : String = "Identifier"
private let HeaderID : String = "HeaderID"
class YKRecommendVC: BSViewController {

    fileprivate lazy var collectView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: kItemH)
        layout.minimumLineSpacing = KMargin
        layout.minimumInteritemSpacing = KMargin
        layout.sectionInset = UIEdgeInsetsMake(0, KMargin, 0, KMargin)
        layout.headerReferenceSize = CGSize(width: srceenW, height: 44)
        let rect = CGRect(x: 0, y: 0, width: (self?.view.bounds.width)!, height: srceenH)
        let collectionView = UICollectionView(frame: rect
            , collectionViewLayout: layout)
        collectionView.dataSource = self as UICollectionViewDataSource?
      
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

   

}

extension YKRecommendVC
{
    fileprivate func setUI(){
        
        collectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ID)
        collectView.contentInset = UIEdgeInsetsMake(YKCycleViewH + YKGameViewH, 0, 49 + 64 + 44, 0)
        collectView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderID)
        self.view.addSubview(collectView)
        
    }
}

// Mark 实现数据源方法
extension YKRecommendVC : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }else{
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderID, for: indexPath)
        header.backgroundColor = UIColor.green
        return header
        
    }
}
