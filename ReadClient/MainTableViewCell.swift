//
//  MainTableViewCell.swift
//  ReadClient
//
//  Created by 孙恺 on 2017/10/26.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var bgImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCellUI() {
        self.titleLabel = UILabel(frame: CGRect(x: Constant.ScreenPadding.left, y: 0, width: Constant.ScreenWidth - Constant.ScreenPadding.left + Constant.ScreenPadding.right, height: 40))
        self.contentView.addSubview(self.titleLabel)
        
        self.bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.MainCellHeight))
        self.contentView.addSubview(self.bgImageView)
    }
    
    func bindData(title: String, bgImageURLString: String) {
        self.titleLabel.text = title
        self.bgImageView.kf.setImage(with: URL(string: bgImageURLString), placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil) { (image: Image?, error: NSError?, cacheType: CacheType, url: URL?) in
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
