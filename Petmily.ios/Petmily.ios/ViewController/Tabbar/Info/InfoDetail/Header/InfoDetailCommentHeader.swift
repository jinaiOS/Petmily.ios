//
//  InfoDetailCommentHeader.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoDetailCommentHeader: UICollectionReusableView {
    static let identifier = "InfoDetailCommentHeader"
    
    private lazy var topSeparateView: UIView = {
        return makeSeparateView(height: Constants.Size.size6)
    }()
    
    private lazy var commentCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.darkGray
        label.textAlignment = .right
        label.font = ThemeFont.m14
        return label
    }()
    
    private lazy var bottomSeparateView: UIView = {
        return makeSeparateView(height: Constants.Size.size2)
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        
        [topSeparateView, commentCountLabel, bottomSeparateView].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoDetailCommentHeader {
    /**
     @brief commentHeaderSection
     */
    static func commentHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                                heightDimension: .absolute(Constants.Size.size45))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
    
    func setViewModel(commentCount: Int) {
        commentCountLabel.text = "댓글 \(commentCount)개"
    }
}

private extension InfoDetailCommentHeader {
    func setLayout() {
        addSubview(vStack)
        
        vStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.Size.size13)
        }
    }
    
    func makeSeparateView(height: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = ThemeColor.systemGray5
        
        view.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        return view
    }
}
