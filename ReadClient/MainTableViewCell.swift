//
//  MainTableViewCell.swift
//  ReadClient
//
//  Created by 孙恺 on 2017/10/26.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupCellUI()
    }
    
    func setupCellUI() {
        let titleLabel = UILabel(frame: CGRect(x: Constant.ScreenPadding.left, y: 0, width: Constant.ScreenWidth - Constant.ScreenPadding.left + Constant.ScreenPadding.right, height: 40))
        self.contentView.addSubview(titleLabel)
        
        let bgImageView = UIImageView(frame: self.bounds)
        self.contentView.addSubview(bgImageView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
