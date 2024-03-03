//
//  InfoUseViewController.swift
//  Petmily.ios
//
//  Created by 박현빈 on 2024/03/03.
//

import UIKit
import SnapKit
import SwiftUI

class InfoUseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = """
        정보 이용 약관 내용을 여기에 입력하세요.
        """
        view.addSubview(textView)
        
        let agreeButton: UIButton = {
            let button = UIButton()
            button.setTitle("동의", for: .normal)
            button.setTitleColor(.white, for: .normal)

            let newColor = UIColor(hexString: "FD9B9B")
            button.backgroundColor = newColor

            button.layer.cornerRadius = 10

            button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)

            return button
        }()
        
        view.addSubview(agreeButton)
        
        textView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(agreeButton.snp.top).offset(-20)
        }

        agreeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }

    }
    
    @objc private func agreeButtonTapped() {
    }
}

//struct AddpageViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoUseViewController().toPreviewView()
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
