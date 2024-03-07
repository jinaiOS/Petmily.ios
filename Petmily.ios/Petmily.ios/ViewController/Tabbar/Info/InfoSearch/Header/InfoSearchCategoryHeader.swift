//
//  InfoSearchCategoryHeader.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoSearchCategoryHeader: UICollectionReusableView {
    static let identifier = "InfoSearchCategoryHeader"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.b16
        label.textColor = ThemeColor.black
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoSearchCategoryHeader {
    /**
     @brief categoryHeaderSection
     */
    static func categoryHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                                heightDimension: .absolute(Constants.Size.size20))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
    
    func setViewModel(title: String) {
        titleLabel.text = title
    }
}

private extension InfoSearchCategoryHeader {
    func setLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
}
