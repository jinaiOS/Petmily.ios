//
//  DailyView.swift
//  Petmily.ios
//
//  Created by 김지은 on 2/17/24.
//

import UIKit
import SnapKit

class DailyView: UIView {
    /** @brief 펫스티벌 헤더 label */
    lazy var lblHeader: UILabel = {
       let label = UILabel()
        label.text = "펫스티벌"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    /** @brief main collectionview */
    lazy var cvMain: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
               
       let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(DailyCollectionViewCell.self, forCellWithReuseIdentifier: DailyCollectionViewCell.identifier)
        collectionview.isPagingEnabled = true
        return collectionview
    }()
    /** @brief buttons stackview */
    lazy var stvButtons: UIStackView = {
       let stackview = UIStackView()
        stackview.distribution = .fillEqually
        stackview.axis = .vertical
        [btnLike, btnApply, btnMore].forEach { stackview.addArrangedSubview($0) }
        return stackview
    }()
    /** @brief 좋아요 button */
    lazy var btnLike: UIButton = {
       let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .top
        config.image = UIImage(named: "btn_unlike")
        config.title = "0"
        config.imagePadding = 5
        config.baseForegroundColor = .white
        button.contentVerticalAlignment = .bottom
        button.tintColor = .clear
        button.configuration = config
        
        /// select handler
        let likeImg = UIImage(named: "btn_like")?.resize(newWidth: 40)
        
        button.configurationUpdateHandler = { button in
            switch button.state {
            case .selected:
                config.image = likeImg
                config.title = "1"
            default:
                config.image = UIImage(named: "btn_unlike")
                config.title = "0"
            }
            button.configuration = config
        }
        return button
    }()
    /** @brief 댓글 button */
    lazy var btnApply: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btn_apply"), for: .normal)
        button.setTitle("0", for: .normal)
        return button
    }()
    /** @brief 더보기 button */
    lazy var btnMore: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btn_more"), for: .normal)
        return button
    }()
    /** @brief 내용 stackview */
    lazy var stvContent: UIStackView = {
       let stackview = UIStackView()
        stackview.axis = .vertical
        [vProfile, vLocationTag].forEach { stackview.addArrangedSubview($0) }
        return stackview
    }()
    /** @brief 프로필 view */
    lazy var vProfile: UIView = {
       let view = UIView()
        [imgProfile, lblProfile, lblPetName, lblPetType, lblContent].forEach { view.addSubview($0) }
        return view
    }()
    /** @brief 프로필 이미지 imageview */
    lazy var imgProfile: UIImageView = {
       let imageview = UIImageView()
        imageview.cornerRadius = imageview.frame.width
        return imageview
    }()
    /** @brief 사용자 이름 label */
    lazy var lblProfile: UILabel = {
       let label = UILabel()
        label.text = "상우네"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    /** @brief 펫 이름 label */
    lazy var lblPetName: UILabel = {
       let label = UILabel()
        label.text = "단지"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .primary
        return label
    }()
    /** @brief 펫 종류 label */
    lazy var lblPetType: UILabel = {
       let label = UILabel()
        label.text = "멍뭉이"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    /** @brief 내용 label */
    lazy var lblContent: UILabel = {
       let label = UILabel()
        label.text = "이쁘죠? 귀엽죠? 못 참겠죠?"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    /** @brief 위치, 해시태그 view */
    lazy var vLocationTag: UIView = {
       let view = UIView()
        [vLocation, vTag].forEach { view.addSubview($0) }
        return view
    }()
    /** @brief 위치 view */
    lazy var vLocation: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        view.addSubview(lblLocation)
        view.cornerRadius = 11
        return view
    }()
    /** @brief 위치 label */
    lazy var lblLocation: UILabel = {
       let label = UILabel()
        label.text = "위치 - 부천"
        label.font = .systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 1)
        return label
    }()
    /** @brief 해시태그 view */
    lazy var vTag: UIView = {
       let view = UIView()
        view.backgroundColor = .primary
        view.addSubview(lblTag)
        view.cornerRadius = 11
        return view
    }()
    /** @brief 해시태그 label */
    lazy var lblTag: UILabel = {
       let label = UILabel()
        label.text = "#태그"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [cvMain, lblHeader, stvButtons, stvContent].forEach { addSubview($0) }
        
        if !Common.IS_IPHONE_SE() {
            lblHeader.snp.makeConstraints {
                $0.top.equalToSuperview().inset(51)
                $0.leading.equalToSuperview().inset(15)
            }
            
            stvContent.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(15)
                $0.bottom.equalToSuperview().inset(145)
            }
        } else {
            lblHeader.snp.makeConstraints {
                $0.top.equalToSuperview().inset(31)
                $0.leading.equalToSuperview().inset(15)
            }
            
            stvContent.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(15)
                $0.bottom.equalToSuperview().inset(125)
            }
        }
        
        cvMain.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        btnLike.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        stvButtons.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(160)
        }
        
        vProfile.snp.makeConstraints {
            $0.height.equalTo(98)
        }
        
        imgProfile.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        lblProfile.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalTo(imgProfile.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        lblPetName.snp.makeConstraints {
            $0.top.equalTo(lblProfile.snp.bottom).offset(2)
            $0.leading.equalTo(imgProfile.snp.trailing).offset(16)
        }
        
        lblPetType.snp.makeConstraints {
            $0.leading.equalTo(lblPetName.snp.trailing).offset(2)
            $0.bottom.equalTo(lblPetName)
        }
        
        lblContent.snp.makeConstraints {
            $0.top.equalTo(imgProfile.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        vLocation.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.top.bottom.leading.equalToSuperview()
        }
        
        lblLocation.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }
        
        vTag.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(vLocation.snp.trailing).offset(6)
        }
        
        lblTag.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }
    }
}
