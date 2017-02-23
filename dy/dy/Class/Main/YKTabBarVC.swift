//
//  YKTabBarVC.swift
//  dy
//
//  Created by Eric.Wu on 17/1/10.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit

class YKTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVCs(vc: YKHomeViewController(), title:"首页", imageName: "btn_home_")
        addChildVCs(vc: YKLiveViewController(), title:"直播", imageName: "btn_column_")
        addChildVCs(vc: YKFollowViewController(), title:"关注", imageName: "btn_live_")
        addChildVCs(vc: YKProfileViewController(), title:"我的", imageName: "btn_user_")
    }

   
}

extension YKTabBarVC{
    
    fileprivate func addChildVCs(vc:UIViewController,title:String,imageName:String){
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName + "normal")
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        //        vc.tabBarItem.title = "skdsk"
        let nav  = UINavigationController(rootViewController:vc)
        
        addChildViewController(nav)

    }
}
