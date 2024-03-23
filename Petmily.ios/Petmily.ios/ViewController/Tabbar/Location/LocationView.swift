import UIKit
import SnapKit

class LocationView: UIView {
    var kakaoMapViewController = KakaoMapViewController()
    var onModalButtonTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupZoomButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .gray
        addSubview(kakaoMapViewController.view)
        kakaoMapViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // 확대/축소 버튼 설정
    func setupZoomButtons() {
        let zoomInButton: UIButton = {
            let button = UIButton()
            button.setTitle("+", for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
            button.backgroundColor = .white
            button.clipsToBounds = true
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.borderWidth = 0.5
            button.addTarget(kakaoMapViewController, action: #selector(kakaoMapViewController.zoomInAction), for: .touchUpInside)
            return button
        }()

        let zoomOutButton: UIButton = {
            let button = UIButton()
            button.setTitle("-", for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
            button.backgroundColor = .white
            button.clipsToBounds = true
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.borderWidth = 0.5
            button.addTarget(kakaoMapViewController, action: #selector(kakaoMapViewController.zoomOutAction), for: .touchUpInside)
            return button
        }()
        
        let modalButton: UIButton = {
            let button = UIButton()
            button.setTitle("modal", for: .normal)
            button.backgroundColor = .green
            button.addTarget(self, action: #selector(modalButtonTapped), for: .touchUpInside)
            return button
        }()

        // 스택뷰 생성 및 설정
        let stackView = UIStackView(arrangedSubviews: [zoomInButton, zoomOutButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        // 스택뷰를 뷰에 추가
        addSubview(stackView)
        addSubview(modalButton)

        // SnapKit을 사용하여 스택뷰의 위치와 크기를 정의
        stackView.snp.makeConstraints {
            $0.right.equalTo(-20)
            $0.bottom.equalTo(-200)
            $0.width.equalTo(40)
            $0.height.equalTo(80) // 두 버튼의 높이와 간격을 고려한 총 높이
        }
        
        modalButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc func modalButtonTapped() {
        onModalButtonTap?()
    }
}
