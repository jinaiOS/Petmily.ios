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
        label.font = ThemeFont.infoSearchCategory
        label.textColor = ThemeColor.categoryPink
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 24, bottom: 24, trailing: 24)
        section.interGroupSpacing = 8
        
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
        contentView.layer.borderColor = ThemeColor.categoryPink.cgColor
        contentView.borderWidth = 2
        contentView.cornerRadius = 14
    }
    
    func setLayout() {
        contentView.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
