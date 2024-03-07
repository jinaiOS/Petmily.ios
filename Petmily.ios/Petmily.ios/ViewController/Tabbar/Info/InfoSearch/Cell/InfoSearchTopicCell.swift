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
        label.font = ThemeFont.m14
        label.textColor = ThemeColor.black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.cornerRadius = Constants.Size.size20 / 2
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size20)
        }
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.m10
        label.textColor = ThemeColor.mediumGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.mediumGray
        
        view.snp.makeConstraints {
            $0.width.equalTo(Constants.Size.size1)
        }
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.m10
        label.textColor = ThemeColor.mediumGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var labelHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing5
        
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
        stack.spacing = Constants.Spacing.spacing10
        
        [titleLabel, labelHStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.cornerRadius = Constants.Radius.radius5
        
        view.snp.makeConstraints {
            $0.width.equalTo(view.snp.height)
        }
        return view
    }()
    
    private lazy var contentHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing6
        
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                              heightDimension: .fractionalHeight(Constants.Size.size1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                               heightDimension: .absolute(Constants.Size.size100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: Constants.Size.size8,
                                      leading: Constants.Size.size24,
                                      bottom: 0,
                                      trailing: Constants.Size.size24)
        section.interGroupSpacing = Constants.Spacing.spacing14
        
        let sectionHeader = InfoSearchTopicHeader.topicHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setViewModel(info: TopicInfo) {
        let profileUrl = URL(string: info.profileUrl)
        let contentUrl = URL(string: info.contentUrl)
        profileImageView.kf.setImage(with: profileUrl)
        contentImageView.kf.setImage(with: contentUrl)
        titleLabel.text = info.title
        authorLabel.text = info.author
        dateLabel.text = "\(info.date)"
    }
}

private extension InfoSearchTopicCell {
    func setLayout() {
        layer.cornerRadius = Constants.Radius.radius9
        layer.borderWidth = Constants.Size.size1
        layer.borderColor = ThemeColor.lightGray.cgColor
        
        contentView.addSubview(contentHStack)
        
        contentHStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.Size.size12)
        }
    }
}
