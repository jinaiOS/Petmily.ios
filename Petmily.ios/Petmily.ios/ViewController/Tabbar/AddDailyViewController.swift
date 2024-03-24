//
//  AddDailyViewController.swift
//  Petmily.ios
//
//  Created by 김지은 on 3/2/24.
//

import UIKit
import AVFoundation
import Combine

class AddDailyViewController: BaseViewController {
    private let addDailyView = AddDailyView()
    
    var videoURL: URL?
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    private var vm = AddDailyViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(addDailyView)
        
        addDailyView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidLoad() {
        buttonInit()
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playVideo(with: videoURL!)
    }
    
    private func buttonInit() {
        addDailyView.btnExplain.addTarget(self, action: #selector(writeExplainButtonPressed), for: .touchUpInside)
        addDailyView.btnNext.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        addDailyView.btnBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    
}

extension AddDailyViewController {
    func playVideo(with url: URL) {
        playerLayer?.removeFromSuperlayer()
        
        player = AVPlayer(url: url)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = addDailyView.imgVideo.bounds
        
        addDailyView.imgVideo.layer.addSublayer(playerLayer!)
        
        player?.play()
    }
    
    @objc func writeExplainButtonPressed() {
        let vc = addpageViewController()
        guard let sheet = vc.presentationController as? UISheetPresentationController else {
            return
        }
        sheet.detents = [.medium(), .large()]
        sheet.largestUndimmedDetentIdentifier = .large
        sheet.prefersGrabberVisible = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func nextButtonPressed() {
        let alertController = UIAlertController(title: "업로드 확인", message: "정말 업로드 하시겠습니까?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: {_ in
            Task {
                await self.createDaily()
            }
        }))
        alertController.addAction(UIAlertAction(title: "취소", style: .destructive, handler: {_ in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func backButtonPressed() {
        navigationPopViewController(animated: true) { }
    }
}
extension AddDailyViewController {
    private func bindViewModel() {
        vm.$isCreateSuccess
            .receive(on: RunLoop.main)
            .sink { isSuccess in
                if isSuccess {
                    self.navigationPopViewController(animated: true) { }
                }
            }
            .store(in: &cancellables)
        
        vm.$errorMessage
            .receive(on: RunLoop.main)
            .sink { errorMessage in
                
            }
            .store(in: &cancellables)
    }
    
    private func createDaily() async {
        let breed = Breed.cat
        let data = ShareDaily(title: "hi everyone", content: "eeee", author: "me", hashtag: ["cute", "cat"], profileUrl: "", contentVideoUrl: videoURL!)
        
        await vm.createShareDaily(breed: breed, data: data)
    }
}
