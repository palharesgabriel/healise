//
//  CustomPageViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/10/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CustomPageViewController: UIPageViewController {

	private var orderedViewControllers: [UIViewController]?
    private let pageControlView = PageControlView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialPage = 0
       
        setupView()
		setupPages()
		
		if let firstViewController = orderedViewControllers?.first {
			setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
		}
    }

	func setupPages() {
		let firstPage = WelcomeViewController()
		let secondPage = SecondViewController()
		orderedViewControllers?.append(firstPage)
		orderedViewControllers?.append(secondPage)
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
//       guard let viewControllerIndex =
		return UIViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
}

extension CustomPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		
    }
}
