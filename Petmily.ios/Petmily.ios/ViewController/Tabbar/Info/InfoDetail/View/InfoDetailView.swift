//
//  InfoDetailView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import UIKit

final class InfoDetailView: UIView {
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let spacerView = UIView()
    private let infoDetailShareView: InfoDetailContentView
    
    init(_ info: ShareInfo,
         _ menuBtnSubject: PassthroughSubject<MenuButtonType, Never>,
         _ socialBtnSubject: PassthroughSubject<SocialButtonType, Never>) {
        infoDetailShareView = InfoDetailContentView(info, menuBtnSubject, socialBtnSubject)
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InfoDetailView {
    func setLayout() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [spacerView, infoDetailShareView].forEach {
            containerView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Constants.HeaderView.height)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        spacerView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(Constants.Size.size12)
        }
        
        infoDetailShareView.snp.makeConstraints {
            $0.top.equalTo(spacerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
