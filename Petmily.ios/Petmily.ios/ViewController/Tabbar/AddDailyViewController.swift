//
//  AddDailyViewController.swift
//  Petmily.ios
//
//  Created by 김지은 on 3/2/24.
//

import UIKit

class AddDailyViewController: UIViewController {
    private let addDailyView = AddDailyView()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(addDailyView)
        
        addDailyView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidLoad() {
        buttonInit()
    }
    
    private func buttonInit() {
        addDailyView.btnExplain.addTarget(self, action: #selector(writeExplainButtonPressed), for: .touchUpInside)
        addDailyView.btnNext.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
}

extension AddDailyViewController {
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
            AppDelegate.applicationDelegate().navigationController?.popViewController(animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "취소", style: .destructive, handler: {_ in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
