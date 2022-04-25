//
//  ViewController.swift
//  Example
//
//  Created by QuintGao on 2022/4/8.
//

import UIKit
import JXSegmentedViewExt

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
//        dataSource.isTitleZoomEnabled = true
//        dataSource.titleSelectedZoomScale = 1.5
        dataSource.dotStyle = .hollow
        return dataSource
    }()
    
    lazy var badgeDataSource: JXSegmentedBadgeDataSource = {
        let dataSource = JXSegmentedBadgeDataSource()
        dataSource.titles = ["关注", "推荐", "电影", "直播", "小说"];
        dataSource.isTitleZoomEnabled = true
        dataSource.badgeTypes = [.number, .text, .dot, .number, .text]
        dataSource.badges = [true, 333, true, 40, 0]
        dataSource.badgeStringFormatterClosure = { (type, badge) in
            if type == .number && badge is Int {
                if (badge as! Int) > 99 {
                    return "99+"
                }
            }
            return "\(badge)"
        }
        dataSource.updateBadgeStyleClosure = { (index, badgeLabel) in
            if index == 1 {
                badgeLabel.backgroundColor = .black;
                badgeLabel.textColor = UIColor.brown;
            }else if index == 2 {
                badgeLabel.backgroundColor = UIColor.blue;
            }
        }
        return dataSource
    }()
    
    
    lazy var segmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.dataSource = badgeDataSource
        segmentedView.delegate = self
        
        return segmentedView
    }()
    
    lazy var indicator: JXSegmentedIndicatorAlignmentLineView = {
        let lineView = JXSegmentedIndicatorAlignmentLineView()
        lineView.alignmentStyle = .trailing
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "切换", style: .plain, target: self, action: #selector(changeStyle))
        
        let background = JXSegmentedIndicatorBackgroundView()
        background.indicatorPosition = .top
        
        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorHeight = 16
        lineView.verticalOffset = 10
        lineView.indicatorWidthIncrement = 10
//        lineView.lineScrollOffsetX = dataSource.titleImageSpacing + dataSource.imageSize.width
        lineView.indicatorColor = UIColor(red: 243.0/255.0, green: 136.0/255.0, blue: 68.0/255.0, alpha: 1.0)
        lineView.lineStyle = .lengthen
//        segmentedView.indicators = [background, indicator]
//        let indicator = JXSegmentedIndicatorAlignmentLineView()
//        indicator.alignmentStyle = .trailing
//        indicator.indicatorWidth = 20
//        indicator.indicatorColors = [.red, .blue, .gray, .green, .brown]
//        indicator.image = UIImage(named: "fangying")
//        indicator.colors = [.blue, .red, .green]
        segmentedView.indicators = [indicator, lineView]
        
        segmentedView.listContainer = self.containerView
        
        segmentedView.isSelectItemOnScrollHalf = true
        
        view.addSubview(segmentedView)
        view.addSubview(containerView)
        segmentedView.frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: 54)
        containerView.frame = CGRect(x: 0, y: 134, width: self.view.frame.size.width, height: self.view.frame.size.height - 160)
        
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
    
    @objc func changeStyle() {
        dotZoomDataSource.titleNormalColor = .red
        dotZoomDataSource.titleSelectedColor = .blue
//        segmentedView.gk_refreshCellState()
        indicator.indicatorColor = .blue
        segmentedView.gk_refreshCellAndIndicatorState()
    }
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

