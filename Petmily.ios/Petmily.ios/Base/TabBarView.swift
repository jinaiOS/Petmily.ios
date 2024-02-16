//
//  TabBarView.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import UIKit
import SnapKit

class TabBarView: UIView {
    lazy var dailyBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tab_daily"), for: .normal)
        button.setImage(UIImage(named: "tab_daily_selected"), for: .selected)
        return button
    }()
    
    lazy var infoBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tab_info"), for: .normal)
        button.setImage(UIImage(named: "tab_info_selected"), for: .selected)
        return button
    }()
    
    lazy var locationBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tab_location"), for: .normal)
        button.setImage(UIImage(named: "tab_location_selected"), for: .selected)
        return button
    }()
    
    lazy var myBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tab_my"), for: .normal)
        button.setImage(UIImage(named: "tab_my_selected"), for: .selected)
        return button
    }()
    
    lazy var addBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "add_icon"), for: .normal)
        button.setImage(UIImage(named: "add_icon"), for: .selected)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 30
        
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 위치 (수평, 수직)
        stack.layer.shadowOpacity = 0.1 // 그림자 투명도
        stack.layer.shadowRadius = 10 // 그림자 반경
        
        
        [dailyBtn, infoBtn, addBtn,locationBtn, myBtn].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI

struct TabBarViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> TabBarView {
        return TabBarView()
    }
    
    func updateUIView(_ uiView: TabBarView, context: Context) {
        // Update the view if needed
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarViewWrapper()
            .previewLayout(.fixed(width: 400, height: 100)) // 미리보기 크기 지정
            .padding() // 패딩 추가
            .background(Color.gray) // 배경색 추가
    }
}
