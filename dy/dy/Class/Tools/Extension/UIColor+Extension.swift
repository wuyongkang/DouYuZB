//
//  UIColor+Extension.swift
//  dy
//
//  Created by Eric.Wu on 17/2/17.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit

extension UIColor{
    convenience  init(r: CGFloat,g: CGFloat,b: CGFloat) {
        self.init(red: r/255.0,green: g/255.0,blue:b/255.0,alpha:1.0)
    }
}
 
