import KakaoMapsSDK
import UIKit

class KakaoMapViewController: UIViewController, MapControllerDelegate {
    var mapController: KMController?
    var mapContainer: KMViewContainer?
    var _observerAdded: Bool = false
    var _auth: Bool = false

    init() {
        super.init(nibName: nil, bundle: nil)
        
        // KakaoMapsSDK 초기화
        mapContainer = KMViewContainer()
        mapController = KMController(viewContainer: mapContainer!)
        mapController!.delegate = self
        mapController?.initEngine()
        mapController?.authenticate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        mapController?.stopRendering()
        mapController?.stopEngine()

        print("deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupUI()
    }

    func setupMap() {
        mapContainer = KMViewContainer()
        mapController = KMController(viewContainer: mapContainer!)
        mapController!.delegate = self
        mapController?.initEngine()
        mapController?.authenticate()
    }
    
    func setupUI() {
        view.addSubview(mapContainer!)
        
        mapContainer!.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

    func addViews() {
        let defaultPosition: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001)
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", appName: "openmap", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 7)

        if mapController?.addView(mapviewInfo) == Result.OK {
            print("OK")
        }
    }

    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = mapController?.getView("mapview") as? KakaoMap
        mapView?.setCompassPosition(origin: GuiAlignment(vAlign: .bottom, hAlign: .left), position: CGPoint(x: 10.0, y: 150.0))
        mapView?.addCompassTappedEventHandler(target: self, handler: KakaoMapViewController.compassTappedHanlder)
        mapView?.showCompass() //나침반을 표시한다.
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
    }

    func viewWillDestroyed(_ view: ViewBase) {

    }

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
    
    func compassTappedHanlder(_ kakaoMap: KakaoMap) {
        print("compass tapped")
            
        kakaoMap.resetCameraOrientation()
    }

    @objc func willResignActive() {
        mapController?.stopRendering()
    }

    @objc func didBecomeActive() {
        mapController?.startRendering()
    }
}
