//
//  MyPageViewController.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import UIKit

import SnapKit

struct TempDaily {
    var contnet: String
}

struct TempInfo {
    var title: String
    var content: String
}

class MyPageViewController: BaseViewController {
    // MARK: Properties
    private var profileData = User(id: "id1", nickName: "user1", image: "image", pet: [Pet(id: "id1", name: "단지", age: "5살", gender: "남자", breed: "시츄"), Pet(id: "id2", name: "pet2", age: "age2", gender: "gender2", breed: "breed2"), Pet(id: "id3", name: "pet3", age: "age3", gender: "gender3", breed: "breed3")])
    var dailyData: [TempDaily]?
    var infoData: [TempInfo]?
    var dailyThumbnail: UIImage?
    
    let dailyDummy = [UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"), UIImage(named: "test1"),]
                                                       
    let collectionViewHeight = ((UIScreen.main.bounds.size.width - 25) / 3)
    lazy var totalHeight = (self.collectionViewHeight + 2) * CGFloat(self.dailyDummy.count.calculateCount() / 3)
    
    // MARK: Components
    lazy var myPageProfileView = MyPageProfileView()
    
    lazy var myPagePostView: MyPagePostView = {
        let view = MyPagePostView()
        view.dailyCollectionView.register(MyPageCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCollectionViewCell.identifier)
        view.infoCollectionView.register(MyPageInfoCell.self, forCellWithReuseIdentifier: MyPageInfoCell.identifier)
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let contentView = UIView()
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "myPageBackground")
        return view
    }()
    
    private var currentProfileIndex = 0 {
        didSet {
            setUpProfile()
        }
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpProfile()
    }
    
    @objc func tappedEditButton() {
        let vc = MyPageSettingViewController()
        navigationPushController(viewController: vc, animated: true)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        myPagePostView.shouldHideFirstView = segment.selectedSegmentIndex != 0
        if segment.selectedSegmentIndex == 0 {
            myPagePostView.dailyCollectionView.snp.remakeConstraints {
                $0.height.equalTo(totalHeight)
            }
        } else {
            myPagePostView.infoCollectionView.snp.remakeConstraints() {
                let collectionViewHeight: CGFloat = 152
                let totalHeight = (collectionViewHeight + 10) * CGFloat(10)
                $0.height.equalTo(totalHeight)
            }
            myPagePostView.infoCollectionView.collectionViewLayout.invalidateLayout()
            myPagePostView.infoCollectionView.layoutIfNeeded()
        }
     }
}

// MARK: Setup
private extension MyPageViewController {
    func setUp() {
        myPageProfileView.profileTextField.delegate = self
        myPageProfileView.pickerView.delegate = self
        myPageProfileView.pickerView.dataSource = self
        myPagePostView.dailyCollectionView.delegate = self
        myPagePostView.dailyCollectionView.dataSource = self
        myPagePostView.infoCollectionView.delegate = self
        myPagePostView.infoCollectionView.dataSource = self
        
        setUpConstraints()
        setUpSegmentedControl()
        setUpActions()
    }
    
    func setUpConstraints() {
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(myPageProfileView)
        contentView.addSubview(myPagePostView)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset((65 + 16))
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            
        }
        
        myPageProfileView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        myPagePostView.snp.makeConstraints {
            $0.top.equalTo(myPageProfileView.snp.bottom)
            $0.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        myPagePostView.infoCollectionView.snp.makeConstraints {
            $0.height.equalTo(totalHeight)
        }
    }
    
    private func setUpProfile() {
        myPageProfileView.profileTextField.text = profileData.pet?.first?.name ?? "프로필 없음"
        myPageProfileView.userNameLabel.text = profileData.pet?[currentProfileIndex].name
        myPageProfileView.petAgeText.text = profileData.pet?[currentProfileIndex].age
        myPageProfileView.petGenderText.text = profileData.pet?[currentProfileIndex].gender
        myPageProfileView.petBreedText.text = profileData.pet?[currentProfileIndex].breed
    }
    
    private func setUpActions() {
        myPageProfileView.editProfileButton.addTarget(self, action: #selector(tappedEditButton), for: .touchUpInside)
    }
    
    func setUpProfileImage() {
        if let url = profileData.image {
            if let url = URL(string: url) {
                myPageProfileView.profileImage.load(url: url)
            }
        }
    }

    func setUpSegmentedControl() {
        myPagePostView.postSegmentControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
    }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myPagePostView.dailyCollectionView {
            return dailyDummy.count
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if myPagePostView.postSegmentControl.selectedSegmentIndex != 1 {
            let cell = myPagePostView.dailyCollectionView.dequeueReusableCell(withReuseIdentifier: MyPageCollectionViewCell.identifier, for: indexPath) as! MyPageCollectionViewCell
            cell.collectionViewImage.image = dailyDummy[indexPath.row]
            return cell
        } else {
            let cell = myPagePostView.infoCollectionView.dequeueReusableCell(withReuseIdentifier: MyPageInfoCell.identifier, for: indexPath) as! MyPageInfoCell
            cell.configure(title: "제목", description: "내용", writer: "작성자", tag: "애완동물 & 자유로운", image: UIImage(named: "sample1"))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if myPagePostView.postSegmentControl.selectedSegmentIndex != 1  {
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = (collectionViewWidth - 5) / 3
            let cellHeight = cellWidth
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = collectionViewWidth - 10
            let cellHeight: CGFloat = 152
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
}

extension MyPageViewController: UIPickerViewDataSource, UIPickerViewDelegate {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return profileData.pet?.count ?? 0
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return profileData.pet?[row].name
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.currentProfileIndex = row
            myPageProfileView.profileTextField.text = profileData.pet?[row].name
        }
}

extension MyPageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return false
        }
}

extension Int {
    func calculateCount() -> Int {
        switch self % 3 {
        case 0:
            return self
        case 1:
            return self + 2
        default:
            return self + 1
        }
    }
}
