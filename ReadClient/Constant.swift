//
//  Constant.swift
//  ReadClient
//
//  Created by 孙恺 on 2017/10/26.
//  Copyright © 2017年 baidu. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    static var BaseURLString: String {
        get {
            return "http://172.24.160.164:8000"
        }
    }
    
    static var ReadClientReloadTableViewNotification: String {
        get {
            return "ReadClientReloadTableViewNotification"
        }
    }
    
    static var MainCellHeight: CGFloat {
        get {
            return 88.0
        }
    }
    
    static var MainCellReuseIdentifier: String {
        get {
            return "MainCellReuseIdentifier"
        }
    }
    
    static var ScreenWidth: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    
    static var ScreenHeight: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
    
    static var ScreenPadding: UIEdgeInsets {
        get {
            return UIEdgeInsetsMake(0, 8, 0, 8)
        }
    }
}
