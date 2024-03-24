//
//  PhotoCell.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class PhotoCell: UICollectionViewCell {
    static let identifier = "PhotoCell"
    
    private let photoView: UIImageView = {
        let view = UIImageView()
        view.cornerRadius = Constants.Radius.radius13
        view.clipsToBounds = true
        return view
    }()
    
    private let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.white.withAlphaComponent(0.3)
        view.layer.cornerRadius = Constants.Radius.radius13
        view.clipsToBounds = true
        return view
    }()
    
    private let deleteImageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(PetmilyImage.customXmark, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout1()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout2()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCell {
    static func photoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.Size.size1),
                                              heightDimension: .fractionalHeight(Constants.Size.size1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.Size.size80),
                                               heightDimension: .absolute(Constants.Size.size80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0,
                                      leading: 0,
                                      bottom: Constants.Size.size16,
                                      trailing: 0)
        section.interGroupSpacing = Constants.Spacing.spacing10
        return section
    }
    
    func setViewModel(photo: SelectPhoto) {
        photoView.image = photo.image
    }
}

private extension PhotoCell {
    func setLayout1() {
        addSubview(photoView)
        photoView.addSubview(blurView)
        blurView.addSubview(deleteImageBtn)
        
        photoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(photoView.snp.height)
        }
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setLayout2() {
        let photoViewHeight = Constants.Size.size80
        
        deleteImageBtn.snp.makeConstraints {
            $0.width.equalTo(photoViewHeight / Constants.Size.size6)
            $0.height.equalTo(photoViewHeight / Constants.Size.size6)
            $0.top.trailing.equalToSuperview().inset(photoViewHeight / Constants.Size.size8)
        }
    }
}
