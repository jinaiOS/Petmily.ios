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
    private var dataSource: UICollectionViewDiffableDataSource<InfoSearchSection, infoSearchItem>?
    private var cancellable = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        view = infoSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setDataSource()
        setHeaderView()
        bindViewModel()
        bindTextField()
        Task {
            await infoSearchViewModel.setDummyData()
        }
    }
    
    deinit {
        print("deinit - InfoSearchVC")
    }
}

private extension InfoSearchViewController {
    func configure() {
        view.backgroundColor = ThemeColor.systemBackground
        infoSearchView.scrollView.delegate = self
        infoSearchView.collectionView.delegate = self
    }
    
    func bindViewModel() {
        infoSearchViewModel.$collectionViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.applyItems()
            }.store(in: &cancellable)
    }
    
    func bindTextField() {
        infoSearchView.searchContentView.searchTextField
            .myDebounceTextFieldPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.searchInput, on: infoSearchViewModel)
            .store(in: &cancellable)
    }
}

private extension InfoSearchViewController {
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: infoSearchView.collectionView,
            cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
                guard let self else { return UICollectionViewCell() }
                switch itemIdentifier {
                case .category(let item):
                    return setCategoryCell(collectionView, indexPath, item)
                    
                case .topic(let item):
                    return setTopicCell(collectionView, indexPath, item)
                }
            })
    }
    
    func setHeaderView() {
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self else { return UICollectionReusableView() }
            switch InfoSearchSection(rawValue: indexPath.section) {
            case .category:
                return setCategoryHeader(collectionView, indexPath)
                
            case .topic:
                return setTopicHeader(collectionView, indexPath)
                
            case .none:
                return nil
            }
        }
    }
    
    func applyItems() {
        var snapShot = NSDiffableDataSourceSnapshot<InfoSearchSection, infoSearchItem>()
        InfoSearchSection.allCases.forEach {
            snapShot.appendSections([$0])
        }
        
        if let categoryItems = infoSearchViewModel.collectionViewModels.categoryItems {
            snapShot.appendItems(categoryItems, toSection: .category)
        }
        
        if let topicItems = infoSearchViewModel.collectionViewModels.topicItems {
            snapShot.appendItems(topicItems, toSection: .topic)
        }
        dataSource?.apply(snapShot)
    }
}

private extension InfoSearchViewController {
    func setCategoryCell(_ collectionView: UICollectionView,
                         _ indexPath: IndexPath,
                         _ item: String) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InfoSearchCategoryCell.identifier,
            for: indexPath) as? InfoSearchCategoryCell else { return UICollectionViewCell() }
        cell.setViewModel(category: item)
        return cell
    }
    
    func setTopicCell(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ item: TopicInfo) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InfoSearchTopicCell.identifier,
            for: indexPath) as? InfoSearchTopicCell else { return UICollectionViewCell() }
        cell.setViewModel(info: item)
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
        header.setViewModel(mainTitle: "반려인은 전부 봤다", subTitle: "운영자 작성 글")
        return header
    }
}

extension InfoSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("select")
    }
}

extension InfoSearchViewController: UIScrollViewDelegate {
}

// MARK: - Preview
struct InfoSearchVC_PreView: PreviewProvider {
    static var previews: some View {
        InfoSearchViewController().toPreview()
    }
}
