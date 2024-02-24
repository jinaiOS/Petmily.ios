//
//  addpageViewController.swift
//  Petmily.ios
//
//  Created by 박현빈 on 2024/02/24.
//

import UIKit
import SnapKit
import SwiftUI

class addpageViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정보공유 글쓰기"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    let tagTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "태그를 입력해주세요."
        textField.borderStyle = .roundedRect
        return textField
    }()

    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력하세요."
        textField.borderStyle = .roundedRect
        return textField
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "강아지 관련된 질문이나 이야기를 해보세요."
        textView.textColor = UIColor.lightGray
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5
        return textView
    }()

    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
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
        view.addSubview(titleLabel)
        view.addSubview(tagTextField)
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(completeButton)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }

        tagTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(tagTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }

        completeButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

    }
}

//struct MyViewController_PreViews: PreviewProvider {
//    static var previews: some View {
//        addpageViewController().toPreview()
//    }
//}
//
//
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//            let viewController: UIViewController
//
//            func makeUIViewController(context: Context) -> UIViewController {
//                return viewController
//            }
//
//            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//            }
//        }
//
//        func toPreview() -> some View {
//            Preview(viewController: self)
//        }
//}
