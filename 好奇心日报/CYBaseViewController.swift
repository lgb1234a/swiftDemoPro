//
//  CYBaseViewController.swift
//  好奇心日报
//
//  Created by chenyn on 16/11/2.
//  Copyright © 2016年 chenyn. All rights reserved.
//

/*
 *  自定义的ViewController基类，实现悬浮按钮的点击，显示，隐藏
 */

import Foundation
import SnapKit

class CYBaseViewController: UIViewController, CYBlurEffectViewDelegate {
    
    let touchBtnWidth = 40.0
    let touchBtnHeight = 40.0
    let touchBtn = UIButton.init(type: UIButtonType.system);
    var blurEffectView : CYBlurEffectView? = nil;
    var downHeight : CGFloat = 0.0;
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // 重写
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downHeight = CGFloat(kScreenSize.height * 0.1) + CGFloat(touchBtnHeight)
        
        self.initIndexPage()
        self.initTouchBtn()
    }
    
    // 初始化索引页
    func initIndexPage() {
        
        self.blurEffectView = Bundle.main.loadNibNamed("CYBlurEffectView", owner: nil, options: nil)?.first as! CYBlurEffectView?
        self.blurEffectView?.delegate = self
    }
    
    // 初始化按钮
    func initTouchBtn() {
        
        self.view.addSubview(touchBtn)
        touchBtn.setTitle("悬", for: UIControlState.normal)
        touchBtn.setTitle("挂", for: UIControlState.selected)
        touchBtn.tintColor = UIColor.black;
        touchBtn.addTarget(self, action: #selector(tapHomeBtn), for: UIControlEvents.touchUpInside)
        
        touchBtn.snp_updateConstraints{ (make) in
            
            make.width.equalTo(self.touchBtnWidth)
            make.height.equalTo(self.touchBtnHeight)
            make.left.equalTo(self.view.snp_left).offset(kScreenSize.width * 0.1)
            make.bottom.equalTo(self.view.snp_bottom).offset(0 - kScreenSize.height * 0.1)
        };
    }
    
    // 隐藏或显示模糊View
    func hideOrShowIndexPage(isNeedHide: Bool) {
        
        if isNeedHide
        {
            self.blurEffectView?.removeFromSuperview()
        }else
        {
            self.view.addSubview(self.blurEffectView!)
            self.view.bringSubview(toFront: self.touchBtn)
        }
    }
    
    // 按钮点击事件
    func tapHomeBtn() {
        
        touchBtn.isSelected = !touchBtn.isSelected
        
        self.hideOrShowIndexPage(isNeedHide: !touchBtn.isSelected)
        //动画
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.downToOutsideScreen()
        }, completion: {(finished:Bool) -> Swift.Void in
            UIView.animate(withDuration: 0.3, animations: {() -> Void in
                self.backToOrigin()
            })
        })
    }
    
    
    // 按钮上弹
    func backToOrigin() {
        self.touchBtn.layer.setAffineTransform(CGAffineTransform.identity)
    }
    
    // 按钮下弹
    func downToOutsideScreen() {
        self.touchBtn.layer.setAffineTransform(CGAffineTransform.init(translationX: 0, y: self.downHeight))
    }
    
// CYBlurEffectViewDelegate func
    // 隐藏模糊View
    func shouldHideBlurView(isShouldHide: Bool) {
//        self.hideOrShowIndexPage(isNeedHide: isShouldHide)
        self.tapHomeBtn()
    }
    
    // push好奇心研究所
    func shouldPushNewVCToPapers() {
        let tableViewC = CYBaseTableViewController.init(style: UITableViewStyle.plain)
        
        self.navigationController?.pushViewController(tableViewC, animated: true)
    }
}
