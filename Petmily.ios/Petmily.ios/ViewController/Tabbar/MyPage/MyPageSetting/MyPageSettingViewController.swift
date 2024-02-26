//
//  MyPageSettingViewController.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/02/23.
//

import UIKit

import SnapKit

class MyPageSettingViewController: BaseHeaderViewController {
    //MARK: Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let profileTitle: UILabel = {
       let label = UILabel()
        label.text = "프로필 설정"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var profileStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameTextField, ageTextField, breedTextField, completeButton])
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private let profileNickName: UITextField = {
        let field = UITextField()
        field.placeholder = "닉네임을 입력해주세요."
        return field
    }()
    
    private let nameTextField = CustomTextField(type: .normal, header: "동물 이름", placeHolder: "이름")
    private let ageTextField = CustomTextField(type: .normal, header: "동물 나이", placeHolder: "나이")
    
    // 성별
    private let breedTextField = CustomTextField(type: .normal, header: "종", placeHolder: "종류")
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .gray
        button.clipsToBounds = true
        button.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setHeaderHidden(isHidden: false)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileTitle)
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileNickName)
        contentView.addSubview(profileStackView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        profileTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(profileTitle.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        profileNickName.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        profileStackView.snp.makeConstraints {
            $0.top.equalTo(profileNickName.snp.bottom)
            $0.leading.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        completeButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
