//
//  DetailViewController.swift
//  Cooking
//
//  Created by kacalek on 14/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var SubtitleLabel: UILabel!
    @IBOutlet weak var DescriptionTextView: UITextView!
    
    @IBAction func backBtnClick(_ sender: Any) {
        if self.navigationController != nil {
            //            self.navigationController?.popToRootViewController(animated: true)
            self.navigationController?.popViewController(animated: true)
        } else {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "main_navigation") as! UINavigationController
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    
    var data: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = data {
            titleLabel.text = data.name
            SubtitleLabel.text = data.subname
            DescriptionTextView.text = data.description
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
