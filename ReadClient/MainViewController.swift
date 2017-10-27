//
//  MainViewController.swift
//  ReadClient
//
//  Created by 孙恺 on 2017/10/26.
//  Copyright © 2017年 baidu. All rights reserved.
//

import UIKit
import TransitionTreasury
import TransitionAnimation

class MainViewController: UIViewController {
    
    let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.setupTableView()
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        self.unregisterForNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: Constant.MainCellReuseIdentifier)
        
        self.view.addSubview(self.tableView)
    }
}

extension MainViewController {
    func registerForNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name.init(Constant.ReadClientReloadTableViewNotification), object: nil)
    }
    
    func unregisterForNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

extension MainViewController {
    func push(keyCell: MainTableViewCell) {
        let vc = DetailViewController()
        
        let keyCellBackgroundView = keyCell.bgImageView
        
        self.navigationController?.tr_pushViewController(vc, method: TRPushTransitionMethod.blixt(keyView: keyCellBackgroundView, to: CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: 300)), statusBarStyle: TRStatusBarStyle.default, completion: {
            print("push finish")
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var mainCell = tableView.dequeueReusableCell(withIdentifier: Constant.MainCellReuseIdentifier)
        
        if (mainCell == nil) {
            mainCell = MainTableViewCell(style: .default, reuseIdentifier: Constant.MainCellReuseIdentifier)
        }
        
        return mainCell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.MainCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell is MainTableViewCell {
            self.push(keyCell: cell as! MainTableViewCell)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is MainTableViewCell {
            let mainCell = cell as! MainTableViewCell
            
            mainCell.bindData(title: "Hehehehe", bgImageURLString: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2968594711,2709755318&fm=27&gp=0.jpg")
        }
        
    }
}
