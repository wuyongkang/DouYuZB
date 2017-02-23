//
//  UIBarButtonItem-Extension.swift
//  dy
//
//  Created by Eric.Wu on 17/1/10.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName : String,heightImageName : String,title : String,size : CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
        
        btn.setImage(UIImage(named:heightImageName), for: UIControlState.highlighted)
        btn.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        self.init(customView:btn)
    }

}
