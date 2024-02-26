//
//  InfoSearchCategoryCell.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoSearchCategoryCell: UICollectionViewCell {
    static let identifier = "InfoSearchCategoryCell"
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.b16
        label.textColor = ThemeColor.lightPink
        label.textAlignment = .center
        return label
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

extension InfoSearchCategoryCell {
    static func categorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(Constants.Size.size100),
                                              heightDimension: .fractionalHeight(Constants.Size.size1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                               heightDimension: .estimated(Constants.Size.size30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(Constants.Size.size2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0,
                                      leading: Constants.Size.size24,
                                      bottom: Constants.Size.size24,
                                      trailing: Constants.Size.size24)
        section.interGroupSpacing = Constants.Spacing.spacing8
        
        let sectionHeader = InfoSearchCategoryHeader.categoryHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setViewModel(category: String) {
        categoryLabel.text = "# \(category)"
    }
}

private extension InfoSearchCategoryCell {
    func configure() {
        contentView.layer.borderColor = ThemeColor.lightPink.cgColor
        contentView.borderWidth = Constants.Size.size2
        contentView.cornerRadius = Constants.Size.size14
    }
    
    func setLayout() {
        contentView.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constants.Size.size20)
        }
    }
}
