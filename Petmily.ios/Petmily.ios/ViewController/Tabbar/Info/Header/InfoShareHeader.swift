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
    private var didTapEditbutton: PassthroughSubject<Void, Never>?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .pencil), for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            didTapEditbutton?.send()
        }), for: .touchUpInside)
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

extension InfoShareHeader {
    /**
     @brief shareHeaderSection
     */
    static func shareHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(30))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
    
    func setViewModel(title: String, subject: PassthroughSubject<Void, Never>) {
        titleLabel.text = title
        didTapEditbutton = subject
    }
}

private extension InfoShareHeader {
    func setLayout() {
        [titleLabel, editButton].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }
}
