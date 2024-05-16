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
    case image  // 图片
}

open class JXSegmentedBadgeItemModel: JXSegmentedTitleItemModel {
    open var badgeType = JXSegmentedBadgeType.number
    open var badgeInfo: Any = 0
    open var updateBadgeClosure: UpdateBadgeClosure?
    open var badgeString: String = ""
    open var badgeBackgroundColor: UIColor = .red
    open var badgeTitleColor: UIColor = .white
    open var badgeWidthIncrement: CGFloat = 0
    open var badgeHeight: CGFloat = 0
    open var badgeLabelFont: UIFont = .systemFont(ofSize: 12)
    open var badgeOffset: CGPoint = .zero
    open var badgeSize: CGSize = .zero
    open var shouldMakeRoundWhenSingleNumber: Bool = false
    
    // 以下只对JXSegmentedBadgeStyle为dot有效
    open var dotBadgeSize: CGSize = .zero
    open var dotBadgeCornerRadius: CGFloat = 0
    open var dotBadgeOffset: CGPoint = .zero
}
