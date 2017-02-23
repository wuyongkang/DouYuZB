//
//  YKPageContentView.swift
//  dy
//
//  Created by Eric.Wu on 17/2/17.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate : class {
    func pageContentView(contentView : YKPageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}
fileprivate let contentCellID  = "contentCellID"

class YKPageContentView: UIView {
    fileprivate var childVCs:[UIViewController]
    
    fileprivate weak var parentVC : UIViewController?
    weak var delegate : PageContentViewDelegate?
    fileprivate var isForbidScrollDelegate : Bool = false
     fileprivate var startOffsetX : CGFloat = 0
    
    fileprivate lazy var collectView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let rect = self?.bounds
        let collectionView = UICollectionView(frame: rect!, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    init(frame: CGRect,childVCs:[UIViewController],parentVC:UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame:frame)
        collectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YKPageContentView
{
    fileprivate func setUI(){
        for childVc in childVCs {
            parentVC?.addChildViewController(childVc)
        }
        addSubview(collectView)
    }
}

extension YKPageContentView : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        for view in cell.contentView.subviews
        {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        cell.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}

extension YKPageContentView :   UICollectionViewDelegate
{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 1.定义获取需要的数据
        if isForbidScrollDelegate { return }
        
        // 1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        // 3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

extension YKPageContentView
{
    func pageTitleViewSelectIndex(index: Int) {
        
        let  offSetx = CGFloat(index) * srceenW
        let point = CGPoint(x: offSetx, y: 0)
        
        collectView.setContentOffset(point, animated: false)
     }
}
