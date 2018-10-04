//
//  ViewController.swift
//  Cooking
//
//  Created by kacalek on 10/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    var menuData: [MenuProtocol]? {
        didSet{
            slides = createSlidesByData(data: menuData!)
        }
    }
    var slides: [Slide]?
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var settedPageNumber = 0
    
    var _loadOnce = false
    var loadOnce: Bool{
        get{
            if self._loadOnce {
                return true
            } else {
                self._loadOnce = true
                DispatchQueue(label: "com.myApp.queue").async {
                    sleep(1)
                    self._loadOnce = false
                }
                return false
            }
        }
        set{
            self._loadOnce = newValue
        }
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        downAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if menuData == nil {
            menuData = Repository.getMenus(parentId: nil)
        }
        
        setupSlideScrollView(slides: slides!)
        pageControl.numberOfPages = slides!.count
        pageControl.currentPage = 0
        scrollView.contentOffset.x = CGFloat(settedPageNumber) * scrollView.frame.width
        view.bringSubview(toFront: pageControl)
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func createSlidesByData(data: [MenuProtocol]) -> [Slide] {
        if (data.isEmpty) {
            return []
        }
        return data.map({ (data) -> Slide in
            let slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.data = data
            return slide
        })
    }
    
    func upAction() -> Void {
        if let slides = slides, let data = slides[pageControl.currentPage].data {
            if(self.loadOnce){
                return
            }
            
            if(data.parentId == nil){
                performSegue(withIdentifier: "show_scanner", sender: nil)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func downAction() -> Void {
        if let slides = slides, let data = slides[pageControl.currentPage].data {
            if(self.loadOnce){
                return
            }
            
            if (data.subMenu.count > 0) {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "main_menu") as! ViewController
                nextVC.menuData = data.subMenu
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "detail_view") as! DetailViewController
                nextVC.data = Repository.getDetail(id: data.id)
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Zamknuti na pozici
        let newHorizontalOffset = scrollView.contentOffset.x - (CGFloat(pageControl.currentPage) * scrollView.frame.width)
        if(abs(scrollView.contentOffset.y) < abs(newHorizontalOffset)){
            scrollView.contentOffset.y = 0
        }else{
            scrollView.contentOffset.x = CGFloat(pageControl.currentPage) * scrollView.frame.width
        }
        
        // Swipe up
        if(scrollView.contentOffset.y < -100){
            return self.upAction()
        }
        
        // Swipe down
        if(scrollView.contentOffset.y > 100) {
            return self.downAction()
        }
        
        // animate
        animateScroll()
    }
    
    func animateScroll() -> Void {
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        //        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        //        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        //        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        //        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: 0)
        
        let ratio = scrollView.contentOffset.x/view.frame.width
        //        print(ratio)
        pageControl.currentPage = Int(round(ratio))
        
        let x: Float = Float(percentageHorizontalOffset)
        let maxIndex = (slides?.count)! - 1
        
        var li = Int(floor(ratio))
        var ti = li + 1
        
        // Osetreni konce
        if(x == 1.0) {
            ti = maxIndex
            li = maxIndex - 1
        }
        
        if(li >= 0 && ti <= maxIndex) {
            let c  = 1.0 / Float(maxIndex)
            let cx = Float(ti) * c
            
            let lSize = (cx - x)/c
            let tSize = x/cx
            
            slides![li].imageView.transform = CGAffineTransform(scaleX: CGFloat(lSize), y: CGFloat(lSize))
            slides![ti].imageView.transform = CGAffineTransform(scaleX: CGFloat(tSize), y: CGFloat(tSize))
        }
    }
}
