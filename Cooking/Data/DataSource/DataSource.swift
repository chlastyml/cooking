//
//  DataSource.swift
//  Cooking
//
//  Created by kacalek on 12/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

protocol DataSource {
    func getMenus() -> [MenuProtocol]
    func getMenus(parentId: String?) -> [MenuProtocol]
    
    func getMenu(id: String) -> MenuProtocol?
    
    func getDetail(id: String) -> Product?
    
    func getProductByEan(ean: String) -> Product?
}
