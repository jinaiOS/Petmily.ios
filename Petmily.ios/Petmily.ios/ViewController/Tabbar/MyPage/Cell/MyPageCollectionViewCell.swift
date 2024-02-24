//
//  MyPageCollectionViewCell.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/02/23.
//

import UIKit

import SnapKit

class MyPageCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyPageCollectionViewCell"
    
    var collectionViewImage: UIImageView = {
        let Img = UIImageView()
        Img.layer.cornerRadius = 1
        Img.backgroundColor = .white
        Img.translatesAutoresizingMaskIntoConstraints = false
        return Img
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
    }
    
    func setUpCell() {
        contentView.addSubview(collectionViewImage)
        
        collectionViewImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind(image: String) {
        if let url = URL(string: image) {
            collectionViewImage.load(url: url)
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
