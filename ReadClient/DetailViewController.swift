//
//  DetailViewController.swift
//  ReadClient
//
//  Created by 孙恺 on 2017/10/26.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit
import TransitionTreasury
import TransitionAnimation

class DetailViewController: UIViewController {
    
    var scrollView = UIScrollView()
    
    var tr_pushTransition: TRNavgationTransitionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        
        self.setupScrollView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        let leftItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pop))
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func setupScrollView() {
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.ScreenHeight))
        self.scrollView.backgroundColor = UIColor.white
        self.view.addSubview(self.scrollView)
    }
}

extension DetailViewController {
    
}

extension DetailViewController {
    func updateNavigationBarStyle() {
        self.navigationController?.navigationBar.alpha = 0;
    }
}

extension DetailViewController: NavgationTransitionable {
    
    func pop() {
        self.navigationController?.tr_popViewController({
            
        })
    }
}
