//
//  Detail.swift
//  Cooking
//
//  Created by kacalek on 14/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class Product {
    var id: String
    var parentId: String
    var name: String
    var subname: String
    var description: String
    var imgUrl: String
    var ean: String
    
    init(menu: MenuProtocol, ean: String, subname: String, description: String) {
        self.id = Helper.randomString()
        
        self.name = menu.name
        self.subname = subname
        self.imgUrl = menu.imgUrl
        self.parentId = menu.id
        
        self.ean = ean
        self.description = description
    }
}
