//
//  DailyViewController.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import UIKit

class DailyViewController: BaseViewController {

    private let dailyView = DailyView()
    
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
    }
    
}

private extension DailyViewController {
    func configure() {
        dailyView.cvMain.delegate = self
        dailyView.cvMain.dataSource = self
    }
}

extension DailyViewController: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DailyCollectionViewCell.identifier,
            for: indexPath) as? DailyCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
