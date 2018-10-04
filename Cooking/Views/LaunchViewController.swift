//
//  LaunchViewController.swift
//  Cooking
//
//  Created by kacalek on 14/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchProgressBar: UIProgressView!
    
    @IBOutlet weak var loadOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchProgressBar.progress = 0
        loadOutput.text = ""
        
        DispatchQueue(label: "com.myApp.queue").async {
            let imgs = Repository.getMenus()
            let step = 1.0 / Float(imgs.count)
            for index in 0...imgs.count-1 {
                let img = imgs[index]
                var _ = StorageHelper.loadImage(name: img.name, url: img.imgUrl)
                let progress = Float(index + 1) * (step)
                
//                usleep(100000)
                
                DispatchQueue.main.async {
                    self.launchProgressBar.setProgress(progress, animated: true)
                    self.loadOutput.text = "\(img.name)\n\(self.loadOutput.text ?? "")"
                }
            }
            
            DispatchQueue.main.async {
//                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "main_navigation") as! UINavigationController
//                self.present(nextVC, animated: true, completion: nil)
                
                self.performSegue(withIdentifier: "main_menu", sender: nil)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
