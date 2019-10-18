//
//  CustomPageViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/10/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CustomPageViewController: UIPageViewController {

    private var pages = [UIViewController]()
    private let pageControlView = PageControlView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialPage = 0
        let firstPage = WelcomeViewController()
        let secondPage = SecondViewController()
        
        pages.append(firstPage)
        pages.append(secondPage)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }

}

extension CustomPageViewController: ViewCode {
    
    func buildViewHierarchy() {
        //
    }
    
    func setupConstraints() {
        //
    }
    
    func setupAdditionalConfigurantion() {
        self.dataSource = self
        self.delegate = self
    }

}

extension CustomPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
               if viewControllerIndex == 0 {
                   
                   return self.pages.last
               } else {
                   
                   return self.pages[viewControllerIndex - 1]
               }
           }
           return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                
                return self.pages[viewControllerIndex + 1]
            } else {
                
                return self.pages.first
            }
        }
        return nil
    }
    
}

extension CustomPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let viewControllers = self.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                pageControlView.updatePageControl(currentPageIndex: viewControllerIndex)
            }
        }
    }
}
