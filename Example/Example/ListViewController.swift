//
//  ListViewController.swift
//  Example
//
//  Created by QuintGao on 2022/4/11.
//

import UIKit
import JXSegmentedViewExt

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: CGFloat(arc4random()%255) / 255.0, green: CGFloat(arc4random()%255) / 255.0, blue: CGFloat(arc4random()%255) / 255.0, alpha: 1.0)
    }
}

extension ListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }
}
