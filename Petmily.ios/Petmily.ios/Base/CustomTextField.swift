//
//  CustomTextField.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/02/26.
//

import UIKit

import SnapKit

enum TextFieldType {
    case normal
    case password
}

class CustomTextField: UIStackView {
    // MARK: - Properties
    
    private let type: TextFieldType

    // MARK: - Components
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        return label
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.inputAccessoryView = nil
        view.autocapitalizationType = .none
        view.addAction(UIAction(handler: { [weak self] _ in
            guard let text = self?.textField.text else { return }
            self?.setAdditional(text: text)
        }), for: .editingChanged)
        return view
    }()
    
    lazy var additionalButton: UIButton = {
        let button = UIButton()
        button.setImage(self.type == .password ? UIImage(systemName: "eye") : UIImage(systemName: "xmark.circle"), for: .normal)
        button.isHidden = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.changeAdditionalButton()
        }), for: .touchUpInside)
        return button
    }()
    
    lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        return label
    }()
    
    init(type: TextFieldType, header: String?, placeHolder: String, footer: String = "") {
        self.type = type
        super.init(frame: .zero)
        if let header = header {
            headerLabel.isHidden = false
            headerLabel.text = header
        }
        footerLabel.text = footer
        textField.placeholder = placeHolder
        textField.isSecureTextEntry = type == .normal ? false : true
        setUp()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension CustomTextField {
    func setUp() {
        self.distribution = .fill
        self.axis = .vertical
        self.alignment = .fill
        
        addArrangedSubview(headerLabel)
        addArrangedSubview(contentView)
        contentView.addSubview(textField)
        contentView.addSubview(additionalButton)
        addArrangedSubview(footerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(24)
        }
        
        additionalButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(textField.snp.trailing)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(20)
        }
        
        footerLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(22)
        }
    }
}

// MARK: - Methods
extension CustomTextField {
    private func changeAdditionalButton() {
        switch type {
        case .normal:
            textField.text = ""
        case .password:
            textField.isSecureTextEntry.toggle()
            if textField.isSecureTextEntry {
                UIView.animate(withDuration: 0.1) {
                    self.additionalButton.setImage(UIImage(systemName: "eye"), for: .normal)
                }
            } else {
                UIView.animate(withDuration: 0.1) {
                    self.additionalButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                }
            }
        }
    }
    
    private func setAdditional(text: String) {
        additionalButton.isHidden = text == "" ? true : false
    }
}

