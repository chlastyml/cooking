//
//  MenuProtocol.swift
//  
//
//  Created by kacalek on 13/09/2018.
//

import UIKit

protocol MenuProtocol {
    var id: String { get }
    var parentId: String? { get }
    var imgUrl: String { get }
    var name: String { get }
    var subname: String { get }
    var subMenu: [MenuProtocol] { get }
}

//protocol HasSubMenu {
//    var subMenu: [MenuProtocol] { get }
//}
