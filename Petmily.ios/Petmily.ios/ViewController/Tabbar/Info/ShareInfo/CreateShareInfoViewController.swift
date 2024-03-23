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
    private lazy var createShareInfoView = CreateShareInfoView(createShareInfoViewModel.readOnlyCurrentSections)
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
        setButtonTarget()
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
                Task {
                    let (needToScroll, height) = self.createShareInfoViewModel.getCollectionViewHeight()
                    if needToScroll {
                        await self.createShareInfoView.remakeConstraints(isScrollEnabled: needToScroll, height)
                        return
                    }
                    await self.createShareInfoView.remakeConstraints(height)
                }
            }.store(in: &cancellables)
        
        createShareInfoViewModel.isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                if state == true {
                    createShareInfoView.doneButton.isEnabled = true
                    return
                }
                createShareInfoView.doneButton.isEnabled = false
            }.store(in: &cancellables)
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
        headerView.addSubview(createShareInfoView.doneButton)
        
        createShareInfoView.doneButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.Size.size16)
        }
    }
    
    func setButtonTarget() {
        createShareInfoView.doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        createShareInfoView.photoButton.addTarget(self, action: #selector(didTapPhotoButton), for: .touchUpInside)
    }
}

private extension CreateShareInfoViewController {
    @objc func didTapDoneButton() {
        
    }
    
    @objc func didTapPhotoButton() {
        let image = UIImage(named: "sample")!
        createShareInfoViewModel.inputPhotoItem(photo: image)
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
                    
                case .photo(let item):
                    return setPhotoCell(collectionView, indexPath, item)
                }
            })
    }
    
    func applyItems() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        let hashtagItems = createShareInfoViewModel.collectionViewModels.hashtagItems
        let photoItems = createShareInfoViewModel.collectionViewModels.photoItems
        
        if hashtagItems.isEmpty != true {
            snapShot.appendSections([.hashtag])
            snapShot.appendItems(hashtagItems, toSection: .hashtag)
        }
        if photoItems.isEmpty != true {
            snapShot.appendSections([.photo])
            snapShot.appendItems(photoItems, toSection: .photo)
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
    
    func setPhotoCell(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ item: SelectPhoto) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCell.identifier,
            for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.setViewModel(photo: item)
        return cell
    }
}

extension CreateShareInfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        createShareInfoViewModel.removeItem(indexPath: indexPath)
    }
}

extension CreateShareInfoViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch textField {
        case createShareInfoView.hashtagTextField:
            if text.last == " " {
                createShareInfoViewModel.inputHashTagItem(hashtagStr: text)
                textField.text?.removeAll()
            }
            
        case createShareInfoView.titleTextField:
            createShareInfoViewModel.titleStr = text
            
        default: return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        
        switch textField {
        case createShareInfoView.hashtagTextField:
            if text.isEmpty != true {
                createShareInfoViewModel.inputHashTagItem(hashtagStr: text)
                textField.text?.removeAll()
            }
            
        case createShareInfoView.titleTextField:
            createShareInfoViewModel.titleStr = text
            
        default: break
        }
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
