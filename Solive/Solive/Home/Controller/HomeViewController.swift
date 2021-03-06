//
//  HomeViewController.swift
//  Solive
//
//  Created by Mazy on 2017/8/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        setupContentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}


// MARK: -
extension HomeViewController {
    
    func setupNavigationBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        searchBar.isTranslucent = true
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ranking-p")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightItemAction))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_btn_follow"), style: .plain, target: self, action: #selector(rightItemAction))
    }
    
    @objc private func rightItemAction() {
        print("rightItemAction")
    }
    
    func setupContentView() {
        
        let homeTypes = loadTypeData()
        
        let titles: [String] = homeTypes.flatMap({ $0.title })
        
        var childVCs: [AnchorViewController] = [AnchorViewController]()
        for type in homeTypes {
            let vc = AnchorViewController()
            vc.homeType = type
            childVCs.append(vc)
        }
        
        let pageView = PageScrollView(frame: CGRect(x: 0, y: 64+10, width: kScreenW, height: kScreenH-64), titles: titles, childVC: childVCs, parentVC: self)
        view.addSubview(pageView)
    }
    
    fileprivate func loadTypeData() -> [HomeTypeModel] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil) ?? ""
        let dataArray = NSArray(contentsOfFile: path) as! [[String: Any]]
        var tempArray = [HomeTypeModel]()
        for dict in dataArray {
            let m = HomeTypeModel(with: dict)
            tempArray.append(m)
        }
        return tempArray
    }
}
