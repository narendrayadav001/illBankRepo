//
//  ViewController.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 24/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startDemo(_ sender: Any) {
        
            let listViewVC = ListRouter.createModule()
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(listViewVC, animated: true)
    }
    
}

