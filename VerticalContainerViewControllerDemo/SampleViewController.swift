//
//  SampleViewController.swift
//  VerticalContainerViewController
//
//  Created by Muronaka Hiroaki on 2017/05/21.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit
import VerticalContainerViewController

class SampleViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var verticalContainerViewController: VerticalContainerViewController!
    var bounceDirection: BounceDirection = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.delegate = self
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

extension SampleViewController: ScrollViewPageable, UITextViewDelegate {

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.prepareChangingPage(scrollView: textView)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.changePageIfNeeds(scrollView: textView)
    }

}
