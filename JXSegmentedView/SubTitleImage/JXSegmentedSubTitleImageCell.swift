//
//  JXSegmentedSubTitleImageCell.swift
//  JXSegmentedViewExt
//
//  Created by QuintGao on 2022/4/11.
//

import UIKit

open class JXSegmentedSubTitleImageCell: JXSegmentedSubTitleCell {
    public let imageView = UIImageView()
    private var currentImageInfo: String?
    private var imageViewWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var imageViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    open override func prepareForReuse() {
        super.prepareForReuse()

        currentImageInfo = nil
    }
    
    open override func commonInit() {
        super.commonInit()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 0)
        imageViewWidthConstraint.isActive = true
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 0)
        imageViewHeightConstraint.isActive = true
        contentView.addSubview(imageView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let myCellModel = itemModel as? JXSegmentedSubTitleImageItemModel else { return }
        let imageSize = myCellModel.imageSize
        imageViewWidthConstraint.constant = imageSize.width
        imageViewHeightConstraint.constant = imageSize.height
        
        if myCellModel.isSubTitleInCenterX && (myCellModel.positionStyle == .top || myCellModel.positionStyle == .bottom) {
            NSLayoutConstraint.deactivate([subTitleLabelCenterX])
            subTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        }
        
        imageView.isHidden = false
        titleLabelCenterX.constant = 0
        
        switch myCellModel.imageType {
        case .left:
            imageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: -myCellModel.titleImageSpacing).isActive = true
            titleLabelCenterX.constant = 2 * myCellModel.titleImageSpacing
            break
        case .right:
            imageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: myCellModel.titleImageSpacing).isActive = true
            titleLabelCenterX.constant = -2 * myCellModel.titleImageSpacing
            break
        default:
            imageView.isHidden = true
        }
    }
    
    open override func reloadData(itemModel: JXSegmentedBaseItemModel, selectedType: JXSegmentedViewItemSelectedType) {
        super.reloadData(itemModel: itemModel, selectedType: selectedType)
        
        guard let myCellModel = itemModel as? JXSegmentedSubTitleImageItemModel else { return }
        
        var normalImageInfo = myCellModel.imageInfo
        if myCellModel.isSelected && myCellModel.selectedImageInfo != nil {
            normalImageInfo = myCellModel.selectedImageInfo
        }
        //??????`func reloadData(itemModel: JXSegmentedBaseItemModel, selectedType: JXSegmentedViewItemSelectedType)`???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        
        if normalImageInfo != nil && normalImageInfo != currentImageInfo {
            currentImageInfo = normalImageInfo
            if myCellModel.loadImageClosure != nil {
                myCellModel.loadImageClosure!(imageView, normalImageInfo!)
            }else {
                imageView.image = UIImage(named: normalImageInfo!)
            }
        }
        
        if myCellModel.isImageZoomEnabled {
            imageView.transform = CGAffineTransform(scaleX: myCellModel.imageCurrentZoomScale, y: myCellModel.imageCurrentZoomScale)
        }else {
            imageView.transform = .identity
        }
    }
}
