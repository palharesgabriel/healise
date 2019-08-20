//
//  CustomSplitViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 20/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CustomSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let masterViewController = MasterViewController()
        let detailViewController = ViewController()
        
        let masterNavigationController = UINavigationController(rootViewController: masterViewController)
        masterNavigationController.navigationBar.isHidden = true
        
        let detailNavigationController = UINavigationController(rootViewController: detailViewController)
        detailNavigationController.navigationBar.isHidden = true
     
        self.viewControllers = [masterNavigationController,detailNavigationController]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
