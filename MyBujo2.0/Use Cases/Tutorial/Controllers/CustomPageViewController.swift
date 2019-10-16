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
                   // wrap to last page in array
                   return self.pages.last
               } else {
                   // go to previous page in array
                   return self.pages[viewControllerIndex - 1]
               }
           }
           return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
    }
    
}

extension CustomPageViewController: UIPageViewControllerDelegate {
    
}
