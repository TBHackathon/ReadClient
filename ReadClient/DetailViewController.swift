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
import Kingfisher

class DetailViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var detailHeaderImageView = UIImageView()
    var detailTitleLabel = UILabel()
    var detailTextView = UITextView()
    var tr_pushTransition: TRNavgationTransitionDelegate?
    var originText = String()

    var headUrl: String?
    var tidV: Int?
    
    
    init(tid:Int) {
        tidV = tid
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
 
    public func setTidValue (tid:Int) {
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupSubViews()
        self.setupModel()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.hideOrShowHeaderView(isHidden: false)
    }
    
    func setupNavigationBar() {
        let leftItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pop))
        leftItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(title: "原文", style: UIBarButtonItemStyle.plain, target: self, action: #selector(origin))
        leftItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func setupSubViews() -> Void {
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.ScreenHeight))
        self.scrollView.backgroundColor = UIColor.white
        self.scrollView.contentSize = CGSize(width: Constant.ScreenWidth, height: Constant.ScreenHeight + 200)
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        
        self.detailHeaderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: 300-64))
        self.detailHeaderImageView.isHidden = true
        self.scrollView.addSubview(self.detailHeaderImageView)
        
        self.detailTitleLabel = UILabel(frame: CGRect(x: 0, y: 200, width: Constant.ScreenWidth, height: 100))
        self.detailTitleLabel.font = UIFont.systemFont(ofSize: 18.0)
        self.detailTitleLabel.numberOfLines = 0
        self.detailTitleLabel.textColor = UIColor.white
        self.scrollView.addSubview(self.detailTitleLabel)
        
        
        self.detailTextView = UITextView(frame: CGRect(x: 0, y: 300-64, width: Constant.ScreenWidth, height: Constant.ScreenHeight))
        self.detailTextView.font = UIFont.systemFont(ofSize: 15.0)
        self.scrollView.addSubview(detailTextView)
        
    }
    
    func setupModel() -> Void {
        
        Networking.requestDetail(newsID: self.tidV!) { (dict: Dictionary<String, AnyObject>) in
            var contentD = Dictionary<String, AnyObject>()
            contentD = dict["0"] as! [String : AnyObject]
            var newsTitle = contentD["title"] as? String
            let headUrl = contentD["picture"] as! String
            let detailText = contentD["detail"] as? String
            self.originText = contentD["content"] as! String
            
            
            if ((detailText != nil) ) {
//                print(detailText)
                self.detailTextView.text = detailText
            }
            
            self.title = newsTitle
            
            self.detailTitleLabel.text = newsTitle
            self.detailHeaderImageView.kf.setImage(with: URL(string: headUrl), placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil) { (image: Image?, error: NSError?, cacheType: CacheType, url: URL?) in
                
            }
            
        }
    }
    
    func heightForTextView() {
        let size = CGSize(width: Constant.ScreenWidth, height: CGFloat.greatestFiniteMagnitude)
        let constraint = self.detailTextView.sizeThatFits(size)
        self.detailTextView.frame = CGRect(x: 0, y: self.detailHeaderImageView.frame.maxY, width: Constant.ScreenWidth, height: constraint.height)
        self.scrollView.contentSize = CGSize(width: Constant.ScreenWidth,height: self.detailTextView.frame.maxY)
        
        
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.hideOrShowHeaderView(isHidden: true)

    }
    
    func hideOrShowHeaderView(isHidden: Bool) {
        let replicantClass = NSClassFromString("_UIReplicantView") as! NSObject.Type
        
        for replicantView in self.view.subviews {
            if replicantView.isKind(of: replicantClass) {
                replicantView.isHidden = isHidden
                self.detailHeaderImageView.isHidden = !isHidden
            }
        }
    }
}

extension DetailViewController {
    func updateNavigationBarStyle() {
        self.navigationController?.navigationBar.alpha = 0;
    }
}

extension DetailViewController {
    func origin() {
        self.detailTextView.text = self.originText
        self.heightForTextView()
    }
}

extension DetailViewController: NavgationTransitionable {
    
    func pop() {
        self.navigationController?.tr_popViewController({
            
        })
    }
}
