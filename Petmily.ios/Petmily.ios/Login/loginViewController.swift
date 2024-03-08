//
//  loginViewController.swift
//  Petmily.ios
//
//  Created by 박현빈 on 2024/02/24.
//

import UIKit
import SnapKit
import SwiftUI

class loginViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요 ;)"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let titleLabel2: UILabel = {
        let label = UILabel()
        label.text = "펫밀리입니다."
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "펫밀리입니다. 여러분의 친구들을 소개해주세요!"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.gray
        return label
    }()

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디 입력"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 입력"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)

        let newColor = UIColor(hexString: "FD9B9B")
        button.backgroundColor = newColor

        button.layer.cornerRadius = 10

        let font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.titleLabel?.font = font

        return button
    }()
    
    
    
    let findIDButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let autoLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "자동로그인"
        label.textColor = .black
        return label
    }()
    
    let autoLoginCheckbox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(autoLoginCheckboxTapped), for: .touchUpInside)
        return button
    }()
    
//    let separatorView1: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.lightGray
//        return view
//    }()
//
//    let separatorView2: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.lightGray
//        return view
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(titleLabel2)
        view.addSubview(subtitleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(findIDButton)
        view.addSubview(findPasswordButton)
        view.addSubview(signUpButton)
        view.addSubview(autoLoginCheckbox)
        view.addSubview(autoLoginLabel)


        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(100)
        }

        titleLabel2.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }

        subtitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(titleLabel2.snp.bottom).offset(10)
        }

        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        autoLoginLabel.snp.makeConstraints {
                $0.centerY.equalTo(autoLoginCheckbox)
                $0.trailing.equalTo(autoLoginCheckbox.snp.leading).offset(-10)
            }
        
        autoLoginCheckbox.snp.makeConstraints {
                $0.top.equalTo(loginButton.snp.bottom).offset(20)
                $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }

        
        findIDButton.snp.makeConstraints {
                $0.top.equalTo(autoLoginCheckbox.snp.bottom).offset(20)
                $0.leading.equalToSuperview().offset(20)
            }

        
            findPasswordButton.snp.makeConstraints {
                $0.top.equalTo(autoLoginCheckbox.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
            }

            signUpButton.snp.makeConstraints {
                $0.top.equalTo(autoLoginCheckbox.snp.bottom).offset(20)
                $0.trailing.equalToSuperview().offset(-20)
            }
        

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    @objc func loginButtonTapped() {
    }
    
    @objc func autoLoginCheckboxTapped() {
        autoLoginCheckbox.isSelected.toggle()
    }
}

//struct AddpageViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        loginViewController().toPreviewView()
//    }
//}
//
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        let viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//
//    func toPreviewView() -> some View {
//        Preview(viewController: self)
//    }
//}
