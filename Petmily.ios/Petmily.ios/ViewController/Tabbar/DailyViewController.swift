//
//  DailyViewController.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import UIKit
import Combine

class DailyViewController: BaseViewController {

    private let dailyView = DailyView()
    private var vm = DailyViewModel()
    private var cancellables = Set<AnyCancellable>()
    var shareDailies: [ShareDaily]?
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(dailyView)
        
        dailyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getDailies()
        dailyView.btnLike.addTarget(self, action: #selector(toggleLikeButton), for: .touchUpInside)
        dailyView.btnApply.addTarget(self, action: #selector(commentButtonPressed), for: .touchUpInside)
        dailyView.btnMore.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
    }
    
}

private extension DailyViewController {
    func configure() {
        dailyView.cvMain.delegate = self
        dailyView.cvMain.dataSource = self
    }
    
    @objc func toggleLikeButton() {
        dailyView.btnLike.isSelected = !dailyView.btnLike.isSelected
        dailyView.btnLike.configurationUpdateHandler?(dailyView.btnLike)
    }
    
    @objc func commentButtonPressed() {
        let vc = CommentViewController()
        guard let sheet = vc.presentationController as? UISheetPresentationController else {
            return
        }
        sheet.detents = [.medium(), .large()]
        sheet.largestUndimmedDetentIdentifier = .large
        sheet.prefersGrabberVisible = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func menuButtonPressed() {
        let vc = AddDailyViewController()
        navigationPushController(viewController: vc, animated: true)
    }
}

extension DailyViewController {
    private func getDailies() {
        Task {
            await vm.getShareDaily(breed: .cat, lastData: nil, limitCount: 10)
        }
    }
    
    private func bindViewModel() {
        vm.$shareDailies
            .receive(on: RunLoop.main)
            .sink { shareDailies in
                self.shareDailies = shareDailies
                self.dailyView.cvMain.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension DailyViewController: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareDailies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DailyCollectionViewCell.identifier,
            for: indexPath) as? DailyCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .red
        guard let shareDaily = shareDailies?[indexPath.row] else { return cell }
        updateUI(shareDaily)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    private func updateUI(_ data: ShareDaily) {
        dailyView.lblProfile.text = data.author
        dailyView.lblContent.text = data.content
        dailyView.lblTag.text = data.hashtag[0]
    }
}
