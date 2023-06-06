//
//  JXSegmentedDotZoomDataSource.swift
//  JXSegmentedView
//
//  Created by QuintGao on 2022/4/24.
//

import UIKit

open class JXSegmentedDotZoomDataSource: JXSegmentedTitleDataSource {
    /// 圆点类型，默认实心
    open var dotStyle = JXSegmentedDotStyle.solid
    
    /// 红点的宽高
    open var dotWH: CGFloat = 10
    
    /// 红点的颜色
    open var dotColor = UIColor.red
    
    /// dotView的默认位置是center在titleLabel的右上角，可以通过dotOffset控制X、Y轴的偏移
    open var dotOffset: CGPoint = CGPoint.zero
    
    /// 空心的宽高，默认：5，注意只在dotStyle为hollow时有效
    open var hollowWH: CGFloat = 5

    open override func preferredItemModelInstance() -> JXSegmentedBaseItemModel {
        return JXSegmentedDotZoomItemModel()
    }

    open override func preferredRefreshItemModel(_ itemModel: JXSegmentedBaseItemModel, at index: Int, selectedIndex: Int) {
        super.preferredRefreshItemModel(itemModel, at: index, selectedIndex: selectedIndex)

        guard let itemModel = itemModel as? JXSegmentedDotZoomItemModel else {
            return
        }

        itemModel.dotStyle = dotStyle
        itemModel.dotWH = dotWH
        itemModel.dotColor = dotColor
        itemModel.dotOffset = dotOffset
        itemModel.hollowWH = hollowWH
    }

    //MARK: - JXSegmentedViewDataSource
    open override func registerCellClass(in segmentedView: JXSegmentedView) {
        segmentedView.collectionView.register(JXSegmentedDotZoomCell.self, forCellWithReuseIdentifier: "cell")
    }

    open override func segmentedView(_ segmentedView: JXSegmentedView, cellForItemAt index: Int) -> JXSegmentedBaseCell {
        let cell = segmentedView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        return cell
    }
    
    open override func refreshItemModel(_ segmentedView: JXSegmentedView, leftItemModel: JXSegmentedBaseItemModel, rightItemModel: JXSegmentedBaseItemModel, percent: CGFloat) {
        super.refreshItemModel(segmentedView, leftItemModel: leftItemModel, rightItemModel: rightItemModel, percent: percent)
        
        guard let myLeftItemModel = leftItemModel as? JXSegmentedDotZoomItemModel, let myRightItemModel = rightItemModel as? JXSegmentedDotZoomItemModel else { return }
        myLeftItemModel.ratio = percent
        myRightItemModel.ratio = 1 - percent
    }
}
