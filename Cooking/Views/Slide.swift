//
//  Slide.swift
//  Cooking
//
//  Created by kacalek on 12/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class Slide: UIView {

    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.borderWidth = 1
            imageView.layer.masksToBounds = false
            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.layer.cornerRadius = imageView.frame.width / 2
            imageView.clipsToBounds = true
            
//            let maskLayer = CAGradientLayer()
//            maskLayer.frame = imageView.bounds
//            maskLayer.shadowRadius = 5
//            maskLayer.shadowPath = CGPath(roundedRect: imageView.bounds.insetBy(dx: 5, dy: 5), cornerWidth: 10, cornerHeight: 10, transform: nil)
//            maskLayer.shadowOpacity = 1
//            maskLayer.shadowOffset = CGSize.zero
//            maskLayer.shadowColor = UIColor.white.cgColor
//            imageView.layer.mask = maskLayer
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var data: MenuProtocol! {
        didSet{
            self.titleLabel.text = data.name
            self.descriptionLabel.text = data.subname
            self.imageView.image = StorageHelper.loadImage(name: data.name, url: data.imgUrl)
        }
    }
}
