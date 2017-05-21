//
//  VerticalContainerPageable.swift
//  VerticalContainerViewController
//
//  Created by Muronaka Hiroaki on 2017/05/21.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//
import UIKit

public enum BounceDirection {
    case none, upBounce, downBounce
    
    public static func bounceDirection(scrollView: UIScrollView) -> BounceDirection {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.height) {
            return .upBounce
        }
        if scrollView.contentOffset.y == 0 {
            return .downBounce
        }
        return .none
    }
    
    public func isScrollingFromEdge(scrollView: UIScrollView) -> Bool {
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

public struct ScrollViewPageableOption {
    var upBounceMargin: CGFloat = 5
    var downBounceMargin: CGFloat = 80
    
}

public protocol ScrollViewPageable: class {
    var bounceDirection: BounceDirection { set get }
    var scrollViewPageableOption: ScrollViewPageableOption { get }
    var verticalContainerViewController: VerticalContainerViewController! { get }
    
    // UIScrollViewDelegateの下記メソッドは、@objcを付ける必要があるので利用しない。
    //func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    //func scrollViewDidScroll(_ scrollView: UIScrollView)
    
    func prepareChangingPage(scrollView: UIScrollView)
    func changePageIfNeeds(scrollView: UIScrollView)
    
}

public extension ScrollViewPageable {
    
    public var scrollViewPageableOption: ScrollViewPageableOption {
        return ScrollViewPageableOption()
    }
    
    public func prepareChangingPage(scrollView: UIScrollView) {
        self.bounceDirection = BounceDirection.bounceDirection(scrollView: scrollView)
    }
    
    public func changePageIfNeeds(scrollView: UIScrollView) {
        if self.bounceDirection == .upBounce && scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.height + 5) {
            verticalContainerViewController.pageUp()
            self.bounceDirection = .none
        } else if self.bounceDirection == .downBounce && scrollView.contentOffset.y < -80 {
            verticalContainerViewController.pageDown()
            self.bounceDirection = .none
        }
    }
}
