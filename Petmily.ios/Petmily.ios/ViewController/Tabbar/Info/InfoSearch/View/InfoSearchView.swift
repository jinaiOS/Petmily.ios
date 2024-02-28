//
//  InfoSearchView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoSearchView: UIView {
    let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let introLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.b24
        label.textAlignment = .left
        label.textColor = ThemeColor.black
        label.text = "무엇을 찾으시나요?"
        return label
    }()
    
    let searchContentView = InfoSearchContentView()
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
    // TODO: - cell 크기 확정 후 수정하기
//    func remakeConstraints(cellCount: Int) {
//        collectionView.snp.remakeConstraints {
//            let categorySize: CGFloat = 90
//            let headerSize: CGFloat = 49
//            let cellSize: CGFloat = 99
//            let spacing: CGFloat = 14
//            $0.top.equalTo(searchContentView.snp.bottom).offset(Constants.Size.size30)
//            $0.leading.trailing.bottom.equalToSuperview()
//            $0.height.equalTo(categorySize + headerSize + cellSize * CGFloat(cellCount) + spacing * CGFloat(cellCount - 1))
//        }
//    }
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
            $0.top.trailing.equalToSuperview().offset(Constants.Size.size30)
            $0.leading.equalToSuperview().inset(Constants.Size.size24)
        }
        
        searchContentView.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(Constants.Size.size50)
            $0.leading.trailing.equalToSuperview().inset(Constants.Size.size24)
            $0.height.equalTo(Constants.Size.size41)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchContentView.snp.bottom).offset(Constants.Size.size30)
            $0.leading.trailing.bottom.equalToSuperview()
            let screenHeight = UIScreen.main.bounds.height
            $0.height.equalTo(screenHeight)
        }
    }
}
