//
//  InfoSearchTopicCell.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SnapKit
import UIKit

final class InfoSearchTopicCell: UICollectionViewCell {
    static let identifier = "InfoSearchTopicCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        let size: CGFloat = 20
        view.cornerRadius = size / 2
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(size)
        }
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor(hexString: "525252")
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "525252")
        
        view.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(10)
        }
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor(hexString: "525252")
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var labelHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 4
        
        [profileImageView, authorLabel, separateView, dateLabel, UIView()].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var labelVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 11
        
        [titleLabel, labelHStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.cornerRadius = 5
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(75)
        }
        return view
    }()
    
    private lazy var contentHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 6
        
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

extension InfoSearchTopicCell {
    static func topicSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(99))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 24, bottom: 0, trailing: 24)
        section.interGroupSpacing = 14
        
        let sectionHeader = InfoSearchTopicHeader.topicHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setViewModel(title: String, profileUrl: String, author: String, date: String, contentImageUrl: String) {
        let profileUrl = URL(string: profileUrl)
        let contentUrl = URL(string: contentImageUrl)
        titleLabel.text = title
        profileImageView.kf.setImage(with: profileUrl)
        authorLabel.text = author
        dateLabel.text = date
        contentImageView.kf.setImage(with: contentUrl)
    }
}

private extension InfoSearchTopicCell {
    func setLayout() {
        layer.cornerRadius = 9
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(contentHStack)
        
        contentHStack.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(14)
        }
        
        labelHStack.snp.makeConstraints {
            $0.height.equalTo(20)
        }
    }
}
