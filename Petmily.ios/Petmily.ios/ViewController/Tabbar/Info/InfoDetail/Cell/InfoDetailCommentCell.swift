//
//  InfoDetailCommentCell.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoDetailCommentCell: UICollectionViewCell {
    static let identifier = "InfoDetailCommentCell"
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.white
        label.backgroundColor = ThemeColor.lightPink
        label.font = ThemeFont.m12
        label.textAlignment = .center
        label.numberOfLines = 1
        label.cornerRadius = Constants.Radius.radius2
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.m14
        label.textColor = ThemeColor.darkGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing11
        
        [stateLabel, authorLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.m14
        label.textColor = ThemeColor.black
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    private let spacer = UIView()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.m14
        label.textColor = ThemeColor.darkGray
        label.textAlignment = .right
        label.numberOfLines = 1
        
        label.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.size20)
        }
        return label
    }()
    
    private lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.systemGray5
        
        view.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.size2)
        }
        return view
    }()
    
    private lazy var commentVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = Constants.Spacing.spacing8
        
        [hStack, commentLabel, spacer, dateLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(commentVStack)
        
        commentVStack.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constants.Size.size24)
            $0.trailing.equalToSuperview().inset(Constants.Size.size14)
        }
        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.Spacing.spacing16
        
        [separateView, containerView].forEach {
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

extension InfoDetailCommentCell {
    static func commentSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                              heightDimension: .fractionalHeight(Constants.Size.size1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let gruopSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                               heightDimension: .absolute(Constants.Size.size121))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: gruopSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        
        let sectionHeader = InfoDetailCommentHeader.commentHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setViewModel(comment: Comment) {
        stateLabel.text = comment.state
        authorLabel.text = comment.author
        commentLabel.text = comment.comment
        dateLabel.text = "\(comment.date)"
    }
}

private extension InfoDetailCommentCell {
    func setLayout() {
        contentView.addSubview(vStack)
        
        vStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stateLabel.snp.makeConstraints {
            $0.width.equalTo(Constants.Size.size46)
            $0.height.equalTo(Constants.Size.size16)
        }
    }
}
