//
//  ViewController.swift
//  Example
//
//  Created by QuintGao on 2022/4/8.
//

import UIKit
import JXSegmentedViewExt
import Kingfisher

class ViewController: UIViewController {

    lazy var subTitleImageDataSource: JXSegmentedSubTitleImageDataSource = {
        let dataSource = JXSegmentedSubTitleImageDataSource()
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
        dataSource.itemSpacing = 0
        dataSource.itemWidthIncrement = 16
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
        return dataSource
    }()
    
    lazy var dotZoomDataSource: JXSegmentedDotZoomDataSource = {
       let dataSource = JXSegmentedDotZoomDataSource()
        dataSource.titles = ["关注", "推荐", "电影", "直播", "小说"]
        dataSource.isTitleZoomEnabled = true
        dataSource.titleSelectedZoomScale = 1.5
        dataSource.dotStyle = .hollow
        dataSource.dotWH = 8
        dataSource.hollowWH = 5
        return dataSource
    }()
    
    lazy var badgeDataSource: JXSegmentedBadgeDataSource = {
        let dataSource = JXSegmentedBadgeDataSource()
        dataSource.titles = ["图片", "数字", "文字", "圆点", "文字0"];
        dataSource.isTitleZoomEnabled = true
        dataSource.badgeTypes = [.image,.number, .text, .dot, .number, .text]
        dataSource.badgeInfos = ["https://editor-img.888ban.com/ips_templ_preview/80/68/44/lg_69654_1617800030_606dab5eeb73f.jpg!w280_png?auth_key=2278944000-0-0-7b73c2caa86d6646fd1d541749c554c1", 100, "直播", true, 1, "0"]
        dataSource.dotBadgeOffset = CGPointMake(10, 0)
        dataSource.badgeOffset = CGPointMake(5, 0)
        dataSource.badgeSize = CGSizeMake(20, 20)
        dataSource.badgeStringFormatterClosure = { (type, badge) in
            if type == .number && badge is Int {
                if (badge as! Int) > 99 {
                    return "99+"
                }
            }
            return "\(badge)"
        }
        dataSource.updateBadgeClosure = { (index, badgeView, badgeInfo) in
            if index == 0 {
                badgeView.badgeImageView?.kf.setImage(with: URL(string: badgeInfo as! String))
            }else if index == 1 {
                badgeView.badgeLabeL?.backgroundColor = .black
                badgeView.badgeLabeL?.textColor = .brown
            }else if index == 2 {
                badgeView.badgeLabeL?.backgroundColor = .blue
            }
        }
        return dataSource
    }()
    
    lazy var subTitleSegmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.dataSource = subTitleImageDataSource
        segmentedView.delegate = self
        
        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorHeight = 16
        lineView.verticalOffset = 10
        lineView.indicatorWidthIncrement = 10
        lineView.indicatorColor = UIColor(red: 243.0/255.0, green: 136.0/255.0, blue: 68.0/255.0, alpha: 1.0)
        lineView.lineStyle = .lengthen
        segmentedView.indicators = [lineView]
        
        segmentedView.listContainer = self.containerView
        
        segmentedView.isSelectItemOnScrollHalf = true
        
        return segmentedView
    }()
    
    lazy var dotTitleSegmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.dataSource = dotZoomDataSource
        segmentedView.delegate = self
        segmentedView.listContainer = self.containerView
        return segmentedView
    }()
    
    lazy var badgeSegmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.dataSource = badgeDataSource
        segmentedView.delegate = self
        segmentedView.listContainer = self.containerView
        return segmentedView
    }()
    
    lazy var configTitleDataSource: JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titles = ["关注", "推荐", "电影", "直播", "小说"]
        dataSource.configuration = self
        return dataSource
    }()
    
    lazy var configSegmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.dataSource = configTitleDataSource
        segmentedView.delegate = self
        segmentedView.listContainer = self.containerView
        return segmentedView
    }()
    
    lazy var indicator: JXSegmentedIndicatorAlignmentLineView = {
        let lineView = JXSegmentedIndicatorAlignmentLineView()
        lineView.alignmentStyle = .center
        lineView.indicatorWidth = 20
        return lineView
    }()
    
    lazy var containerView: JXSegmentedListContainerView = {
        let containerView = JXSegmentedListContainerView(dataSource: self, type: .collectionView)
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "JXSegmentedView测试"
        
        view.addSubview(subTitleSegmentedView)
        view.addSubview(dotTitleSegmentedView)
        view.addSubview(badgeSegmentedView)
        view.addSubview(configSegmentedView)
        view.addSubview(containerView)
        subTitleSegmentedView.frame = CGRect(x: 0, y: 80, width: view.frame.width, height: 54)
        dotTitleSegmentedView.frame = CGRect(x: 0, y: CGRectGetMaxY(subTitleSegmentedView.frame), width: view.frame.width, height: 44)
        badgeSegmentedView.frame = CGRect(x: 0, y: CGRectGetMaxY(dotTitleSegmentedView.frame), width: view.frame.width, height: 44)
        configSegmentedView.frame = CGRect(x: 0, y: CGRectGetMaxY(badgeSegmentedView.frame), width: view.frame.width, height: 44)
        containerView.frame = CGRect(x: 0, y: CGRectGetMaxY(configSegmentedView.frame), width: self.view.frame.size.width, height: self.view.frame.size.height - CGRectGetMaxY(configSegmentedView.frame))
        
        subTitleSegmentedView.reloadData()
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
    
//    @objc func changeStyle() {
//        dotZoomDataSource.titleNormalColor = .red
//        dotZoomDataSource.titleSelectedColor = .blue
////        segmentedView.gk_refreshCellState()
//        indicator.indicatorColor = .blue
//        segmentedView.gk_refreshCellAndIndicatorState()
//    }
}

extension ViewController: JXSegmentedViewDelegate {
    
}

extension ViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return dotZoomDataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let listVC = ListViewController()
        return listVC
    }
}

extension ViewController: JXSegmentedTitleDynamicConfiguration {
    func titleNumberOfLines(at index: Int) -> Int {
        return 1
    }
    
    func titleNormalFont(at index: Int) -> UIFont {
        if index == 0 {
            return .systemFont(ofSize: 20)
        }else {
            return .systemFont(ofSize: 15)
        }
    }
    
    func titleSelectedFont(at index: Int) -> UIFont? {
        if index == 0 {
            return .systemFont(ofSize: 20)
        }else {
            return .systemFont(ofSize: 15)
        }
    }
    
    func titleNormalColor(at index: Int) -> UIColor {
        if index == 0 {
            return .cyan
        }else {
            return .black
        }
    }
    
    func titleSelectedColor(at index: Int) -> UIColor {
        if index == 0 {
            return .brown
        }else {
            return .red
        }
    }
}
