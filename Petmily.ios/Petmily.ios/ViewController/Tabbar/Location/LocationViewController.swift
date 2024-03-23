import UIKit

class LocationViewController: UIViewController {
    
    var locationView: LocationView!
    var kakaoMapViewController: KakaoMapViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        kakaoMapViewController = KakaoMapViewController()
        setupLocationView()
    }
    
    private func setupLocationView() {
        locationView = LocationView()
        view.addSubview(locationView)
        locationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        locationView.onModalButtonTap = { [weak self] in
            self?.modalButtonTapped()
        }
    }
    
    @objc func modalButtonTapped() {
        let locationDetailVC = LocationDetailViewController()
        self.present(locationDetailVC, animated: true, completion: nil)
    }
}
