//
//  InfoSearchView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoSearchView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let introLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "무엇을 찾으시나요?"
        return label
    }()
    
    private let searchContentView = InfoSearchContentView()
    let collectionView = InfoSearchCollectionView(frame: .zero, collectionViewLayout: .init())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoSearchView {
    func remakeConstraints(cellCount: Int) {
        collectionView.snp.remakeConstraints {
            let categorySize: CGFloat = 90
            let headerSize: CGFloat = 49
            let cellSize: CGFloat = 99
            let spacing: CGFloat = 14
            $0.top.equalTo(searchContentView.snp.bottom).offset(52)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(categorySize + headerSize + cellSize * CGFloat(cellCount) + spacing * CGFloat(cellCount - 1))
        }
    }
}

private extension InfoSearchView {
    func setLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [introLabel, searchContentView, collectionView].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        introLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(100)
        }
        
        searchContentView.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(80)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(41)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchContentView.snp.bottom).offset(52)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(collectionView.contentSize.height)
        }
    }
}
