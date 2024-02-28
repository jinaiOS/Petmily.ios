//
//  InfoShareHeader.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import UIKit

final class InfoShareHeader: UICollectionReusableView {
    static let identifier = "InfoShareHeader"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.b22
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

extension InfoShareHeader {
    /**
     @brief shareHeaderSection
     */
    static func shareHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                                heightDimension: .estimated(Constants.Size.size30))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
    
    func setViewModel(title: String) {
        titleLabel.text = title
    }
}

private extension InfoShareHeader {
    func setLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
    }
}
