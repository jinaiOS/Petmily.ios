//
//  LocationViewController.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/25/24.
//

import Foundation
import KakaoMapsSDK
import SnapKit

class LocationViewController: UIViewController, MapControllerDelegate {
    
    var mapContainer: KMViewContainer?
    var mapController: KMController?

    var _observerAdded = false
    var _auth = false
    var _appear = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SDKInitializer.InitSDK(appKey: "b5bda1f38916d810374f30b982fcc51a")
        setupMapView()
        setupMapController()
        setupZoomButtons()
        createLabelLayer()
        createPoiStyle()
        createPois()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Map Container Frame: \(mapContainer?.frame ?? .zero)")
    }
    
    func setupMapView() {
        // KMViewContainer 인스턴스 생성 및 뷰에 추가
        mapContainer = KMViewContainer()
        view.addSubview(mapContainer!)
        view.backgroundColor = .gray

        // mapContainer에 대한 제약조건 설정
        mapContainer!.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

    func setupMapController() {
        // KMController 인스턴스 생성 및 초기화
        guard let mapContainer = mapContainer else { return }
        mapController = KMController(viewContainer: mapContainer)
        mapController?.delegate = self

        // 엔진 및 렌더링 시작
        mapController?.initEngine()
    }


    override func viewWillAppear(_ animated: Bool) {
        addObservers()
        _appear = true
        if mapController?.engineStarted == false {
            mapController?.startEngine()
            print("엔진 시작")
        }
        
        if mapController?.rendering == false {
            mapController?.startRendering()
            print("렌더링 시작")
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        _appear = false
        mapController?.stopRendering()  //렌더링 중지.
        print("렌더링 중지")
    }

    override func viewDidDisappear(_ animated: Bool) {
        removeObservers()
        mapController?.stopEngine()     //엔진 정지. 추가되었던 ViewBase들이 삭제된다.
        print("엔진 정지")
    }
    
    // 인증 성공시 delegate 호출.
    func authenticationSucceeded() {
        // 일반적으로 내부적으로 인증과정 진행하여 성공한 경우 별도의 작업은 필요하지 않으나,
        // 네트워크 실패와 같은 이슈로 인증실패하여 인증을 재시도한 경우, 성공한 후 정지된 엔진을 다시 시작할 수 있다.
        if _auth == false {
            _auth = true
        }
        
        if mapController?.engineStarted == false {
            mapController?.startEngine()    //엔진 시작 및 렌더링 준비. 준비가 끝나면 MapControllerDelegate의 addViews 가 호출된다.
            mapController?.startRendering() //렌더링 시작.
        }
    }
    
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        print("addView 성공")
    }
    
    // 인증 실패시 호출.
    func authenticationFailed(_ errorCode: Int, desc: String) {
        print("error code: \(errorCode)")
        print("desc: \(desc)")
        _auth = false
        switch errorCode {
        case 400:
            showToast(self.view, message: "지도 종료(API인증 파라미터 오류)")
            break;
        case 401:
            showToast(self.view, message: "지도 종료(API인증 키 오류)")
            break;
        case 403:
            showToast(self.view, message: "지도 종료(API인증 권한 오류)")
            break;
        case 429:
            showToast(self.view, message: "지도 종료(API 사용쿼터 초과)")
            break;
        case 499:
            showToast(self.view, message: "지도 종료(네트워크 오류) 5초 후 재시도..")
            
            // 인증 실패 delegate 호출 이후 5초뒤에 재인증 시도..
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                print("retry auth...")
                
                self.mapController?.authenticate()
            }
            break;
        default:
            break;
        }
    }
    
    // Poi생성을 위한 LabelLayer 생성
        func createLabelLayer() {
            let view = mapController?.getView("mapview") as? KakaoMap
            let manager = view?.getLabelManager()
            let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 0)
            let _ = manager?.addLabelLayer(option: layerOption)
        }
        
        // Poi 표시 스타일 생성
        func createPoiStyle() {
            let view = mapController?.getView("mapview") as? KakaoMap
            let manager = view?.getLabelManager()
            
            // PoiBadge는 스타일에도 추가될 수 있다. 이렇게 추가된 Badge는 해당 스타일이 적용될 때 함께 그려진다.
            let iconStyle = PoiIconStyle(symbol: UIImage(named: "marker.png"))
        
            // 5~11, 12~21 에 표출될 스타일을 지정한다.
            let poiStyle = PoiStyle(styleID: "PerLevelStyle", styles: [
                PerLevelPoiStyle(iconStyle: iconStyle, level: 0)
            ])
            manager?.addPoiStyle(poiStyle)
        }
        
        func createPois() {
            let view = mapController?.getView("mapview") as? KakaoMap
            let manager = view?.getLabelManager()
            let layer = manager?.getLabelLayer(layerID: "PoiLayer")
            let poiOption = PoiOptions(styleID: "PerLevelStyle")
            poiOption.rank = 0
            
            let poi1 = layer?.addPoi(option:poiOption, at: MapPoint(longitude: 127.108678, latitude: 37.402001))
            // Poi 개별 Badge추가. 즉, 아래에서 생성된 Poi는 Style에 빌트인되어있는 badge와, Poi가 개별적으로 가지고 있는 Badge를 갖게 된다.
            poi1?.show()
        }
    
    func addViews() {
        //여기에서 그릴 View(KakaoMap, Roadview)들을 추가한다.
        let defaultPosition: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001)
        //지도(KakaoMap)를 그리기 위한 viewInfo를 생성
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 7)
        
        //KakaoMap 추가.
        if mapController?.addView(mapviewInfo) != nil {
            print("OK") //추가 성공. 성공시 추가적으로 수행할 작업을 진행한다.
        }
    }
    
    //Container 뷰가 리사이즈 되었을때 호출된다. 변경된 크기에 맞게 ViewBase들의 크기를 조절할 필요가 있는 경우 여기에서 수행한다.
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = mapController?.getView("mapview") as? KakaoMap
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)   //지도뷰의 크기를 리사이즈된 크기로 지정한다.
    }
    
    func viewWillDestroyed(_ view: ViewBase) {
        
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    
        _observerAdded = true
    }
     
    func removeObservers(){
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)

        _observerAdded = false
    }

    @objc func willResignActive(){
        mapController?.stopRendering()  //뷰가 inactive 상태로 전환되는 경우 렌더링 중인 경우 렌더링을 중단.
    }

    @objc func didBecomeActive(){
        mapController?.startRendering() //뷰가 active 상태가 되면 렌더링 시작. 엔진은 미리 시작된 상태여야 함.
    }
    
    func showToast(_ view: UIView, message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center;
        view.addSubview(toastLabel)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        UIView.animate(withDuration: 0.4,
                       delay: duration - 0.4,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                                        toastLabel.alpha = 0.0
                                    },
                       completion: { (finished) in
                                        toastLabel.removeFromSuperview()
                                    })
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
            button.addTarget(self, action: #selector(zoomInAction), for: .touchUpInside)
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
            button.addTarget(self, action: #selector(zoomOutAction), for: .touchUpInside)
            return button
        }()

        // 스택뷰 생성 및 설정
        let stackView = UIStackView(arrangedSubviews: [zoomInButton, zoomOutButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        // 스택뷰를 뷰에 추가
        view.addSubview(stackView)

        // SnapKit을 사용하여 스택뷰의 위치와 크기를 정의
        stackView.snp.makeConstraints {
            $0.right.equalTo(-20)
            $0.bottom.equalTo(-200)
            $0.width.equalTo(40)
            $0.height.equalTo(80) // 두 버튼의 높이와 간격을 고려한 총 높이
        }
    }
    
    func getScreenCenter() -> CGPoint {
        // UIScreen.main.bounds를 통해 화면의 전체 크기를 얻습니다.
        let screenSize = UIScreen.main.bounds
        // 화면의 너비와 높이의 절반을 사용하여 중앙 좌표를 계산합니다.
        let centerX = screenSize.width / 2
        let centerY = screenSize.height / 2

        // 중앙 좌표를 CGPoint 객체로 반환합니다.
        return CGPoint(x: centerX, y: centerY)
    }


    // 확대 버튼 액션
    @objc func zoomInAction() {
        guard let mapView = mapController?.getView("mapview") as? KakaoMap else { return }
        let zoomLevel = mapView.zoomLevel + 1 // 현재 줌 레벨에서 1 증가
        let cameraUpdate = CameraUpdate.make(target: mapView.getPosition(getScreenCenter()), zoomLevel: zoomLevel, mapView: mapView)
        mapView.animateCamera(cameraUpdate: cameraUpdate, options: CameraAnimationOptions(autoElevation: false, consecutive: true, durationInMillis: 200))
    }

    // 축소 버튼 액션
    @objc func zoomOutAction() {
        guard let mapView = mapController?.getView("mapview") as? KakaoMap else { return }
        let zoomLevel = mapView.zoomLevel - 1 // 현재 줌 레벨에서 1 감소
        let cameraUpdate = CameraUpdate.make(target: mapView.getPosition(getScreenCenter()), zoomLevel: zoomLevel, mapView: mapView)
        mapView.animateCamera(cameraUpdate: cameraUpdate, options: CameraAnimationOptions(autoElevation: false, consecutive: true, durationInMillis: 200))
    }
}
