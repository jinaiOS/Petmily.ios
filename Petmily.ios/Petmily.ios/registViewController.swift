//
//  registViewController.swift
//  Petmily.ios
//
//  Created by 박현빈 on 2024/02/24.
//

import UIKit
import SnapKit
import SwiftUI

import UIKit
import SnapKit

class registViewController: UIViewController {

    let roundButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        let newColor = UIColor(hexString: "FD9B9B")
        button.backgroundColor = newColor
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        
        button.layer.cornerRadius = 50
        return button
    }()

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력하세요 ;)"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일을 입력하세요"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력하세요"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 재입력하세요."
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("계정생성", for: .normal)
        button.setTitleColor(.white, for: .normal)

        let newColor = UIColor(hexString: "FD9B9B")
        button.backgroundColor = newColor
        
        button.layer.cornerRadius = 10
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.addSubview(roundButton)
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(signupButton)

        roundButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.height.equalTo(100)
        }

        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(roundButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}


struct MyViewController_PreViews: PreviewProvider {
    static var previews: some View {
        registViewController().toPreview()
    }
}


extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
