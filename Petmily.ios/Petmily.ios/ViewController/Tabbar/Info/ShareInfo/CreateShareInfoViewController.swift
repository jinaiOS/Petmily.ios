//
//  CreateShareInfoViewController.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import SwiftUI
import UIKit

final class CreateShareInfoViewController: BaseHeaderViewController {
    private let createShareInfoView = CreateShareInfoView()
    private let createShareInfoViewModel = CreateShareInfoViewModel()
    
    override func loadView() {
        super.loadView()
        
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setBaseHeaderView()
        setKeyboardObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
    }
    
    deinit {
        print("deinit - CreateShareInfoVC")
    }
}

extension CreateShareInfoViewController {
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            createShareInfoView.remakeConstraints(keyboardHight: keyboardHeight)
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        createShareInfoView.remakeConstraints()
    }
}

private extension CreateShareInfoViewController {
    func setLayout() {
        view.addSubview(createShareInfoView)
        
        createShareInfoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.HeaderView.height)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure() {
        view.backgroundColor = ThemeColor.systemBackground
        
        createShareInfoView.hashtagTextField.delegate = self
        createShareInfoView.titleTextField.delegate = self
        createShareInfoView.contentTextView.delegate = self
    }
    
    func setBaseHeaderView() {
        headerView.backButton.setImage(PetmilyImage.customXmark, for: .normal)
        
        let title = NSMutableAttributedString(
            string: createShareInfoViewModel.baseHeaderTitle,
            attributes: [.font: ThemeFont.b24])
        headerView.titleLabel.attributedText = title
        
        createShareInfoView.doneButton.addTarget(self,
                                        action: #selector(didTapDoneButton),
                                        for: .touchUpInside)
        headerView.addSubview(createShareInfoView.doneButton)
        
        createShareInfoView.doneButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.Size.size16)
        }
    }
}

private extension CreateShareInfoViewController {
    @objc func didTapDoneButton() {
        
    }
}

extension CreateShareInfoViewController: UITextFieldDelegate {
}

extension CreateShareInfoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = createShareInfoViewModel.textViewPlaceholder
            textView.textColor = ThemeColor.lightGray
        } else {
            textView.textColor = ThemeColor.label
        }
    }
    
    // 텍스트뷰가 터치될 때 호출되는 메서드
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == createShareInfoViewModel.textViewPlaceholder {
            textView.text = ""
            textView.textColor = ThemeColor.label
        }
    }
    
    // 텍스트뷰에서 포커스가 벗어날 때 호출되는 메서드
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = createShareInfoViewModel.textViewPlaceholder
            textView.textColor = ThemeColor.lightGray
        }
    }
}

// MARK: - Preview
struct CreateShareInfoVC_PreView: PreviewProvider {
    static var previews: some View {
        CreateShareInfoViewController().toPreview()
    }
}
