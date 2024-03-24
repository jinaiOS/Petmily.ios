//
//  MyPagePostView.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/02/23.
//

import UIKit

import SnapKit

class MyPagePostView: UIView {
    var postView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = Constants.Radius.radius9
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        return view
    }()
    
    var postSegmentControl: UISegmentedControl = {
        var control = UISegmentedControl(items: ["데일리", "정보공유"])
        let font = ThemeFont.b20
        control.setTitleTextAttributes([NSAttributedString.Key.font: font],for: .normal)
        control.selectedSegmentTintColor = .gray
        control.backgroundColor = .white
        control.selectedSegmentIndex = 0
        return control
    }()
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.dailyCollectionView.isHidden = shouldHideFirstView
            self.infoCollectionView.isHidden = !self.dailyCollectionView.isHidden
        }
    }
    
    lazy var postStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [dailyCollectionView, infoCollectionView])
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let dailyFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private let infoFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var dailyCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.dailyFlowLayout)
        let rowCount: CGFloat = 3
        dailyFlowLayout.scrollDirection = .vertical
        dailyFlowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / rowCount) - 8, height: (UIScreen.main.bounds.width / rowCount) - 4)
        dailyFlowLayout.minimumLineSpacing = 2
        dailyFlowLayout.minimumInteritemSpacing = 2
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var infoCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.infoFlowLayout)
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        postSegmentControl.selectedSegmentIndex = 0
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(postView)
        
        postView.addSubview(postSegmentControl)
        postView.addSubview(postStackView)
        
        postView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        postSegmentControl.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(postView)
            $0.height.equalTo(60)
        }
        
        postStackView.snp.makeConstraints{
            $0.top.equalTo(postSegmentControl.snp.bottom)
            $0.leading.trailing.bottom.equalTo(postView)
        }
    }
}
