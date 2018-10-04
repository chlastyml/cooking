//
//  Menu.swift
//  Cooking
//
//  Created by kacalek on 13/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class Menu: MenuProtocol {
    var id: String
    
    var parentId: String?
    
    var imgUrl: String
    
    var name: String
    
    var subname: String
    
    var subMenu: [MenuProtocol]{
        get {
            return Repository.getMenus(parentId: self.id)
        }
    }
    
    init(imgUrl: String, name: String, subname: String? = nil, parentId: String? = nil) {
        self.imgUrl = imgUrl
        self.name = name
        self.subname = subname ?? name
        self.parentId = parentId
        self.id = Helper.randomString()
    }
    
    
}
