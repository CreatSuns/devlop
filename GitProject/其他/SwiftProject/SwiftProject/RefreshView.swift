//
//  RefreshView.swift
//  SwiftProject
//
//  Created by 李世航 on 2018/8/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class RefreshView: UIView {
    
    var label = UILabel()
    
    var image = UIImageView()
    
    var activeView = UIActivityIndicatorView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label.text = "下拉刷新"
        self.label.textAlignment = .center
        self.image.image = UIImage(named: "icon_check_selected")
        self.addSubview(self.label)
        self.addSubview(self.activeView)
        
        self.activeView.color = .red
        self.activeView.startAnimating()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.size.equalTo(CGSize(width: 100, height: 20))
        }
        self.activeView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.label.snp.centerY);
            make.right.equalTo(self.label.snp.left).offset(-20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
