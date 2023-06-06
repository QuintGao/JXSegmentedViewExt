//
//  JXSegmentedBadgeDataSource.swift
//  JXSegmentedViewExt
//
//  Created by QuintGao on 2022/4/25.
//

import UIKit

public typealias UpdateBadgeStyle = ((Int, UILabel) -> Void)

open class JXSegmentedBadgeDataSource: JXSegmentedTitleDataSource {
    // badge类型数组，默认[JXSegmentedBadgeType.number]
    open var badgeTypes = [JXSegmentedBadgeType]()
    
    // 需要与titles的count对应，需根据对应的类型传入
    // number类型传入Int，text类型传入String，dot传入Bool
    // 对于JXSegmentedBadgeType.dot，true代表显示，false代表隐藏
    open var badges = [Any]()
    
    // 内部默认不会格式化数字，直接转成字符串显示。比如业务需要数字超过99显示99+，可以通过该闭包实现
    open var badgeStringFormatterClosure: ((JXSegmentedBadgeType, Any) -> String)?
    
    // 自定义单个badgeLabel的样式
    open var updateBadgeStyleClosure: UpdateBadgeStyle?
    
    // badgeLabe的font，默认11
    open var badgeLabelFont = UIFont.systemFont(ofSize: 11)
    
    // 数字的背景色
    open var badgeBackgroundColor = UIColor.red
    
    // 数字的title颜色
    open var badgeTitleColor = UIColor.white
    
    // badgeLabel的宽度补偿，label真实的宽度是文字内容的宽度+补偿的宽度，默认：10
    open var badgeLabelWidthIncrement: CGFloat = 10
    
    // badgeLabel的高度，默认14
    open var badgeLabelHeight: CGFloat = 14
    
    // badgeLabel x，y方向的偏移
    open var badgeLabelOffset = CGPoint.zero
    
    // 当是单一数字时，是否让numberLabel变成圆。即numberLabel的宽度等于高度，cornerRadius等于高度/2。当为true，单一数字时会忽略numberLabelWidthIncrement属性。默认为NO；
    open var shouldMakeRoundWhenSingleNumber: Bool = false
    
    // 以下属性对于JXSegmentedBadgeType.dot有效
    // 红点的尺寸
    open var dotBadgeSize = CGSize(width: 10, height: 10)
    
    // 红点的圆角值，默认dotBadgeSize.height/2
    open var dotBadgeCornerRadius: CGFloat = JXSegmentedViewAutomaticDimension
    
    // 红点x，y方向的偏移
    open var dotBadgeOffset = CGPoint.zero
    
    open override func preferredItemModelInstance() -> JXSegmentedBaseItemModel {
        return JXSegmentedBadgeItemModel()
    }

    open override func preferredRefreshItemModel(_ itemModel: JXSegmentedBaseItemModel, at index: Int, selectedIndex: Int) {
        super.preferredRefreshItemModel(itemModel, at: index, selectedIndex: selectedIndex)

        guard let itemModel = itemModel as? JXSegmentedBadgeItemModel else {
            return
        }

        itemModel.badgeType = badgeTypes[index]
        itemModel.badge = badges[index]
        if badgeStringFormatterClosure != nil {
            itemModel.badgeString = badgeStringFormatterClosure!(itemModel.badgeType, itemModel.badge)
        }else {
            itemModel.badgeString = "\(String(describing: itemModel.badge))"
        }
        itemModel.updateBadgeStyle = updateBadgeStyleClosure
        itemModel.badgeBackgroundColor = badgeBackgroundColor
        itemModel.badgeTitleColor = badgeTitleColor
        itemModel.badgeLabelFont = badgeLabelFont
        itemModel.badgeLabelHeight = badgeLabelHeight
        itemModel.badgeLabelOffset = badgeLabelOffset
        itemModel.badgeLabelWidthIncrement = badgeLabelWidthIncrement
        itemModel.shouldMakeRoundWhenSingleNumber = shouldMakeRoundWhenSingleNumber
        itemModel.dotBadgeSize = dotBadgeSize
        itemModel.dotBadgeOffset = dotBadgeOffset
        if dotBadgeCornerRadius == JXSegmentedViewAutomaticDimension {
            itemModel.dotBadgeCornerRadius = dotBadgeSize.height / 2
        }else {
            itemModel.dotBadgeCornerRadius = dotBadgeCornerRadius
        }
    }

    //MARK: - JXSegmentedViewDataSource
    open override func registerCellClass(in segmentedView: JXSegmentedView) {
        segmentedView.collectionView.register(JXSegmentedBadgeCell.self, forCellWithReuseIdentifier: "cell")
    }

    open override func segmentedView(_ segmentedView: JXSegmentedView, cellForItemAt index: Int) -> JXSegmentedBaseCell {
        let cell = segmentedView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        return cell
    }
}
