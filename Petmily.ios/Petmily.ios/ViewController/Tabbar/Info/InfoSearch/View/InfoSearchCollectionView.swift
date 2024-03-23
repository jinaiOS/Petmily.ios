//
//  InfoSearchCollectionView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoSearchCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InfoSearchCollectionView {
    func configCollectionView() {
        register(InfoSearchCategoryCell.self,
                 forCellWithReuseIdentifier: InfoSearchCategoryCell.identifier)
        register(InfoSearchTopicCell.self,
                 forCellWithReuseIdentifier: InfoSearchTopicCell.identifier)
        register(InfoSearchCategoryHeader.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: InfoSearchCategoryHeader.identifier)
        register(InfoSearchTopicHeader.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: InfoSearchTopicHeader.identifier)
        setCollectionViewLayout(collectionViewLayout(), animated: true)
        isScrollEnabled = false
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionNum, _ in
            guard let self else { return nil }
            switch InfoSearchSection(rawValue: sectionNum) {
            case .category:
                return InfoSearchCategoryCell.categorySection()
                
            case .topic:
                return InfoSearchTopicCell.topicSection()
                
            case .none:
                return nil
            }
        }
    }
}
