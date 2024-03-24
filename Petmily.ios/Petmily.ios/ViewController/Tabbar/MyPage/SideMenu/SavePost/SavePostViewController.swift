//
//  SavePostViewController.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/03/23.
//

import UIKit

import SnapKit

class SavePostViewController: BaseHeaderViewController {
    //MARK: Properties
    lazy var savePostCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        view.showsVerticalScrollIndicator = false
        view.register(MyPageInfoCell.self, forCellWithReuseIdentifier: MyPageInfoCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

// MARK: SetUp
private extension SavePostViewController {
    func setUp() {
        savePostCollectionView.delegate = self
        savePostCollectionView.dataSource = self
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(savePostCollectionView)
        
        savePostCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(Constants.Spacing.spacing16)
        }
    }
}

extension SavePostViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = savePostCollectionView.dequeueReusableCell(withReuseIdentifier: MyPageInfoCell.identifier, for: indexPath) as! MyPageInfoCell
        cell.configure(title: "제목", description: "내용", writer: "작성자", tag: "애완동물 & 자유로운", image: UIImage(named: "sample1"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = collectionViewWidth - Constants.Spacing.spacing16
        let cellHeight: CGFloat = 152
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
