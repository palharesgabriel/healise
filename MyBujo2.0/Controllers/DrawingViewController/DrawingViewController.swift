//
//  DrawingViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class DrawingViewController: MediaViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        contentView.backgroundColor = .green
        // Do any additional setup after loading the view.
    }
    
    override func exitButtonClicked(sender: ExitButton) {
        dismiss(animated: true, completion: {
            //
        })
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
