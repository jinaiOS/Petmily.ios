import KakaoMapsSDK
import UIKit

class KakaoMapViewController: UIViewController, MapControllerDelegate {
    // 지도 컨트롤러 및 뷰 컨테이너 선언
    var mapController: KMController?
    var mapContainer: KMViewContainer?
    // 옵저버 추가 여부 및 인증 상태 플래그
    var _observerAdded: Bool = false
    var _auth: Bool = false

    init() {
        super.init(nibName: nil, bundle: nil)
        
        // KakaoMapsSDK 초기화 및 지도 컨트롤러와 뷰 컨테이너 설정
        mapContainer = KMViewContainer()
        mapController = KMController(viewContainer: mapContainer!)
        mapController!.delegate = self
        mapController?.initEngine() // 엔진 초기화
        mapController?.authenticate() // 인증 요청
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        // 객체 소멸 시 지도 렌더링 및 엔진 중지
        mapController?.stopRendering()
        mapController?.stopEngine()
        print("deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap() // 지도 설정
        setupUI() // UI 설정
    }

    func setupMap() {
        mapContainer = KMViewContainer()
        mapController = KMController(viewContainer: mapContainer!)
        mapController!.delegate = self
        mapController?.initEngine() // 엔진 초기화
        mapController?.authenticate() // 인증 요청
    }
    
    func setupUI() {
        view.addSubview(mapContainer!)
        mapContainer!.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

    /**
     @brief 지도에 뷰 추가
     */
    func addViews() {
        let defaultPosition: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001)
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", appName: "openmap", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 7)

        if mapController?.addView(mapviewInfo) == Result.OK {
            print("OK")
        }
    }
    
    /**
     @brief 컨테이너 크기 조정 시 호출되는 메서드
     
     @param size 컨테이너 사이즈
     */
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = mapController?.getView("mapview") as? KakaoMap
        // 나침반 위치 및 이벤트 핸들러 설정
        mapView?.setCompassPosition(origin: GuiAlignment(vAlign: .bottom, hAlign: .left), position: CGPoint(x: 10.0, y: 150.0))
        mapView?.addCompassTappedEventHandler(target: self, handler: KakaoMapViewController.compassTappedHanlder)
        mapView?.showCompass()
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
    }

    /**
     @brief 뷰가 소멸될 때 호출되는 메서드
     
     @param view View 객체
     */
    func viewWillDestroyed(_ view: ViewBase) {

    }
    
    /**
     @brief 앱의 활성 상태 변경 시 옵저버 추가/제거
     */
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        _observerAdded = true
    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        _observerAdded = false
    }
    
    /**
     @brief 나침반 탭 이벤트 핸들러
     
     @param 카카오맵 객체
     */
    func compassTappedHanlder(_ kakaoMap: KakaoMap) {
        print("compass tapped")
        kakaoMap.resetCameraOrientation() // 카메라 방향 리셋
    }

    /**
     @brief 앱이 비활성화 될 떄 호출되는 메서드
     */
    @objc func willResignActive() {
        mapController?.stopRendering()
    }

    /**
     @brief 앱이 다시 활성 상태가 될 떄 호출되는 메서드
     */
    @objc func didBecomeActive() {
        mapController?.startRendering()
    }
}
