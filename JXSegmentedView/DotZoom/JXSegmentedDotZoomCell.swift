//
//  JXSegmentedDotZoomCell.swift
//  JXSegmentedView
//
//  Created by QuintGao on 2022/4/24.
//

import UIKit

open class JXSegmentedDotZoomCell: JXSegmentedTitleCell {
    var dot = UIView()
    var hollow = UIView()

    open override func commonInit() {
        super.commonInit()

        dot.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dot)
        
        hollow.translatesAutoresizingMaskIntoConstraints = false
        hollow.backgroundColor = .white
        contentView.addSubview(hollow)
    }

    open override func reloadData(itemModel: JXSegmentedBaseItemModel, selectedType: JXSegmentedViewItemSelectedType) {
        super.reloadData(itemModel: itemModel, selectedType: selectedType )

        guard let myItemModel = itemModel as? JXSegmentedDotZoomItemModel else {
            return
        }

        dot.backgroundColor = myItemModel.dotColor
        dot.layer.cornerRadius = myItemModel.dotWH / 2
        hollow.layer.cornerRadius = myItemModel.hollowWH / 2
        NSLayoutConstraint.deactivate(dot.constraints)
        dot.widthAnchor.constraint(equalToConstant: myItemModel.dotWH).isActive = true
        dot.heightAnchor.constraint(equalToConstant: myItemModel.dotWH).isActive = true
        dot.centerXAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: myItemModel.dotOffset.x).isActive = true
        dot.centerYAnchor.constraint(equalTo: titleLabel.topAnchor, constant: myItemModel.dotOffset.y).isActive = true
        
        NSLayoutConstraint.deactivate(hollow.constraints)
        hollow.widthAnchor.constraint(equalToConstant: myItemModel.hollowWH).isActive = true
        hollow.heightAnchor.constraint(equalToConstant: myItemModel.hollowWH).isActive = true
        hollow.centerXAnchor.constraint(equalTo: dot.centerXAnchor).isActive = true
        hollow.centerYAnchor.constraint(equalTo: dot.centerYAnchor).isActive = true
        hollow.isHidden = myItemModel.dotStyle == .solid
        
        var transform = CGAffineTransform(scaleX: 0, y: 0)
        if myItemModel.isSelected || myItemModel.ratio != 0 {
            transform = CGAffineTransform(scaleX: 1 - myItemModel.ratio, y: 1 - myItemModel.ratio)
        }
        dot.transform = transform
        hollow.transform = transform
    }
}
