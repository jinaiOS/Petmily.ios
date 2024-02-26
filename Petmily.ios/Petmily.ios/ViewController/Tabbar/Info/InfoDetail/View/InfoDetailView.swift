//
//  InfoDetailView.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoDetailView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let spacerView = UIView()
    private let infoDetailShareView: InfoDetailContentView
    
    init(info: ShareInfo) {
        infoDetailShareView = InfoDetailContentView(info: info)
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
        scrollView.addSubview(contentView)
        
        [spacerView, infoDetailShareView].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Constants.HeaderView.height)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
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
