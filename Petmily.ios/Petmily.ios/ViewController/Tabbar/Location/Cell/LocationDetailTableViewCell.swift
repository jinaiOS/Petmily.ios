import UIKit
import SnapKit

class LocationDetailTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let cellWidth = 300
    lazy var inset = (Int(UIScreen.main.bounds.width) - cellWidth) / 2
    var commentButtonTapped: (() -> Void)?
    
    // 더미 데이터
    private let dummyProfileImage = UIImage(named: "sample2.png")
    private let dummyUsername = "박상우"
    private let dummyPetName = "단지"
    private let dummyLocation = "인천광역시"
    private let dummyTimestamp = "3분 전"
    private let dummyCommentCount = "0"
    private let dummyRecommendCount = "0"
    
    
    // 프로필 이미지, 사용자 이름, 위치, 시간
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let petNameLabel = UILabel()
    private let locationLabel = UILabel()
    private let timestampLabel = UILabel()
    private let commentButton = UIButton()
    private let recommendButton = UIButton()
    private let commentCountLabel = UILabel()
    private let recommendCountLabel = UILabel()
    
    // 사진 컬렉션 뷰
    private var collectionView: UICollectionView!
    
    private var currentPage: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupProfile()
        setupCollectionView()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셀 설정
    private func setupCell() {
        contentView.backgroundColor = UIColor.white
    }
    
    // 프로필 설정
    private func setupProfile() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(petNameLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(timestampLabel)
        
        // 프로필 이미지 설정
        profileImageView.image = dummyProfileImage
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        
        // 사용자 이름 레이블 설정
        usernameLabel.text = dummyUsername
        usernameLabel.font = UIFont.systemFont(ofSize: 18)
        usernameLabel.textColor = UIColor.black
        
        // 펫 이름 레이블 설정
        petNameLabel.text = dummyPetName
        petNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        petNameLabel.textColor = UIColor.primary
        
        // 위치 레이블 설정
        locationLabel.text = dummyLocation
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.textColor = UIColor.lightGray
        
        // 시간 레이블 설정
        timestampLabel.text = dummyTimestamp
        timestampLabel.font = UIFont.systemFont(ofSize: 16)
        timestampLabel.textColor = UIColor.lightGray
        
        // 프로필 이미지
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(30)
            make.size.equalTo(60)
        }
        
        // 사용자 이름 레이블
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(5)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
        
        // 펫 이름 레이블
        petNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(usernameLabel.snp.centerY)
            make.left.equalTo(usernameLabel.snp.right).offset(5)
        }
        
        // 위치 레이블
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
        
        // 시간 레이블
        timestampLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationLabel.snp.centerY)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    // 버튼 및 버튼 레이블 설정
    private func setupButton() {
        contentView.addSubview(commentButton)
        contentView.addSubview(recommendButton)
        contentView.addSubview(commentCountLabel)
        contentView.addSubview(recommendCountLabel)
        
        // 추천 버튼 및 레이블 설정
        recommendButton.setImage(UIImage(named: "btn_location_recommend"), for: .normal)
        recommendCountLabel.text = dummyRecommendCount
        recommendCountLabel.font = UIFont.systemFont(ofSize: 16)
        recommendCountLabel.textColor = UIColor.white
        recommendCountLabel.backgroundColor = UIColor.clear
        
        // 댓글 버튼 및 레이블 설정
        commentButton.setImage(UIImage(named: "btn_location_comment"), for: .normal)
        commentButton.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
        commentCountLabel.text = dummyCommentCount
        commentCountLabel.font = UIFont.systemFont(ofSize: 16)
        commentCountLabel.textColor = UIColor.white
        commentCountLabel.backgroundColor = UIColor.clear
        
        // 추천 및 댓글 카운트 레이블 제약 추가
        recommendButton.snp.makeConstraints {
            $0.left.equalTo(collectionView.snp.left).offset(inset + 15)
            $0.bottom.equalTo(collectionView.snp.bottom).offset(-120)
        }
        recommendCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(recommendButton.snp.centerX)
            make.top.equalTo(recommendButton.snp.bottom).offset(5)
        }
        
        commentButton.snp.makeConstraints {
            $0.left.equalTo(recommendButton.snp.left)
            $0.top.equalTo(recommendButton.snp.bottom).offset(32)
        }
        commentCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(commentButton.snp.centerX)
            make.top.equalTo(commentButton.snp.bottom).offset(5)
        }
    }
    
    @objc func commentButtonAction() {
        commentButtonTapped?()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // 현재 스크롤 뷰의 오프셋과 뷰의 중앙점을 고려 가장 가까운 셀의 인덱스 계산
        let center = scrollView.bounds.size.width / 2
        let targetOffset = targetContentOffset.pointee.x
        let proposedCenterOffset = targetOffset + center
        
        // 가장 가까운 셀을 찾기 위한 계산
        let closestCellIndex = collectionView.indexPathForItem(at: CGPoint(x: proposedCenterOffset, y: scrollView.bounds.size.height / 2))?.row ?? 0
        let closestCellIndexPath = IndexPath(row: closestCellIndex, section: 0)
        
        // 계산된 셀의 위치로 스크롤뷰를 이동
        collectionView.scrollToItem(at: closestCellIndexPath, at: .centeredHorizontally, animated: true)
        targetContentOffset.pointee = scrollView.contentOffset
    }
    
    
    // 컬렉션 뷰 설정
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 30
        layout.itemSize = CGSize(width: cellWidth, height: 490)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(510)
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.configure(with: UIImage(named: "sample.png")!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 첫 번째 섹션의 시작과 마지막 섹션의 끝에 여백을 추가
        return UIEdgeInsets(top: 0, left: CGFloat(inset), bottom: 0, right: CGFloat(inset))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: 490)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 선택된 셀의 인덱스를 currentPage에 업데이트
        currentPage = indexPath.row
        // 선택된 셀로 스크롤
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    
}
