//
//  InfoSearchViewController.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import SwiftUI
import UIKit

final class InfoSearchViewController: UIViewController {
    private let infoSearchView = InfoSearchView()
    private let infoSearchViewModel = InfoSearchViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        view = infoSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        bindViewModel()
    }
}

private extension InfoSearchViewController {
    func configure() {
        view.backgroundColor = ThemeColor.systemBackground
        infoSearchView.collectionView.dataSource = self
        infoSearchView.collectionView.delegate = self
    }
    
    func bindViewModel() {
        infoSearchViewModel.$collectionViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                infoSearchView.remakeConstraints(cellCount: 10)
            }
            .store(in: &cancellable)
    }
}

extension InfoSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return InfoSearchSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch InfoSearchSection(rawValue: section) {
        case .category:
            return infoSearchViewModel.collectionViewModels.category.count
            
        case .topic:
            return 9
            
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch InfoSearchSection(rawValue: indexPath.section) {
        case .category:
            return setCategoryCell(collectionView, indexPath)
            
        case .topic:
            return setTopicCell(collectionView, indexPath)
            
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch InfoSearchSection(rawValue: indexPath.section) {
        case .category:
            return setCategoryHeader(collectionView, indexPath)
            
        case .topic:
            return setTopicHeader(collectionView, indexPath)
            
        case .none:
            return UICollectionReusableView()
        }
    }
}

private extension InfoSearchViewController {
    func setCategoryCell(_ collectionView: UICollectionView,
                         _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InfoSearchCategoryCell.identifier,
            for: indexPath) as? InfoSearchCategoryCell else { return UICollectionViewCell() }
        cell.setViewModel(category: infoSearchViewModel.collectionViewModels.category[indexPath.item])
        return cell
    }
    
    func setTopicCell(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InfoSearchTopicCell.identifier,
            for: indexPath) as? InfoSearchTopicCell else { return UICollectionViewCell() }
        cell.setViewModel(title: infoSearchViewModel.collectionViewModels.title,
                          profileUrl: infoSearchViewModel.collectionViewModels.profileUrl,
                          author: infoSearchViewModel.collectionViewModels.author,
                          date: infoSearchViewModel.collectionViewModels.date,
                          contentImageUrl: infoSearchViewModel.collectionViewModels.contentImageUrl)
        return cell
    }
}

private extension InfoSearchViewController {
    func setCategoryHeader(_ collectionView: UICollectionView,
                           _ indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: InfoSearchCategoryHeader.identifier,
            for: indexPath) as? InfoSearchCategoryHeader else { return UICollectionReusableView() }
        header.setViewModel(title: "추천 검색어")
        return header
    }
    
    func setTopicHeader(_ collectionView: UICollectionView,
                        _ indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: InfoSearchTopicHeader.identifier,
            for: indexPath) as? InfoSearchTopicHeader else { return UICollectionReusableView() }
        header.setViewModel(mainTitle: infoSearchViewModel.collectionViewModels.headerTitle,
                            subTitle: infoSearchViewModel.collectionViewModels.subTitle)
        return header
    }
}

// MARK: - Preview
struct InfoSearchVC_PreView: PreviewProvider {
    static var previews: some View {
        InfoSearchViewController().toPreview()
    }
}
