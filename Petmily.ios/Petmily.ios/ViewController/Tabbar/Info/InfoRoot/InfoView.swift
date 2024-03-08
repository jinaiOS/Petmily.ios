//
//  InfoView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import UIKit

final class InfoView: UIView {
    private let attributes: [NSAttributedString.Key: Any] = [
        .font: ThemeFont.r14,
        .foregroundColor: ThemeColor.systemGray
    ]
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.register(SpacerCell.self,
                                forCellWithReuseIdentifier: SpacerCell.identifier)
        collectionView.register(InfoPopularCell.self,
                                forCellWithReuseIdentifier: InfoPopularCell.identifier)
        collectionView.register(InfoShareCell.self,
                                forCellWithReuseIdentifier: InfoShareCell.identifier)
        collectionView.register(InfoPopularHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: InfoPopularHeader.identifier)
        collectionView.register(InfoShareHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: InfoShareHeader.identifier)
        collectionView.setCollectionViewLayout(collectionViewLayout(), animated: true)
        
        let refresh = UIRefreshControl()
        let attributedTitle = NSAttributedString(string: "당겨서 새로고침", attributes: attributes)
        refresh.attributedTitle = attributedTitle
        collectionView.refreshControl = refresh
        
        return collectionView
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.search, for: .normal)
        button.tintColor = ThemeColor.black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InfoView {
    /**
     @brief Section에 따른 Layout 설정
     */
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNum, _ in
            switch InfoSection(rawValue: sectionNum) {
            case .spacer:
                return SpacerCell.spacerSection()
                
            case .popular:
                return InfoPopularCell.popularSection()
                
            case .share:
                return InfoShareCell.shareSection()
                
            case .none:
                return nil
            }
        }
    }
    
    func setLayout() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
