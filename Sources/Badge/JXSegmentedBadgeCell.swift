//
//  JXSegmentedBadgeCell.swift
//  JXSegmentedViewExt
//
//  Created by QuintGao on 2022/4/25.
//

import UIKit

open class JXSegmentedBadgeView: UIView {
    public private(set) var badgeLabeL: UILabel?
    public private(set) var badgeImageView: UIImageView?
    
    public var itemModel: JXSegmentedBadgeItemModel? {
        didSet {
            guard let itemModel = itemModel else { return }
            if itemModel.badgeType == .image {
                if badgeImageView == nil {
                    badgeImageView = UIImageView(frame: bounds)
                    addSubview(badgeImageView!)
                }
            }else {
                if badgeLabeL == nil {
                    badgeLabeL = UILabel(frame: bounds)
                    badgeLabeL?.textAlignment = .center
                    addSubview(badgeLabeL!)
                }
                badgeLabeL?.backgroundColor = itemModel.badgeBackgroundColor
                badgeLabeL?.font = itemModel.badgeLabelFont
                badgeLabeL?.textColor = itemModel.badgeTitleColor
                badgeLabeL?.text = itemModel.badgeString
                
                if itemModel.badgeType == .dot {
                    badgeLabeL?.text = nil
                }
            }
            itemModel.updateBadgeClosure?(itemModel.index, self, itemModel.badgeInfo)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        badgeLabeL?.frame = bounds
        badgeImageView?.frame = bounds
    }
    
    public func clear() {
        badgeLabeL?.text = nil
        badgeImageView?.image = nil
    }
}

open class JXSegmentedBadgeCell: JXSegmentedTitleCell {
    var badgeCenterX = NSLayoutConstraint()
    var badgeCenterY = NSLayoutConstraint()
    var badgeWidth = NSLayoutConstraint()
    var badgeHeight = NSLayoutConstraint()
    
    public let badgeView = JXSegmentedBadgeView()
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        badgeView.clear()
    }

    open override func commonInit() {
        super.commonInit()
    
        badgeView.layer.masksToBounds = true
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(badgeView)
        badgeCenterX = badgeView.centerXAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        badgeCenterY = badgeView.centerYAnchor.constraint(equalTo: titleLabel.topAnchor)
        badgeWidth = badgeView.widthAnchor.constraint(equalToConstant: 0)
        badgeHeight = badgeView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([badgeCenterX, badgeCenterY, badgeWidth, badgeHeight])
    }

    open override func reloadData(itemModel: JXSegmentedBaseItemModel, selectedType: JXSegmentedViewItemSelectedType) {
        super.reloadData(itemModel: itemModel, selectedType: selectedType )

        guard let myItemModel = itemModel as? JXSegmentedBadgeItemModel else {
            return
        }
        
        badgeView.itemModel = myItemModel

        if myItemModel.badgeType == .image {
            badgeWidth.constant = myItemModel.badgeSize.width
            badgeHeight.constant = myItemModel.badgeSize.height
            badgeCenterX.constant = myItemModel.badgeOffset.x
            badgeCenterY.constant = myItemModel.badgeOffset.y
        }else if myItemModel.badgeType == .dot {
            badgeView.isHidden = !(myItemModel.badgeInfo as? Bool ?? false)
            badgeView.layer.cornerRadius = myItemModel.dotBadgeCornerRadius
            badgeWidth.constant = myItemModel.dotBadgeSize.width
            badgeHeight.constant = myItemModel.dotBadgeSize.height
            badgeCenterX.constant = myItemModel.dotBadgeOffset.x
            badgeCenterY.constant = myItemModel.dotBadgeOffset.y
        }else {
            badgeView.layer.cornerRadius = myItemModel.badgeHeight/2
            badgeHeight.constant = myItemModel.badgeHeight
            badgeCenterX.constant = myItemModel.badgeOffset.x
            badgeCenterY.constant = myItemModel.badgeOffset.y
            if myItemModel.badgeType == .number {
                let badge = myItemModel.badgeInfo as? Int ?? 0
                self.badgeView.isHidden = badge == 0
                if badge < 10 && myItemModel.shouldMakeRoundWhenSingleNumber {
                    badgeWidth.constant = myItemModel.badgeHeight
                }else {
                    let width = myItemModel.badgeString.boundingRect(with: CGSize(width: CGFloat.infinity, height: myItemModel.badgeHeight), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: myItemModel.badgeLabelFont], context: nil).size.width
                    badgeWidth.constant = width + myItemModel.badgeWidthIncrement
                }
            }else {
                if myItemModel.badgeInfo is String {
                    badgeView.isHidden = (myItemModel.badgeInfo as? String ?? "").count <= 0
                }else {
                    badgeView.isHidden = (myItemModel.badgeInfo as? Int ?? 0) == 0
                }
                let width = myItemModel.badgeString.boundingRect(with: CGSize(width: CGFloat.infinity, height: myItemModel.badgeHeight), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: myItemModel.badgeLabelFont], context: nil).size.width
                badgeWidth.constant = width + myItemModel.badgeWidthIncrement
            }
        }
    }
}
