//
//  SearchModel.swift
//  ThePromise
//
//  Created by zhugy on 2017/9/12.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit

class SearchModel: NSObject {
    var title: String = ""
    var subTitleArr: [SearchSubModel] = []
    
    
    init(dictionary: [String : Any]!) {
        super.init()
        self.title = dictionary["title"] as! String
        let titleArr = dictionary["content"] as! [Any]
        
        for dict in titleArr {
            let subDict = dict as! [String : Any]
            let subModel = SearchSubModel(dictionary: subDict)
            subTitleArr.append(subModel)
        }
    }
}

class SearchSubModel: NSObject {
    var title: String = ""
    
    init(dictionary: [String : Any]!) {
        super.init()
        self.title = dictionary["title"] as! String
    }
}
