//
//  InfoViewController.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import Kingfisher
import SnapKit
import SwiftUI
import UIKit

final class InfoViewController: BaseHeaderViewController {
    private let infoView = InfoView()
    private let infoViewModel = InfoViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<InfoSection, InfoItem>?
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseHeaderView()
        configure()
        setDataSource()
        setHeaderView()
        bindViewModel()
        getData()
    }
}

private extension InfoViewController {
    func configure() {
        infoView.collectionView.delegate = self
        infoView.collectionView.refreshControl?.addTarget(self,
                                                          action: #selector(refreshCollectionView),
                                                          for: .valueChanged)
    }
    
    func setLayout() {
        view.addSubview(infoView)
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.HeaderView.height)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setBaseHeaderView() {
        let title = NSMutableAttributedString(
            string: infoViewModel.baseHeaderTitle,
            attributes: [.font: ThemeFont.b24])
        headerView.titleLabel.attributedText = title
        
        backButtonHidden()
        
        infoView.searchButton.addTarget(self,
                                        action: #selector(didTapSearchButton),
                                        for: .touchUpInside)
        headerView.addSubview(infoView.searchButton)
        
        infoView.searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.Size.size16)
            $0.width.height.equalTo(Constants.Size.size30)
        }
    }
    
    /**
     @brief ViewModel 연결
     */
    func bindViewModel() {
        infoViewModel.$collectionViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                infoView.collectionView.refreshControl?.endRefreshing()
                applyItems()
            }.store(in: &cancellables)
    }
    
    func getData() {
        Task {
            await infoViewModel.fetchInfoSectionData(section: .popular,
                                                     breed: infoViewModel.currentBreed,
                                                     lastData: nil)
            
            await infoViewModel.fetchInfoSectionData(section: .share,
                                                     breed: infoViewModel.currentBreed,
                                                     lastData: nil)
        }
    }
    
    @objc func refreshCollectionView() {
        infoView.collectionView.refreshControl?.beginRefreshing()
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache()
        infoViewModel.resetAllData()
        getData()
    }
}

private extension InfoViewController {
    @objc func didTapSearchButton() {
        let searchVC = InfoSearchViewController()
        present(searchVC, animated: true)
    }
}

private extension InfoViewController {
    /**
     @brief dataSources 설정
     */
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: infoView.collectionView,
            cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
                guard let self else { return UICollectionViewCell() }
                switch itemIdentifier {
                case .spacer:
                    return setSpacerCell(collectionView, indexPath)
                    
                case .popular(let item):
                    return setPopularCell(collectionView, indexPath, item)
                    
                case .share(let item):
                    return setShareCell(collectionView, indexPath, item)
                }
            })
    }
    
    /**
     @brief headerView 설정
     */
    func setHeaderView() {
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self else { return UICollectionReusableView() }
            switch InfoSection(rawValue: indexPath.section) {
            case .spacer, .none: return nil
                
            case .popular:
                return setPopularHeader(collectionView, indexPath)
                
            case .share:
                return setShareHeader(collectionView, indexPath)
            }
        }
    }
    
    /**
     @brief snapShot 설정
     */
    func applyItems() {
        var snapShot = NSDiffableDataSourceSnapshot<InfoSection, InfoItem>()
        let popularItems = infoViewModel.collectionViewModels.popularItems
        let shareItems = infoViewModel.collectionViewModels.shareItems
        
        InfoSection.allCases.forEach {
            snapShot.appendSections([$0])
        }
        if popularItems.isEmpty != true {
            snapShot.appendItems([InfoItem.spacer], toSection: .spacer)
            snapShot.appendItems(popularItems, toSection: .popular)
        }
        if shareItems.isEmpty != true {
            snapShot.appendItems(shareItems, toSection: .share)
        }
        dataSource?.apply(snapShot)
    }
}

/**
 @brief Cell 설정
 @param collectionView: UICollectionView, indexPath: IndexPath, item: 각각의 cell에 맞는 item
 */
private extension InfoViewController {
    func setSpacerCell(_ collectionView: UICollectionView,
                       _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SpacerCell.identifier,
            for: indexPath) as? SpacerCell else { return UICollectionViewCell() }
        return cell
    }
    
    func setPopularCell(_ collectionView: UICollectionView,
                        _ indexPath: IndexPath,
                        _ item: ShareInfo) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InfoPopularCell.identifier,
            for: indexPath) as? InfoPopularCell else { return UICollectionViewCell() }
        cell.setViewModel(info: item)
        return cell
    }
    
    func setShareCell(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ item: ShareInfo) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InfoShareCell.identifier,
            for: indexPath) as? InfoShareCell else { return UICollectionViewCell() }
        cell.setViewModel(info: item)
        return cell
    }
}

/**
 @brief HeaderView 설정
 @param collectionView: UICollectionView, indexPath: IndexPath
 */
private extension InfoViewController {
    func setPopularHeader(_ collectionView: UICollectionView,
                          _ indexPath: IndexPath) -> UICollectionReusableView {
        guard let popularHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: InfoPopularHeader.identifier,
            for: indexPath) as? InfoPopularHeader else { return UICollectionReusableView() }
        popularHeader.setViewModel(title: InfoViewModel.HeaderTitle.popular.title)
        return popularHeader
    }
    
    func setShareHeader(_ collectionView: UICollectionView,
                        _ indexPath: IndexPath) -> UICollectionReusableView {
        guard let shareHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: InfoShareHeader.identifier,
            for: indexPath) as? InfoShareHeader else { return UICollectionReusableView() }
        shareHeader.setViewModel(title: InfoViewModel.HeaderTitle.share.title)
        return shareHeader
    }
}

extension InfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        var infoItems: [InfoItem]? = nil
        
        switch InfoSection(rawValue: indexPath.section) {
        case .spacer, .none: return
            
        case .popular:
            infoItems = infoViewModel.collectionViewModels.popularItems
            
        case .share:
            infoItems = infoViewModel.collectionViewModels.shareItems
        }
        
        guard let infoItem = infoItems?[indexPath.item],
              let shareInfo = infoViewModel.infoItemToShareInfo(item: infoItem) else { return }
        let infoDetailVC = InfoDetailViewController(shareInfo)
        navigationPushController(viewController: infoDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        switch InfoSection(rawValue: indexPath.section) {
        case .spacer, .popular, .none: return
            
        case .share:
            let infoItems = infoViewModel.collectionViewModels.shareItems
            guard let lastItem = infoItems.last else { return }
            let shareInfo = infoViewModel.infoItemToShareInfo(item: lastItem)
            let itemsCount = infoItems.count
            let currentRow = indexPath.row
            let remainCount = infoViewModel.remainCount
            
            if (itemsCount - currentRow) == remainCount &&
                (itemsCount % currentRow) == remainCount {
                Task {
                    await infoViewModel.fetchInfoSectionData(section: .share,
                                                             breed: infoViewModel.currentBreed,
                                                             lastData: shareInfo)
                }
            }
        }
    }
}

// MARK: - Preview
struct InfoVC_PreView: PreviewProvider {
    static var previews: some View {
        InfoViewController().toPreview()
    }
}
