//
//  JXSegmentedBadgeCell.swift
//  JXSegmentedViewExt
//
//  Created by QuintGao on 2022/4/25.
//

import UIKit

open class JXSegmentedBadgeCell: JXSegmentedTitleCell {
    var badgeCenterX = NSLayoutConstraint()
    var badgeCenterY = NSLayoutConstraint()
    var badgeWidth = NSLayoutConstraint()
    var badgeHeight = NSLayoutConstraint()
    
    public let badgeLabel = UILabel()

    open override func commonInit() {
        super.commonInit()
    
        badgeLabel.textAlignment = .center
        badgeLabel.layer.masksToBounds = true
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(badgeLabel)
        badgeCenterX = badgeLabel.centerXAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        badgeCenterY = badgeLabel.centerYAnchor.constraint(equalTo: titleLabel.topAnchor)
        badgeWidth = badgeLabel.widthAnchor.constraint(equalToConstant: 0)
        badgeHeight = badgeLabel.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([badgeCenterX, badgeCenterY, badgeWidth, badgeHeight])
    }

    open override func reloadData(itemModel: JXSegmentedBaseItemModel, selectedType: JXSegmentedViewItemSelectedType) {
        super.reloadData(itemModel: itemModel, selectedType: selectedType )

        guard let myItemModel = itemModel as? JXSegmentedBadgeItemModel else {
            return
        }

        badgeLabel.backgroundColor = myItemModel.badgeBackgroundColor
        badgeLabel.textColor = myItemModel.badgeTitleColor
        badgeLabel.font = myItemModel.badgeLabelFont
        badgeLabel.text = myItemModel.badgeString
        if myItemModel.updateBadgeStyle != nil {
            myItemModel.updateBadgeStyle!(myItemModel.index, badgeLabel)
        }

        if myItemModel.badgeType == .dot {
            badgeLabel.isHidden = !(myItemModel.badge as! Bool)
            badgeLabel.text = nil
            badgeLabel.layer.cornerRadius = myItemModel.dotBadgeCornerRadius
            badgeWidth.constant = myItemModel.dotBadgeSize.width
            badgeHeight.constant = myItemModel.dotBadgeSize.height
            badgeCenterX.constant = myItemModel.dotBadgeOffset.x
            badgeCenterY.constant = myItemModel.dotBadgeOffset.y
        }else {
            badgeLabel.layer.cornerRadius = myItemModel.badgeLabelHeight/2
            badgeHeight.constant = myItemModel.badgeLabelHeight
            badgeCenterX.constant = myItemModel.badgeLabelOffset.x
            badgeCenterY.constant = myItemModel.badgeLabelOffset.y
            if myItemModel.badgeType == .number {
                let badge = myItemModel.badge as! Int
                self.badgeLabel.isHidden = badge == 0
                if badge < 10 && myItemModel.shouldMakeRoundWhenSingleNumber {
                    badgeWidth.constant = myItemModel.badgeLabelHeight
                }else {
                    let width = myItemModel.badgeString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: myItemModel.badgeLabelHeight), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: myItemModel.badgeLabelFont], context: nil).size.width
                    badgeWidth.constant = width + myItemModel.badgeLabelWidthIncrement
                }
            }else {
                if myItemModel.badge is String {
                    badgeLabel.isHidden = (myItemModel.badge as! String).count <= 0
                }else {
                    badgeLabel.isHidden = (myItemModel.badge as! Int) == 0
                }
                let width = myItemModel.badgeString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: myItemModel.badgeLabelHeight), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: myItemModel.badgeLabelFont], context: nil).size.width
                badgeWidth.constant = width + myItemModel.badgeLabelWidthIncrement
            }
        }
    }
}
