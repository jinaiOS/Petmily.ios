//
//  DynamicCollectionView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class DynamicCollectionView: UICollectionView {
    var readOnlyCurrentSections: (() -> [CreateShareInfoSection])?
    
    init(_ readOnlyCurrentSections: (() -> [CreateShareInfoSection])?) {
        self.readOnlyCurrentSections = readOnlyCurrentSections
        super.init(frame: .zero, collectionViewLayout: .init())
        
        configCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DynamicCollectionView {
    func configCollectionView() {
        register(HashTagCell.self,
                 forCellWithReuseIdentifier: HashTagCell.identifier)
        register(PhotoCell.self,
                 forCellWithReuseIdentifier: PhotoCell.identifier)
        setCollectionViewLayout(collectionViewLayout(), animated: true)
        isScrollEnabled = false
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionNum, _ in
            guard let self,
                  let closure = readOnlyCurrentSections?() else { return nil }
            let currentSection = closure[sectionNum]
            switch currentSection {
            case .hashtag:
                return HashTagCell.hashTagSection()
                
            case .photo:
                return PhotoCell.photoSection()
            }
        }
    }
}
