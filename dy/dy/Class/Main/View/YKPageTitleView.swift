//
//  YKPageTitleView.swift
//  dy
//
//  Created by Eric.Wu on 17/2/16.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit
protocol YKPageTitleViewDelegate : class {
    func pageTitleView(titleView:YKPageTitleView,selectIndex index: Int)
}

class YKPageTitleView: UIView {
    fileprivate let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
    fileprivate let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
    fileprivate var titles : [String]
    fileprivate  var currentIndex = 0;
    weak var delegate : YKPageTitleViewDelegate?
    fileprivate lazy var srcollView : UIScrollView = {
        let frame = self.bounds
        let sc = UIScrollView()
        
        //sc.backgroundColor = UIColor.blue
        sc.bounces = false
       
        return sc
    }()
    
    fileprivate var scrolleLine : UIView = {
        let line = UIView()
        return line;
    }()
    fileprivate var labels : [UILabel] = [UILabel]();
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame:frame)
        
        addSubview(srcollView)
        
        srcollView.frame = bounds
      
        setTitlelabels()
        setbuttomMeunAndLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}

extension YKPageTitleView {
    func setTitlelabels()  {
        let labelWidth : CGFloat = srcollView.bounds.width / CGFloat(titles.count)
        let height : CGFloat = srcollView.bounds.height - 2
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.tag = index
            label.text = title
            
            label.font = UIFont.systemFont(ofSize: 16)

            let labelX :CGFloat  = CGFloat(index) * labelWidth
            label.textAlignment = .center
            label.frame = CGRect(x: labelX, y: 0, width: labelWidth, height: height)
            label.textColor = UIColor.darkGray
            
           srcollView.addSubview(label)
            labels.append(label)
            label.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
       

    }
   
    func setbuttomMeunAndLine()  {
        let  bottomLineH : CGFloat = 0.5
        let  botoomLineY = bounds.height - 0.5
        let bottomLinex : CGFloat  = 0;
        
        let line = UIView();
        line.frame = CGRect(x:bottomLinex , y: botoomLineY, width: srceenW, height: bottomLineH)
        line.backgroundColor = UIColor.darkGray
        addSubview(line)
        
        guard let firstLabel = labels.first else {
            return
        }
       scrolleLine.frame = CGRect(x: 0, y: bounds.height - 2, width: firstLabel.frame.width, height: 1.5)
        scrolleLine.backgroundColor = UIColor.orange
        srcollView.addSubview(scrolleLine)
    
    }
    
}

extension YKPageTitleView
{
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer){
        
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        let oldLabel = labels[currentIndex]
        
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        currentIndex = currentLabel.tag;
        UIView.animate(withDuration: 0.3) {
        self.scrolleLine.center.x = currentLabel.center.x
        }
       
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
}
extension  YKPageTitleView{
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        
        // 2.处理滑块的逻辑
//        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
//        let moveX = moveTotalX * progress
        UIView .animate(withDuration: 0.5) { [weak self] in
          self?.scrolleLine.frame.origin.x = targetLabel.frame.origin.x
            sourceLabel.textColor = UIColor.darkGray
            targetLabel.textColor = UIColor.orange
        }
    
        
        // 3.颜色的渐变(复杂)
        
        // 3.1.取出变化的范围
//        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
//        
//        // 3.2.变化sourceLabel
//        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
//        
//        // 3.2.变化targetLabel
//        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }
    
}
