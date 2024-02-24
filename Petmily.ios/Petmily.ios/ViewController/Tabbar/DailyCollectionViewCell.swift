//
//  DailyCollectionViewCell.swift
//  Petmily.ios
//
//  Created by 김지은 on 2/17/24.
//

import UIKit
import SnapKit

final class DailyCollectionViewCell: UICollectionViewCell {
    static let identifier = "DailyCollectionViewCell"
    
    lazy var imgMain: UIImageView = {
       let imageview = UIImageView()
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DailyCollectionViewCell {
    func setUI() {
        
    }
    
    func setLayout() {
        addSubview(imgMain)
        
        imgMain.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
