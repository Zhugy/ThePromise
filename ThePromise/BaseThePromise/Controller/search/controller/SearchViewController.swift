//
//  SearchViewController.swift
//  ThePromise
//
//  Created by zhugy on 2017/8/31.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit
import Cartography

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0)
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView.init()
        return tableView
    }()
    
    var searchModels: [SearchModel] = [] {
        didSet {
            searchModels.forEach { (_) in
                selectors.append(false)
            }
        }
    }
    var selectors:[Bool] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
       view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommonCell.self, forCellReuseIdentifier: NSStringFromClass(CommonCell.classForCoder()))
        setupConstraints()
    }
    
    private func loadModel() {
        searchModels = SearchService.loadSearchHome()
        tableView.reloadData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadModel()

        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        constrain(tableView) { (tableView) in
            tableView.edges == tableView.superview!.edges
        }
    }
    
    //MARK: - UITableViewDelegate && UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectors[section] {
            return searchModels[section].subTitleArr.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommonCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CommonCell.classForCoder()), for: indexPath) as! CommonCell
        cell.titleLabel.text = searchModels[indexPath.section].subTitleArr[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        headView.backgroundColor = UIColor.ps_paleGrey
        let headBtn: UIButton = UIButton(type: .custom)
        headBtn.backgroundColor = UIColor.white
        headBtn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 49)
        headBtn.tag = 121212 + section
        headView.addSubview(headBtn)
        headBtn.addTarget(self, action: #selector(SearchViewController.reloadSelectorSection(sende:)), for: .touchUpInside)
    
        let titlelabel: UILabel = UILabel(frame: CGRect(x: 24, y: 0, width: UIScreen.main.bounds.size.width-24, height: 49))
        titlelabel.text = searchModels[section].title
        headView.addSubview(titlelabel)
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let function = FunctionViewController(style: .plain)
        navigationController?.pushViewController(function, animated: true)
    }
    
    //MARK: - clictaction
    
    @objc private func reloadSelectorSection(sende: UIButton) {
        let selectorSection = sende.tag - 121212
        selectors[selectorSection] = !selectors[selectorSection]
        
        tableView.reloadSections(IndexSet.init(integer: selectorSection), with: .fade)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
