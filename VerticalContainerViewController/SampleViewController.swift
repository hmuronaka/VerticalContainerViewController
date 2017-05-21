//
//  SampleViewController.swift
//  VerticalContainerViewController
//
//  Created by Muronaka Hiroaki on 2017/05/21.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    
    enum BounceType {
        case none, upBounce, downBounce
        
        static func bounceType(scrollView: UIScrollView) -> BounceType {
            if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.height) {
                return .upBounce
            }
            if scrollView.contentOffset.y == 0 {
                return .downBounce
            }
            return .none
        }
        
        func isScrollingFromEdge(scrollView: UIScrollView) -> Bool {
            switch(self) {
            case .none:
                return false
            case .upBounce:
                return scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.height)
            case .downBounce:
                return scrollView.contentOffset.y == 0
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    var pageViewController: VerticalContainerViewController!
    var bounceType: BounceType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("scrollView.contentSize: \(scrollView.contentSize)")
        self.scrollView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SampleViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.bounceType = BounceType.bounceType(scrollView: scrollView)
        print("beginDragging: \(scrollView.contentOffset)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.bounceType == .upBounce && scrollView.contentOffset.y > (self.scrollView.contentSize.height - self.scrollView.frame.height + 5) {
            pageViewController.pageUp()
            self.bounceType = .none
        } else if self.bounceType == .downBounce && scrollView.contentOffset.y < -80 {
            print("pageDown: \(scrollView.contentOffset)")
            pageViewController.pageDown()
            self.bounceType = .none
        }
    }
}
