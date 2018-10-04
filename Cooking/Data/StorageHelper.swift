//
//  StorageHelper.swift
//  Cooking
//
//  Created by kacalek on 13/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class StorageHelper {
    private static var storages: [String: UIImage] = [:]
    
    private static func saveImage(image: UIImage?, name: String) {
        if image == nil { return }
        storages[name] = image
//        do {
//            let userDocumentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let imagePath = userDocumentsPath.appendingPathComponent(strToHash(str: name))
//            if let imageData = UIImagePNGRepresentation(image!) {
//                try imageData.write(to: imagePath, options: .atomic)
//            }
//        } catch { }
    }
    
    static func loadImage(name: String, url: String) -> UIImage? {
//        let userDocumentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let imagePath = userDocumentsPath.appendingPathComponent(strToHash(str: name)).path
        
//        if FileManager.default.fileExists(atPath: imagePath) {
        if let img = storages[name] {
//            print("Img \(name) nalezena v pameti")
            return img
        } else {
//            print("Img \(name) nenalezena. Pokusim se ji stahnout!")
            let img = self.getImage(imageUrl: url)
            if img != nil {
                self.saveImage(image: img, name: name)
//                print("Img \(name) stazena a ulozena")
                return img
            }else{
//                print("Img se nepodarilo stahnout")
            }
        }
        
        return nil
    }
    
//    private static var pFixHash: String?
    private static func strToHash(str: String) -> String{
//        if(pFixHash == nil){
//            pFixHash = Helper.randomString()
//        }
//        return "\(pFixHash!)\(str)"
        return str
    }
    
    private static func getImage(imageUrl: String) -> UIImage? {
        guard let url = URL(string: imageUrl) else { return nil }
        
        let imageData = try? Data(contentsOf: url)
        
        if let imageData = imageData {
            let newWeatherConditionsImage = UIImage(data: imageData)
            return newWeatherConditionsImage
        }
        
        return nil
    }
}
