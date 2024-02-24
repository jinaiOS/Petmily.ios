//
//  InfoDetailView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoDetailView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let infoDetailShareView: InfoDetailContentView
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.register(InfoDetailCommentCell.self,
                                forCellWithReuseIdentifier: InfoDetailCommentCell.identifier)
        collectionView.register(InfoDetailCommentHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: InfoDetailCommentHeader.identifier)
        collectionView.isScrollEnabled = false
        collectionView.setCollectionViewLayout(collectionViewLayout(), animated: true)
        return collectionView
    }()
    
    init(info: ShareInfo) {
        infoDetailShareView = InfoDetailContentView(info: info)
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InfoDetailView {
    /**
     @brief Section에 따른 Layout 설정
     */
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNum, _ in
            switch sectionNum {
            case 0:
                return InfoDetailCommentCell.commentSection()
                
            default: return nil
            }
        }
    }
}

extension InfoDetailView {
    func remakeConstraints(cellCount: Int) {
        let cellSize: CGFloat = 121
        let headerSize: CGFloat = 45
        collectionView.snp.remakeConstraints {
            $0.top.equalTo(infoDetailShareView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(headerSize + cellSize * CGFloat(cellCount))
        }
    }
}

private extension InfoDetailView {
    func setLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [infoDetailShareView, collectionView].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(AppConstraint.headerViewHeight)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        infoDetailShareView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(infoDetailShareView.snp.height)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(infoDetailShareView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(collectionView.contentSize.height)
        }
    }
}
