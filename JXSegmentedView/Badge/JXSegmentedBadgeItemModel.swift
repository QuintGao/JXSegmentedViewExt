//
//  JXSegmentedBadgeItemModel.swift
//  JXSegmentedViewExt
//
//  Created by QuintGao on 2022/4/25.
//

import UIKit

public enum JXSegmentedBadgeType {
    case number // 数字
    case text   // 文字
    case dot    // 圆点
}

open class JXSegmentedBadgeItemModel: JXSegmentedTitleItemModel {
    open var badgeType = JXSegmentedBadgeType.number
    open var badge: Any = 0
    open var updateBadgeStyle: UpdateBadgeStyle?
    open var badgeString: String = ""
    open var badgeBackgroundColor: UIColor = .red
    open var badgeTitleColor: UIColor = .white
    open var badgeLabelWidthIncrement: CGFloat = 0
    open var badgeLabelHeight: CGFloat = 0
    open var badgeLabelFont: UIFont = .systemFont(ofSize: 12)
    open var badgeLabelOffset: CGPoint = .zero
    open var shouldMakeRoundWhenSingleNumber: Bool = false
    
    // 以下只对JXSegmentedBadgeStyle为dot有效
    open var dotBadgeSize: CGSize = .zero
    open var dotBadgeCornerRadius: CGFloat = 0
    open var dotBadgeOffset: CGPoint = .zero
}
