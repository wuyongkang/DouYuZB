//
//  YKHomeViewController.swift
//  dy
//
//  Created by Eric.Wu on 17/1/10.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit
let navigationBarH : CGFloat =  44

let StateBarH : CGFloat = 20

let srceenW : CGFloat = UIScreen.main.bounds.width

let srceenH : CGFloat = UIScreen.main.bounds.height

let titleViewH : CGFloat = 44

let tabbarH : CGFloat = 49

let ReuseIdentifier : String = "ReuseIdentifier"



class YKHomeViewController: BSViewController {

    lazy var pagetitlesView : YKPageTitleView = {
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let frame = CGRect(x: 0, y: 64, width:srceenW , height: titleViewH)
        
        let titleView = YKPageTitleView(frame: frame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    lazy var contentView: YKPageContentView = {[weak self] in
        let contentH = srceenH - StateBarH - titleViewH - navigationBarH
        let contentFrame = CGRect(x: 0, y: StateBarH + titleViewH + navigationBarH , width: srceenW, height: contentH)
        var childVCs = [UIViewController]()
        let recommentVC = YKRecommendVC()
        childVCs.append(recommentVC)
        for _ in 0..<3{
            let vc = UIViewController()
           childVCs.append(vc)
        }
        let pageContentView = YKPageContentView(frame: contentFrame, childVCs: childVCs, parentVC: self!)
         pageContentView.delegate = self
        return pageContentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setNav()
        
        setPageTitleView()
        
        automaticallyAdjustsScrollViewInsets = false
        contentView.backgroundColor = UIColor.purple
        view.addSubview(contentView)
       
    }


}

extension YKHomeViewController : YKPageTitleViewDelegate{
    fileprivate func setPageTitleView(){
    
        self.view.addSubview(pagetitlesView)
    }
    
    func pageTitleView(titleView: YKPageTitleView, selectIndex index: Int) {
        contentView.pageTitleViewSelectIndex(index: index)
    }
}

extension YKHomeViewController{
    
    fileprivate func setNav(){
        let btn = UIButton()
        btn .setImage(UIImage(named:"logo"), for: UIControlState.normal)
         btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:btn)
        let size = CGSize(width: 40, height: 40)
        let  historyItem = UIBarButtonItem(imageName: "image_my_history", heightImageName: "Image_my_history_click", title: "", size: size)
        let  searchItem = UIBarButtonItem(imageName: "btn_search", heightImageName: "btn_search_clicked", title: "", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", heightImageName: "Image_scan_click", title: "", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]

        
                
    }
}
// MARK:- 遵守PageContentViewDelegate协议
extension YKHomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: YKPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pagetitlesView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

