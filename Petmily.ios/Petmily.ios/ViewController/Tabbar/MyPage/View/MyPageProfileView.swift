//
//  MyPageProfileView.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/02/23.
//

import UIKit

import SnapKit

class MyPageProfileView: UIView {
    lazy var profileTextField: UITextField = {
        let textField = UITextField()
        textField.text = "프로필 변경"
        textField.font = UIFont.boldSystemFont(ofSize: 24)
        textField.tintColor = .clear
        textField.inputView = pickerView
        return textField
    }()
    
    lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        return view
    }()
    
    private let profilechangebutton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    var settingButton: UIButton = {
        var btn = UIButton()
        let image = UIImage(systemName: "line.horizontal.3")
        let scaledImage = image?.scalePreservingAspectRatio(targetSize: CGSize(width: 30, height: 30))
        btn.setImage(scaledImage, for: .normal)
        btn.contentMode = .center
        btn.tintColor = .black
        return btn
    }()
    
    var userNameLabel: UILabel = {
        var label = UILabel()
        label.text = "단지"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()
    
    var editProfileButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("기본 정보 수정하기", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btn.setTitleColor(UIColor(red: 109/255, green: 109/255, blue: 109/255, alpha: 0.5), for: .normal)
        btn.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        btn.cornerRadius = 10
        return btn
    }()
    
    var profileImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "test1")
        view.bounds.size.width = 60
        view.bounds.size.height = 60
        view.cornerRadius = view.bounds.width / 2
        view.clipsToBounds = true
        return view
    }()
    
    lazy var petInfoStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [petAgeView, firstDivider, petGenderView, secondDivider, petBreedView])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    var petAgeView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var petAgeLabel: UILabel = {
        var view = UILabel()
        view.text = "나이"
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = .white
        return view
    }()
    
    var petAgeText: UILabel = {
        var view = UILabel()
        view.text = "7살"
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = .white
        return view
    }()
    
    var firstDivider: UIView = {
        var view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    var petGenderView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var petGenderLabel: UILabel = {
        var view = UILabel()
        view.text = "성별"
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = .white
        return view
    }()
    
    var petGenderText: UILabel = {
        var view = UILabel()
        view.text = "몰라"
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = .white
        return view
    }()
    
    var secondDivider: UIView = {
        var view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    var petBreedView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var petBreedLabel: UILabel = {
        var view = UILabel()
        view.text = "종"
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = .white
        return view
    }()
    
    var petBreedText: UILabel = {
        var view = UILabel()
        view.text = "강아지"
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = .white
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileTextField)
        addSubview(profilechangebutton)
        addSubview(settingButton)
        
        addSubview(userNameLabel)
        addSubview(editProfileButton)
        addSubview(profileImage)
        
        addSubview(petInfoStackView)
        petAgeView.addSubview(petAgeLabel)
        petAgeView.addSubview(petAgeText)
        petGenderView.addSubview(petGenderLabel)
        petGenderView.addSubview(petGenderText)
        petBreedView.addSubview(petBreedLabel)
        petBreedView.addSubview(petBreedText)
        
        profileTextField.snp.makeConstraints {
            $0.top.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        profilechangebutton.snp.makeConstraints {
            $0.top.centerY.equalTo(profileTextField)
            $0.leading.equalTo(profileTextField.snp.trailing).inset(-5)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.width.height.equalTo(30)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileTextField.snp.bottom).inset(-10)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).inset(-10)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(settingButton.snp.bottom).inset(-10)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(editProfileButton)
            $0.width.height.equalTo(60)
        }
        
        petInfoStackView.snp.makeConstraints {
            $0.top.equalTo(editProfileButton.snp.bottom).inset(-10)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(150)
        }
        
        petAgeLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(petAgeView).inset(10)
        }
        
        petAgeText.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(petAgeView).inset(10)
        }
        
        firstDivider.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        petGenderLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(petGenderView).inset(10)
        }
        
        petGenderText.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(petGenderView).inset(10)
        }
        
        secondDivider.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        petBreedLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(petBreedView).inset(10)
        }
        
        petBreedText.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(petBreedView).inset(10)
        }
    }
}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let scaledImage = renderer.image { _ in
            draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        return scaledImage
    }
}
