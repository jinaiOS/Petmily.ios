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
        imageview.cornerRadius = Constants.Radius.radius7
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
        button.titleLabel?.textColor = ThemeColor.white
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
            $0.top.equalToSuperview().inset(Constants.Spacing.spacing14)
            $0.leading.trailing.equalToSuperview().inset(Constants.Spacing.spacing16)
        }
        
        btnBack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.Spacing.spacing20)
            $0.leading.equalToSuperview().inset(Constants.Spacing.spacing16)
            $0.width.equalTo(Constants.Size.size30)
            $0.height.equalTo(Constants.Size.size52)
        }
        
        btnExplain.snp.makeConstraints {
            $0.top.equalTo(imgVideo.snp.bottom).offset(Constants.Spacing.spacing16)
            $0.leading.equalToSuperview().inset(Constants.Spacing.spacing16)
            $0.bottom.equalToSuperview().inset(Constants.Spacing.spacing40)
            $0.height.equalTo(Constants.Size.size52)
        }
        
        btnNext.snp.makeConstraints {
            $0.top.equalTo(imgVideo.snp.bottom).offset(Constants.Spacing.spacing16)
            $0.trailing.equalToSuperview().inset(Constants.Spacing.spacing16)
            $0.leading.equalTo(btnExplain.snp.trailing).offset(Constants.Spacing.spacing10)
            $0.width.height.equalTo(Constants.Size.size52)
        }
    }

}
