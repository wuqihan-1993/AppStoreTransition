//
//  ViewController.swift
//  AppStoreTransition
//
//  Created by wuqh on 2019/9/5.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    
    var statusBarHidden = false {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    private var dataList = [StoreItemModel]()
    private lazy var animatedTransition = AppStoreAnimatedTransition()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = (UIScreen.main.bounds.width - 40)*1.38
        tableView.separatorStyle = .none
        tableView.register(StoreCell.self, forCellReuseIdentifier: StoreCell.description())

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }

}

extension StoreViewController {
    private func setupData() {
        for i in 0...9 {
            let storeItem = StoreItemModel(title: "talk is cheap,\nshow me thecode", subTitle: "Hello World!", imageName: "image\(i)", content: "史蒂夫·乔布斯 [1]  （Steve Jobs，1955年2月24日—2011年10月5日 [2]  ），出生于美国加利福尼亚州旧金山，美国发明家、企业家、美国苹果公司联合创办人。 [3]\n\n1976年4月1日，乔布斯签署了一份合同，决定成立一家电脑公司。 [1]  1977年4月，乔布斯在美国第一次计算机展览会展示了苹果Ⅱ号样机。1997年苹果推出iMac，创新的外壳颜色透明设计使得产品大卖，并让苹果度过财政危机。 [4]  2011年8月24日，史蒂夫·乔布斯向苹果董事会提交辞职申请。 [5]\n\n乔布斯被认为是计算机业界与娱乐业界的标志性人物，他经历了苹果公司几十年的起落与兴衰，先后领导和推出了麦金塔计算机（Macintosh）、iMac、iPod、iPhone、iPad等风靡全球的电子产品，深刻地改变了现代通讯、娱乐、生活方式。乔布斯同时也是前Pixar动画公司的董事长及行政总裁。 [6]\n\n2011年10月5日，史蒂夫·乔布斯因患胰腺神经内分泌肿瘤 [7]  病逝，享年56岁。 [2] ")
            dataList.append(storeItem)
        }
        tableView.reloadData()
    }
    private func setupUI() {
        view.addSubview(tableView)
    }
}

extension StoreViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreCell.description(), for: indexPath)
        if let customCell = cell as? StoreCell {
            customCell.item = dataList[indexPath.section]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(#function)
        guard let cell = tableView.cellForRow(at: indexPath) as? StoreCell else {
            return
        }
        
        DispatchQueue.main.async {

            UIView.animate(withDuration: 0.1, animations: {
                cell.bgImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { (_) in
                let vc = StoreDetailViewController(storeItem: self.dataList[indexPath.section])

                vc.transitioningDelegate = self

                self.animatedTransition.itemCell = cell
                self.present(vc, animated: true, completion: {
                    cell.bgImageView.alpha = 1
                    cell.bgImageView.transform = CGAffineTransform.identity
                })
            })


        }
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        print(#function)
        let cell = tableView.cellForRow(at: indexPath) as! StoreCell
        UIView.animate(withDuration: 0.2) {
            cell.bgImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        return true
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
//        print(#function)
        let cell = tableView.cellForRow(at: indexPath) as! StoreCell
        UIView.animate(withDuration: 0.2) {
            cell.bgImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
}

extension StoreViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.transitionType = .show
        return animatedTransition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.transitionType = .dismiss
        return animatedTransition
    }
}

//extension StoreViewController {
//    @objc private func  edgePanGestureAction(_ edgePanGesture: UIScreenEdgePanGestureRecognizer) {
//        var progress = edgePanGesture.translation(in: view).x / view.bounds.width
//        print(progress)
//        switch edgePanGesture.state {
//        case .began:
//            animatedTransition.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
//            dismiss(animated: true, completion: nil)
//            break
//        case .changed:
//            break
//        case .cancelled,.ended:
//            break
//        default:
//            break
//        }
//    }
//}
//
