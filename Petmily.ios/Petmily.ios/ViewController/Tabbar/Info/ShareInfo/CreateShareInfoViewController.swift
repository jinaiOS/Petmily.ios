//
//  CreateShareInfoViewController.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import SwiftUI
import UIKit

final class CreateShareInfoViewController: BaseHeaderViewController {
    private let createShareInfoView = CreateShareInfoView()
    private let createShareInfoViewModel = CreateShareInfoViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    typealias Section = CreateShareInfoSection
    typealias Item = CreateShareInfoItem
    
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setBaseHeaderView()
        setKeyboardObserver()
        setDataSource()
        bindViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
    }
    
    deinit {
        print("deinit - CreateShareInfoVC")
    }
}

private extension CreateShareInfoViewController {
    func bindViewModel() {
        createShareInfoViewModel.$collectionViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self else { return }
                applyItems()
                if items.hashtagItems.isEmpty != true {
                    Task {
                        await self.createShareInfoView.remakeHashTagConstraints(collectionHeight: Constants.Size.size30)
                    }
                    return
                }
                Task {
                    await self.createShareInfoView.remakeHashTagConstraints()
                }
            }.store(in: &cancellables)
        
        // TODO: - 수정해야 함
        createShareInfoViewModel.textFieldOutput
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                if state == true {
                    createShareInfoView.doneButton.isEnabled = true
                    return
                }
                createShareInfoView.doneButton.isEnabled = false
            }
            .store(in: &cancellables)
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
        
        createShareInfoView.collectionView.delegate = self
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

private extension CreateShareInfoViewController {
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: createShareInfoView.collectionView,
            cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
                guard let self else { return UICollectionViewCell() }
                switch itemIdentifier {
                case .hashtag(let item):
                    return setHashTagCell(collectionView, indexPath, item)
                }
            })
    }
    
    func applyItems() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        let hashtagItems = createShareInfoViewModel.collectionViewModels.hashtagItems
        
        Section.allCases.forEach {
            snapShot.appendSections([$0])
        }
        
        if hashtagItems.isEmpty != true {
            snapShot.appendItems(hashtagItems, toSection: .hashtag)
        }
        dataSource?.apply(snapShot)
    }
}

private extension CreateShareInfoViewController {
    func setHashTagCell(_ collectionView: UICollectionView,
                        _ indexPath: IndexPath,
                        _ item: String) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HashTagCell.identifier,
            for: indexPath) as? HashTagCell else { return UICollectionViewCell() }
        cell.setViewModel(hashtagStr: item)
        return cell
    }
}

extension CreateShareInfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        switch CreateShareInfoSection(rawValue: indexPath.section) {
        case .hashtag:
            createShareInfoViewModel.removeHashTag(index: indexPath.item)
            
        case .none:
            return
        }
    }
}

extension CreateShareInfoViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == createShareInfoView.hashtagTextField {
            guard let hashText = textField.text else { return }
            if hashText.last == " " {
                createShareInfoViewModel.inputHashTag(hashtagStr: hashText)
                textField.text?.removeAll()
            }
        }
        
        if textField == createShareInfoView.titleTextField {
            createShareInfoViewModel.titleStr = textField.text ?? ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let str = textField.text,
           str.isEmpty != true {
            createShareInfoViewModel.inputHashTag(hashtagStr: str)
        }
        textField.text?.removeAll()
        return true
    }
}

extension CreateShareInfoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textView.textColor = ThemeColor.label
        createShareInfoViewModel.contentStr = textView.text
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == createShareInfoViewModel.textViewPlaceholder {
            textView.text = ""
            textView.textColor = ThemeColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = createShareInfoViewModel.textViewPlaceholder
            textView.textColor = ThemeColor.lightGray
        }
    }
}

extension CreateShareInfoViewController {
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            Task {
                await createShareInfoView.remakeKeyboardConstraints(keyboardHight: keyboardHeight)
            }
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        Task {
            await createShareInfoView.remakeKeyboardConstraints()
        }
    }
}

// MARK: - Preview
struct CreateShareInfoVC_PreView: PreviewProvider {
    static var previews: some View {
        CreateShareInfoViewController().toPreview()
    }
}
