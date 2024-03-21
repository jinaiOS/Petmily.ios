//
//  HashTagCollectionView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class HashTagCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HashTagCollectionView {
    func configCollectionView() {
        register(HashTagCell.self,
                 forCellWithReuseIdentifier: HashTagCell.identifier)
        setCollectionViewLayout(collectionViewLayout(), animated: true)
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            return HashTagCell.hashTagSection()
        }
    }
}
