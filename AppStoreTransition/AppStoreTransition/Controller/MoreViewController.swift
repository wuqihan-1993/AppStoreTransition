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
        view.addSubview(testView)
        
        testView.snp.remakeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.width * 1.34)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        testView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(38.7)
            make.top.equalToSuperview().offset(609.926)
            make.width.equalTo(336.6)
            make.height.equalTo(464.4)
        }
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIView.AnimationOptions.curveLinear, animations: {
            
            self.view.layoutIfNeeded()
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
