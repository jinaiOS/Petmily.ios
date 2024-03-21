//
//  HashTagCell.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class HashTagCell: UICollectionViewCell {
    static let identifier = "HashTagCell"
    
    private let hashtagLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.r16
        label.textColor = ThemeColor.lightPink
        label.textAlignment = .left
        return label
    }()
    
    private let deleteIamgeView: UIImageView = {
        let imageView = UIImageView(image: PetmilyImage.customXmark)
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(imageView.snp.height)
        }
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HashTagCell {
    func setViewModel(hashtagStr: String) {
        hashtagLabel.text = "#" + hashtagStr
    }
    
    static func hashTagSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(Constants.Size.size100),
                                              heightDimension: .fractionalHeight(Constants.Size.size1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(Constants.Size.size100),
                                               heightDimension: .estimated(Constants.Size.size30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = Constants.Spacing.spacing8
        return section
    }
}

private extension HashTagCell {
    func configure() {
        contentView.layer.borderColor = ThemeColor.lightPink.cgColor
        contentView.borderWidth = Constants.Size.size2
        contentView.cornerRadius = Constants.Size.size14
    }
    
    func setLayout() {
        [hashtagLabel, deleteIamgeView].forEach {
            contentView.addSubview($0)
        }
        
        hashtagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.Size.size10)
            $0.top.bottom.equalToSuperview()
        }
        
        deleteIamgeView.snp.makeConstraints {
            $0.leading.equalTo(hashtagLabel.snp.trailing).offset(Constants.Size.size8)
            $0.trailing.equalToSuperview().inset(Constants.Size.size8)
            $0.top.bottom.equalToSuperview().inset(Constants.Size.size10)
        }
    }
}
