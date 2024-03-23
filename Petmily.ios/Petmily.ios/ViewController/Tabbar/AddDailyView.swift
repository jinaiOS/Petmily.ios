//
//  AddDailyView.swift
//  Petmily.ios
//
//  Created by 김지은 on 3/2/24.
//

import UIKit

class AddDailyView: UIView {
    /** @brief video imageview */
    lazy var imgVideo: UIImageView = {
       let imageview = UIImageView()
        imageview.cornerRadius = 8
        imageview.clipsToBounds = true
        return imageview
    }()
    /** @brief back button */
    lazy var btnBack: UIButton = {
       let button = UIButton()
        button.setImage(PetmilyImage.back, for: .normal)
        return button
    }()
    /** @brief 설명 작성 button */
    lazy var btnExplain: UIButton = {
       let button = UIButton()
        button.backgroundColor = ThemeColor.appPink
        button.titleLabel?.font = ThemeFont.b24
        button.titleLabel?.textColor = .white
        button.cornerRadius = 30
        button.setTitle("설명 작성", for: .normal)
        return button
    }()
    /** @brief 다음 button */
    lazy var btnNext: UIButton = {
       let button = UIButton()
        button.setImage(PetmilyImage.next, for: .normal)
        button.backgroundColor = ThemeColor.appPink
        button.cornerRadius = 30
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
        [imgVideo, btnBack, btnExplain, btnNext].forEach { addSubview($0) }
        
        imgVideo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.trailing.equalToSuperview().inset(23)
        }
        
        btnBack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(23)
            $0.width.equalTo(30)
            $0.height.equalTo(56)
        }
        
        btnExplain.snp.makeConstraints {
            $0.top.equalTo(imgVideo.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(23)
            $0.bottom.equalToSuperview().inset(44)
            $0.height.equalTo(60)
        }
        
        btnNext.snp.makeConstraints {
            $0.top.equalTo(imgVideo.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(23)
            $0.leading.equalTo(btnExplain.snp.trailing).offset(9)
            $0.width.height.equalTo(60)
        }
    }

}
