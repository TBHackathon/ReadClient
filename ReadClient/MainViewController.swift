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
    
    var newsList = Array<Dictionary<String, AnyObject>>()
    
    let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.setupNavigationBar()
        
        self.setupTableView()
        
        self.requestListData()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        
        self.title = "FEED.lite"
//        let rightItem = UIBarButtonItem(image: UIImage(named: "usericon64"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(goToUserCenter))
//        rightItem.tintColor = UIColor.white
//        
//        let rightItem1 = UIBarButtonItem(image: UIImage(named: "usericon64"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(goToUserCenter1))
//        rightItem1.tintColor = UIColor.white
//        
//        self.navigationItem.rightBarButtonItems = [rightItem, rightItem1]
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: Constant.MainCellReuseIdentifier)
        
        self.view.addSubview(self.tableView)
    }
    
    func goToUserCenter() {
//        Networking.requestDetail(newsID: 0) {
//            print("requestDetail")
//        }
        Networking.requestDetail(newsID: 0) { (dict: Dictionary<String, AnyObject>) in
            print("\(dict)")
        }
    }
    
    func goToUserCenter1() {
        Networking.requestNewsList(newsID: 0, count: 10) { (dict: Dictionary<String, AnyObject>) in

            for key in dict.keys {
                self.newsList.append(dict[key] as! Dictionary<String, AnyObject>)
            }
            self.tableView.reloadData()
        }
    }

    func requestListData() {
        Networking.requestNewsList(newsID: 0, count: 95) { (dict: Dictionary<String, AnyObject>) in
            
            for key in dict.keys {
                self.newsList.append(dict[key] as! Dictionary<String, AnyObject>)
            }
            self.tableView.reloadData()
        }
    }}

extension MainViewController {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

extension MainViewController {
    func push(keyCell: MainTableViewCell,indexNum:Int) {
        let vc = DetailViewController(tid:indexNum)
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
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.MainCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell is MainTableViewCell {
            self.push(keyCell: cell as! MainTableViewCell, indexNum:indexPath.item)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is MainTableViewCell {
            let mainCell = cell as! MainTableViewCell
            
            let obj = self.newsList[indexPath.row]
            
            mainCell.bindData(title: obj["title"] as! String, bgImageURLString: obj["picture"] as! String)
        }
        
    }
}
