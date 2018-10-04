
//
//  CameraScanViewController.swift
//  Cooking
//
//  Created by kacalek on 20/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class CameraScanViewController: UIViewController {
    var code: String?
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var modalView: UIView!
    
    @IBAction func CloseBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        modalView.layer.cornerRadius = 10.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let code = code {
            self.product = Repository.getProductByEan(ean: code)
            if self.product != nil {
                self.performSegue(withIdentifier: "scan_product", sender: nil)
            }else{
                codeLabel.text = "\(code) not found"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scan_product" {
            if let product = self.product {
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.data = product
            }
        }
    }
}
