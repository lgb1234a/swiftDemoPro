//
//  CYBlurEffectView.swift
//  好奇心日报
//
//  Created by chenyn on 16/11/3.
//  Copyright © 2016年 chenyn. All rights reserved.
//

import Foundation

protocol CYBlurEffectViewDelegate {
    
    func shouldHideBlurView(isShouldHide: Bool)
    
    func shouldPushNewVCToPapers()
}

class CYBlurEffectView: UIView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CY_UIIdentifier {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var pageScrollView: UIScrollView!
    @IBOutlet weak var indexTableView: UITableView!
    var delegate: CYBlurEffectViewDelegate?
    
    let dataSource: [String] = ["新闻分类 >", "好奇心研究所", "宠物协会", "华夏基因", "人与鱼与雨"]
    
    static func loadFromDefaultNib<T: CYBlurEffectView>() -> T where T: CY_UIIdentifier {
        
//        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as! CYBlurEffectView
//        return Bundle.main.loadNibNamed(CYBlurEffectView.identifier, owner: nil, options: nil)?.first as! CYBlurEffectView
        
        guard let viewInitialed = Bundle.main.loadNibNamed(T.CY_identifier, owner: nil, options: nil)?.first as? T
        else {
            fatalError("无法用\(T.CY_identifier)从Nib文件中生成一个UIView实例对象")
        }
        
        return viewInitialed
    }
    
    override func awakeFromNib() {
        self.indexTableView.delegate = self
        self.indexTableView.dataSource = self
        self.indexTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.CY_identifier.baseCell.rawValue)
        
        self.pageScrollView.isPagingEnabled = true
        self.pageScrollView.contentSize = CGSize.init(width: kScreenSize.width * 2, height: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.CY_identifier.baseCell.rawValue, for: indexPath)
        
        cell.textLabel?.text = self.dataSource[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if indexPath.row == 0
        {
            // 新闻分类
        }else if indexPath.row == 1
        {
            // 好奇心研究所
            self.delegate?.shouldHideBlurView(isShouldHide: true)
            self.delegate?.shouldPushNewVCToPapers()
        }
    }
}
