//
//  MoreViewController.swift
//  AppStoreTransition
//
//  Created by wuqh on 2019/9/6.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit
import SnapKit

class MoreViewController: UIViewController {
    
    private lazy var testView: UIView = {
        let testView = UIView(frame: CGRect(x: 38.7, y: 609.926, width: 336.6, height: 464.4))
        testView.backgroundColor = UIColor.red
        return testView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        

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
