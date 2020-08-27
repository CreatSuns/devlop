//
//  MyCell.swift
//  SwiftProject
//
//  Created by 李世航 on 2018/7/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

public protocol CellDelegate : NSObjectProtocol {
    func abc(string: String) -> Void
}


class MyCell: UITableViewCell {
    
    weak open var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        delegate?.abc(string: "asdfghj")
    }

}
