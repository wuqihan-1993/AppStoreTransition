//
//  MoreViewController.swift
//  AppStoreTransition
//
//  Created by wuqh on 2019/9/6.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    private lazy var testView: UIView = {
        let testView = UIView(frame: CGRect(x: 38.7, y: 609.926, width: 336.6, height: 464.4))
        testView.backgroundColor = UIColor.red
        return testView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(testView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIView.AnimationOptions.curveLinear, animations: {
            
            self.testView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 1.45)
            //((0 0; 414 600.3)
            
        }) { (isComplete) in

            
        }
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
