//
//  ViewController.swift
//  Example
//
//  Created by QuintGao on 2022/4/8.
//

import UIKit
import JXSegmentedViewExt

class ViewController: UIViewController {

//    var dataSource = JXSegmentedTitleDataSource()
    var dataSource = JXSegmentedSubTitleImageDataSource()
    
    
    lazy var segmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.dataSource = dataSource
        segmentedView.delegate = self
        
        segmentedView.listContainer = self.containerView
        
        return segmentedView
    }()
    
    lazy var containerView: JXSegmentedListContainerView = {
        let containerView = JXSegmentedListContainerView(dataSource: self, type: .collectionView)
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.titles = ["热点", "种草", "本地", "放映厅", "直播"];
        dataSource.subTitles = ["热度咨询", "潮流好物", "同城关注", "宅家必看", "大V在线"]
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 15)
        dataSource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 15)
        dataSource.titleNormalColor = .black
        dataSource.titleSelectedColor = UIColor(red: 243/255.0, green: 136/255.0, blue: 68/255.0, alpha: 1.0)
        dataSource.titleLabelVerticalOffset = -10
        dataSource.subTitleNormalFont = UIFont.systemFont(ofSize: 11.0)
        dataSource.subTitleSelectedFont = UIFont.systemFont(ofSize: 11.0)
        dataSource.subTitleNormalColor = .gray
        dataSource.subTitleSelectedColor = .white
        dataSource.subTitleWithTitlePositionMargin = 3
        dataSource.itemSpacing = 1
//        dataSource.itemWidthIncrement = 16
        dataSource.imageSize = CGSize(width: 12, height: 12)
        dataSource.imageTypes = [.none, .left, .none, .left, .left]
        dataSource.normalImageInfos = ["", "zhongcao", "", "fangying", "gif"]
        dataSource.selectedImageInfos = ["", "zhongcao", "", "fangying", "gif"]
        dataSource.isSubTitleInCenterX = false
        dataSource.loadImageClosure = {(imageView, normalImageInfo) in
            let name = normalImageInfo
            if name != "" {
                if name == "gif" {
                    var images = [UIImage]()
                    for i in 0..<4  {
                        let imageName = "cm2_list_icn_loading\(i+1)"
//                        let img = self.changeImage(UIImage(named: imageName)!, color: .red)
                        images.append(UIImage(named: imageName)!)
                    }
                    
                    for i in (0..<4).reversed() {
                        let imageName = "cm2_list_icn_loading\(i+1)"
//                        let img = self.changeImage(UIImage(named: imageName)!, color: .red)
                        images.append(UIImage(named: imageName)!)
                    }
                    imageView.animationImages = images
                    imageView.animationDuration = 0.75
                    imageView.startAnimating()
                }else {
                    imageView.image = UIImage(named: name)
                }
            }
        }
        dataSource.isIgnoreImageWidth = true
        view.addSubview(segmentedView)
        view.addSubview(containerView)
        segmentedView.frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: 80)
        containerView.frame = CGRect(x: 0, y: 160, width: self.view.frame.size.width, height: self.view.frame.size.height - 160)
        
        segmentedView.reloadData()
    }
    
    func changeImage(_ image: UIImage, color: UIColor) -> UIImage {
        let drawRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setBlendMode(.normal)
        context?.clip(to: drawRect, mask: image.cgImage!)
        color.setFill()
        context?.fill(drawRect)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage ?? UIImage()
    }
}

extension ViewController: JXSegmentedViewDelegate {
    
}

extension ViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return dataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let listVC = ListViewController()
        return listVC
    }
}

