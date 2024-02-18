//
//  DailyView.swift
//  Petmily.ios
//
//  Created by 김지은 on 2/17/24.
//

import UIKit
import SnapKit

class DailyView: UIView {
    /** @brief 펫스티벌 헤더 label */
    lazy var lblHeader: UILabel = {
       let label = UILabel()
        label.text = "펫스티벌"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    /** @brief main collectionview */
    lazy var cvMain: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
               
       let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(DailyCollectionViewCell.self, forCellWithReuseIdentifier: DailyCollectionViewCell.identifier)
        collectionview.isPagingEnabled = true
        return collectionview
    }()
    /** @brief buttons stackview */
    lazy var stvButtons: UIStackView = {
       let stackview = UIStackView()
        stackview.distribution = .fillEqually
        stackview.axis = .vertical
        [btnLike, btnApply, btnMore].forEach { stackview.addArrangedSubview($0) }
        return stackview
    }()
    /** @brief 좋아요 button */
    lazy var btnLike: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btn_unlike"), for: .normal)
        button.setTitle("0", for: .normal)
        return button
    }()
    /** @brief 댓글 button */
    lazy var btnApply: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btn_apply"), for: .normal)
        button.setTitle("0", for: .normal)
        return button
    }()
    /** @brief 더보기 button */
    lazy var btnMore: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btn_more"), for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [cvMain, lblHeader, stvButtons].forEach { addSubview($0) }
        
        lblHeader.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(31)
            $0.leading.equalToSuperview().inset(15)
        }
        
        cvMain.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        btnLike.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        stvButtons.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(160)
        }
    }
}
