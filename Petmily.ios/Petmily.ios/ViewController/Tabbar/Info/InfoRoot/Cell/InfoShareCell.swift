//
//  InfoShareCell.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SnapKit
import UIKit

final class InfoShareCell: UICollectionViewCell {
    static let identifier = "InfoShareCell"
    
    private lazy var titleLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 20, weight: .bold)
        return makeLabel(font: font, textColor: .label)
    }()
    
    private lazy var contentLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 18, weight: .medium)
        return makeLabel(font: font, textColor: .label)
    }()
    
    private lazy var contentVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 8
        
        [titleLabel, contentLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var authorLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 10, weight: .regular)
        return makeLabel(font: font, textColor: .systemGray)
    }()
    
    private lazy var hashtagLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 10, weight: .bold)
        return makeLabel(font: font, textColor: .white)
    }()
    
    private lazy var tagView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FFB9B9")
        view.addSubview(hashtagLabel)
        view.layer.cornerRadius = 6
        
        hashtagLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        return view
    }()
    
    private lazy var infoVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 3
        
        [authorLabel, tagView].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var labelVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 29
        
        [contentVStack, infoVStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 13
        view.clipsToBounds = true
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(114)
        }
        return view
    }()
    
    private lazy var contentViewHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 41
        
        [labelVStack, contentImageView].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoShareCell {
    static func shareSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(152))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 10, trailing: 16)
        section.interGroupSpacing = 16
        
        let sectionHeader = InfoShareHeader.shareHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setViewModel(info: ShareInfo) {
        titleLabel.text = info.title
        contentLabel.text = info.content
        authorLabel.text = info.author
        hashtagLabel.text = info.hashtag
        let url = URL(string: info.contentImageUrl)
        contentImageView.kf.setImage(with: url)
    }
}

private extension InfoShareCell {
    func makeLabel(font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = textColor
        label.font = font
        return label
    }
    
    func setLayout() {
        contentView.addSubview(contentViewHStack)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        contentViewHStack.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(13)
        }
        
        contentVStack.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(infoVStack)
        }
        
        infoVStack.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(182)
        }
        
        labelVStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.trailing.equalTo(contentImageView.snp.leading).offset(-41)
        }
        
        contentImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(6)
        }
        
        authorLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        tagView.snp.makeConstraints {
            $0.height.equalTo(22)
        }
    }
}
