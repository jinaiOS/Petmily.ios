//
//  InfoSearchTopicHeader.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoSearchTopicHeader: UICollectionReusableView {
    static let identifier = "InfoSearchTopicHeader"
    
    private lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.b16
        label.textColor = ThemeColor.deepPink
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.b16
        label.textColor = ThemeColor.black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var labelVStack = StackFactory.makeStackView(spacing: Constants.Spacing.spacing1,
                                                              subViews: [mainTitleLabel, subTitleLabel])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoSearchTopicHeader {
    /**
     @brief topicHeaderSection
     */
    static func topicHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                                heightDimension: .absolute(Constants.Size.size41))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
    
    func setViewModel(mainTitle: String, subTitle: String) {
        mainTitleLabel.text = mainTitle
        subTitleLabel.text = subTitle
    }
}

private extension InfoSearchTopicHeader {
    func setLayout() {
        addSubview(labelVStack)
        
        labelVStack.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
}
