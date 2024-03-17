//
//  TabbarController.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import UIKit
import SnapKit

final class TabBarController: UIViewController {
    
    let dailyVC = DailyViewController()
    let infoVC = InfoViewController()
    // 기존 펫스티벌 뷰컨트롤러 주석 처리
    let AddDailyVC = AddDailyViewController()
    let locationVC = LocationViewController()
    let mypageVC = MyPageViewController()
    private let tabBarView = TabBarView(frame: .zero)
    
    let imagePickerController = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setLayout()
        configTabBarBtn()
    }
}

private extension TabBarController {
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(dailyVC.view)
        changeTintColor(buttonType: tabBarView.dailyBtn)
    }
    
    func setLayout() {
        view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(65)
        }
    }
    
    @objc func didTappedDaily() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        view.addSubview(dailyVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.dailyBtn)
    }
    
    @objc func didTappedInfo() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        view.addSubview(infoVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.infoBtn)
    }
    
    @objc func didTappedAdd() {
        videoPicker()
    }
    
    @objc func didTappedLocation() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        view.addSubview(locationVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.locationBtn)
        
//        locationVC.authenticationSucceeded()
    }
    
    @objc func didTappedMyPage() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        view.addSubview(mypageVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.myBtn)
    }
    
    func configTabBarBtn() {
        tabBarView.dailyBtn.addTarget(self, action: #selector(didTappedDaily), for: .touchUpInside)
        tabBarView.infoBtn.addTarget(self, action: #selector(didTappedInfo), for: .touchUpInside)
        tabBarView.addBtn.addTarget(self, action: #selector(didTappedAdd), for: .touchUpInside)
        tabBarView.locationBtn.addTarget(self, action: #selector(didTappedLocation), for: .touchUpInside)
        tabBarView.myBtn.addTarget(self, action: #selector(didTappedMyPage), for: .touchUpInside)
    }
    
    func changeTintColor(buttonType: UIButton) {
        tabBarView.dailyBtn.isSelected = (buttonType == tabBarView.dailyBtn)
        tabBarView.infoBtn.isSelected = (buttonType == tabBarView.infoBtn)
        tabBarView.locationBtn.isSelected = (buttonType == tabBarView.locationBtn)
        tabBarView.myBtn.isSelected = (buttonType == tabBarView.myBtn)
    }
    
    private func videoPicker() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension TabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        CommonUtil.print(output: info)
        
        if let videoURL = info[.mediaURL] as? URL {
            AddDailyVC.modalPresentationStyle = .fullScreen
            AddDailyVC.videoURL = videoURL
            AppDelegate.applicationDelegate().navigationController?.pushViewController(AddDailyVC, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
