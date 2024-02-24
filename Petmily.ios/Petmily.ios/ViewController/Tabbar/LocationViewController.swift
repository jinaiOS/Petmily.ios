import UIKit
import SnapKit

class LocationViewController: UIViewController {
    let kakaoMapViewController = KakaoMapViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(kakaoMapViewController)
        view.addSubview(kakaoMapViewController.view)
        kakaoMapViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        // 자식 뷰 컨트롤러의 이동이 완료되었음을 알림
        kakaoMapViewController.didMove(toParent: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 앱의 활성 상태에 따라 옵저버 추가 및 지도 렌더링 상태 확인
        kakaoMapViewController.addObservers()
        if kakaoMapViewController._auth {
            // 엔진이 시작되지 않았다면 시작
            if kakaoMapViewController.mapController?.engineStarted == false {
                kakaoMapViewController.mapController?.startEngine()
            }

            // 렌더링이 시작되지 않았다면 시작
            if kakaoMapViewController.mapController?.rendering == false {
                kakaoMapViewController.mapController?.startRendering()
            }
        }
    }
    
    /**
     @brief 뷰의 서브뷰들이 레이아웃될 때 호출되는 메서드
     
     뷰의 크기가 변경될 때 KakaoMapViewController의 지도 컨테이너 크기도 조정
     */
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        kakaoMapViewController.containerDidResized(view.bounds.size)
    }

    /**
     @brief 사용자 인증이 성공했을 때 호출되는 메서드
     
     인증 성공 후 지도 엔진 시작 및 렌더링을 시작하고 지도 뷰를 추가
     */
    func authenticationSucceeded() {
        kakaoMapViewController._auth = true
        kakaoMapViewController.mapController?.startEngine()
        kakaoMapViewController.mapController?.startRendering()
        kakaoMapViewController.addViews()
    }

    /**
     @brief 사용자 인증이 실패했을 때 호출되는 메서드
     
     @param errorCode 인증 실패 에러 코드
     @param desc 인증 실패 상세 설명
     인증 실패 후 로그 출력 및 5초 후 재인증 시도
     */
    func authenticationFailed(_ errorCode: Int, desc: String) {
        print("error code: \(errorCode)")
        print("\(desc)")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            print("retry auth...")
            self.kakaoMapViewController.mapController?.authenticate()
        }
    }
}
