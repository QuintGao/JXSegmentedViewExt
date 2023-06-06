//
//  JXSegmentedDotZoomItemModel.swift
//  JXSegmentedView
//
//  Created by QuintGao on 2022/4/24.
//

import UIKit

public enum JXSegmentedDotStyle {
    case solid
    case hollow
}

open class JXSegmentedDotZoomItemModel: JXSegmentedTitleItemModel {
    open var dotStyle = JXSegmentedDotStyle.solid
    open var dotWH: CGFloat = 0
    open var hollowWH: CGFloat = 0
    open var dotColor = UIColor.red
    open var dotOffset: CGPoint = CGPoint.zero
    open var ratio: CGFloat = 0
}
