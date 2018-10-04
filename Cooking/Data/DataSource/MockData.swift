//
//  MockData.swift
//  Cooking
//
//  Created by kacalek on 12/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class MockData: DataSource {
    var menus = Array<MenuProtocol>()
    var products = Array<Product>()
    
    func getProductByEan(ean: String) -> Product? {
        let selected = products.filter({ (product) -> Bool in
            return product.ean == ean
        })
        
//        sleep(2)
        
        if selected.count > 0 {
            return selected[0]
        } else {
            return nil
        }
    }
    
    func getMenus() -> [MenuProtocol] {
        return menus
    }
    
    func getMenus(parentId: String? = nil) -> [MenuProtocol] {
        return menus.filter({ (menu) -> Bool in
            return menu.parentId == parentId
        })
    }
    
    func getMenu(id: String) -> MenuProtocol? {
        let selectedMenus = menus.filter({ (menu) -> Bool in
            return menu.id == id
        })
        
        if selectedMenus.count > 0 {
            return selectedMenus[0]
        } else {
            return nil
        }
    }
    
    func getDetail(id: String) -> Product? {
        let selectedDetails = products.filter({ (detail) -> Bool in
            return detail.parentId == id
        })
        
        if selectedDetails.count > 0 {
            return selectedDetails[0]
        } else {
            return nil
        }
    }
    
    init() {
        let pasta = Menu(imgUrl: "https://media.istockphoto.com/photos/assorted-raw-pasta-picture-id663948708", name: "Pasta")
        let rice = Menu(imgUrl: "https://qph.fs.quoracdn.net/main-qimg-1032b9bb1167ef2a759bdd7c1af69629-c", name: "Rice")
        let legumes = Menu(imgUrl: "https://cdn1.medicalnewstoday.com/content/images/articles/316/316686/various-types-of-legumes.jpg", name: "Legumes")
        
        menus = [pasta, rice, legumes]
        
        let penne = Menu(imgUrl: "https://previews.123rf.com/images/mantonino/mantonino1008/mantonino100800035/7507670-macro-closeup-of-penne-pasta-background-texture.jpg", name: "Penne", parentId: pasta.id)
        let linguine = Menu(imgUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Linguine.jpg/1200px-Linguine.jpg", name: "Linguine", parentId: pasta.id)
        let classica = Menu(imgUrl: "https://www.budgetbytes.com/wp-content/uploads/2016/07/Pasta-with-Butter-Tomato-Sauce-and-Toasted-Bread-Crumbs-utensils.jpg", name: "Classica", parentId: pasta.id)
        
        menus.append(penne)
        menus.append(linguine)
        menus.append(classica)
        
        let penneDetail = Product(menu: penne, ean: "4058172050831", subname: "Pasta", description: "In Italy, penne are produced in two main variants: 'penne lisce' (smooth) and 'penne rigate' (furrowed), the latter having ridges on each penna. Pennoni ('big quills') is a wider version of penne. A slightly larger version called mostaccioli (meaning 'little mustache' in some Italian dialects) can also be found, which can also be either smooth or ridged in texture.")

        let linguineDetail = Product(menu: linguine, ean: "8594008043891", subname: "Pasta", description: "Linguine originated in Genoa and the Liguria region of Italy. Linguine alle vongole (linguine with clams) and trenette al pesto are popular uses of this pasta.")

        let classicaDetail = Product(menu: classica, ean: "8594008043892", subname: "Pasta", description: "Pasta is a staple food of traditional Italian cuisine, with the first reference dating to 1154 in Sicily. Also commonly used to refer to the variety dishes made with it, pasta is typically made from an unleavened dough of a durum wheat flour mixed with water or eggs, and formed into sheets or various shapes, then cooked by boiling or baking. Some pastas can be made using rice flour in place of wheat flour to yield a different taste and texture, or for those who need to avoid products containing gluten.")

        products.append(penneDetail)
        products.append(linguineDetail)
        products.append(classicaDetail)
        
        
        menus.append(Menu(imgUrl: "https://5.imimg.com/data5/HO/BP/MY-46934534/raw-basmati-rice-500x500.jpg", name: "Basmati", parentId: rice.id))
        menus.append(Menu(imgUrl: "https://static-5862.kxcdn.com/695-thickbox/arborio-rice-1kg.jpg", name: "Arborio", parentId: rice.id))
        menus.append(Menu(imgUrl: "https://assets.marthastewart.com/styles/wmax-1500/d19/la101448_jan06_rice/la101448_jan06_rice_sq.jpg?itok=I568a26w", name: "Jasmine", parentId: rice.id))
        menus.append(Menu(imgUrl: "https://cdn.shopify.com/s/files/1/1698/9451/products/Wild_Rice_Pilaf_Bowl_1024x1024.png?v=1535759244", name: "Wild", parentId: rice.id))
        menus.append(Menu(imgUrl: "https://woodlandfoods.com/img/WF_Images/X35-rice-bhutanese-red-rice-main.jpg", name: "Bhutanese red", parentId: rice.id))
        menus.append(Menu(imgUrl: "https://woodlandfoods.com/img/WF_Images/X16-rice-italian-style-arborio-rice-main.jpg", name: "Carnaroli", parentId: rice.id))
        
        
        menus.append(Menu(imgUrl: "https://s3.amazonaws.com/finecooking.s3.tauntonclud.com/app/uploads/2017/04/24170648/ING-brown-lentil-2-thumb1x1.jpg", name: "Lentil", parentId: legumes.id))
        menus.append(Menu(imgUrl: "https://www.culinaryhill.com/wp-content/uploads/2017/10/Chipotle-Pinto-Beans-Copycat-Culinary-Hill-3-660x660.jpg", name: "Beans", parentId: legumes.id))
        menus.append(Menu(imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_dci7VakPhsr-hKgTr7AYEkaqfnwSB1jodV7dC85xN8BHIN6GLw", name: "Chickpeas", parentId: legumes.id))
        menus.append(Menu(imgUrl: "https://www.kitchenkneads.com/wp-content/uploads/2016/06/Soybeans-1000x1000.png", name: "Soybeans", parentId: legumes.id))
//        menus.append(Menu(imgUrl: "image", name: "name", parentId: legumes.id))
        
    }
}











