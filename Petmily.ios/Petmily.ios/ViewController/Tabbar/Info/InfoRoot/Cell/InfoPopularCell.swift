//
//  InfoPopularCell.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SnapKit
import UIKit

final class InfoPopularCell: UICollectionViewCell {
    static let identifier = "InfoPopularCell"
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = Constants.Radius.radius9
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.cornerRadius = Constants.Size.size30 / 2
        view.snp.makeConstraints {
            $0.width.height.equalTo(Constants.Size.size30)
        }
        return view
    }()
    
    private var hashtagLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.m14
        label.textColor = ThemeColor.white
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoPopularCell {
    static func popularSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                              heightDimension: .fractionalHeight(Constants.Size.size1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let gruopSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.minor35),
                                               heightDimension: .estimated(Constants.Size.size146))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: gruopSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: Constants.Size.size16,
                                      leading: Constants.Size.size16,
                                      bottom: Constants.Size.size45,
                                      trailing: Constants.Size.size16)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = Constants.Spacing.spacing16
        
        let sectionHeader = InfoPopularHeader.popularHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setViewModel(info: ShareInfo) {
        let contentUrl = URL(string: info.contentImageUrl)
        let profileUlr = URL(string: info.profileUrl)
        contentImageView.kf.setImage(with: contentUrl)
        profileImageView.kf.setImage(with: profileUlr)
        hashtagLabel.text = "#" + info.hashtag.joined(separator: " #")
    }
}

private extension InfoPopularCell {
    func setLayout() {
        [contentImageView, profileImageView, hashtagLabel].forEach {
            contentView.addSubview($0)
        }
        
        contentImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Constants.Size.size10)
        }
        
        hashtagLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.Size.size8)
            $0.bottom.equalToSuperview().inset(Constants.Size.size12)
        }
    }
}
