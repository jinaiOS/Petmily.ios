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
        let font: UIFont = ThemeFont.b20
        return makeLabel(font: font, textColor: ThemeColor.label)
    }()
    
    private lazy var contentLabel: UILabel = {
        let font: UIFont = ThemeFont.m18
        return makeLabel(font: font, textColor: ThemeColor.label)
    }()
    
    private lazy var contentVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing8
        
        [titleLabel, contentLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private let spacerView = UIView()
    
    private lazy var authorLabel: UILabel = {
        let font: UIFont = ThemeFont.r10
        return makeLabel(font: font, textColor: ThemeColor.systemGray)
    }()
    
    private lazy var hashtagLabel: UILabel = {
        let font: UIFont = ThemeFont.b10
        return makeLabel(font: font, textColor: ThemeColor.white)
    }()
    
    private lazy var tagView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.lightPink
        view.addSubview(hashtagLabel)
        view.layer.cornerRadius = Constants.Radius.radius7
        
        hashtagLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constants.Size.size8)
            $0.height.equalTo(Constants.Size.size22)
        }
        return view
    }()
    
    private lazy var infoVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing2
        
        [authorLabel, tagView].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var labelVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        
        [contentVStack, spacerView, infoVStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = Constants.Radius.radius13
        view.clipsToBounds = true
        
        view.snp.makeConstraints {
            $0.width.equalTo(view.snp.height)
        }
        return view
    }()
    
    private lazy var contentViewHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing40
        
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                              heightDimension: .fractionalHeight(Constants.Size.size1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                               heightDimension: .estimated(Constants.Size.size152))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: Constants.Size.size16,
                                      leading: Constants.Size.size16,
                                      bottom: Constants.Size.size16 + Constants.HeaderView.height,
                                      trailing: Constants.Size.size16)
        section.interGroupSpacing = Constants.Spacing.spacing16
        
        let sectionHeader = InfoShareHeader.shareHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setViewModel(info: ShareInfo) {
        titleLabel.text = info.title
        contentLabel.text = info.content
        authorLabel.text = info.author
        hashtagLabel.text = "#" + info.hashtag.joined(separator: " #")
        contentImageView.kf.setImage(with: info.contentImageUrl)
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
        layer.cornerRadius = Constants.Radius.radius16
        layer.borderWidth = Constants.Size.size1
        layer.borderColor = ThemeColor.lightGray.cgColor
        
        contentViewHStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.Size.size12)
        }
    }
}
