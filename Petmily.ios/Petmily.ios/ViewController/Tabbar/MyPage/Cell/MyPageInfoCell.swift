//
//  MyPageInfoCell.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/02/23.
//

import UIKit

import SnapKit

class MyPageInfoCell: UICollectionViewCell {
    static let identifier = "MyPageInfoCell"
    
    private lazy var titleLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 20, weight: .bold)
        return makeLabel(font: font, textColor: .label)
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 18, weight: .medium)
        return makeLabel(font: font, textColor: .label)
    }()
    
    private lazy var contentVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 8
        
        [titleLabel, descriptionLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var writerLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 10, weight: .regular)
        return makeLabel(font: font, textColor: .systemGray)
    }()
    
    private lazy var tagLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 10, weight: .bold)
        return makeLabel(font: font, textColor: .white)
    }()
    
    private lazy var tagView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 0.725, blue: 0.725, alpha: 1)
        view.addSubview(tagLabel)
        view.layer.cornerRadius = 6
        
        tagLabel.snp.makeConstraints {
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
        
        [writerLabel, tagView].forEach {
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
    
    private lazy var imageView: UIImageView = {
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
        
        [labelVStack, imageView].forEach {
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

extension MyPageInfoCell {
    func configure(title: String, description: String, writer: String, tag: String, image: UIImage?) {
        titleLabel.text = title
        descriptionLabel.text = description
        writerLabel.text = writer
        tagLabel.text = tag
        imageView.image = image
    }
}

private extension MyPageInfoCell {
    func makeLabel(font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = textColor
        label.font = font
        return label
    }
    
    func setLayout() {
        contentView.addSubview(contentViewHStack)
        self.backgroundColor = .white
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
            $0.trailing.equalTo(imageView.snp.leading).offset(-41)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(6)
        }
        
        writerLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        tagView.snp.makeConstraints {
            $0.height.equalTo(22)
        }
    }
}
