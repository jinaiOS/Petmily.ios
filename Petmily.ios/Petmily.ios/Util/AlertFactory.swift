//
//  AlertFactory.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import UIKit

struct AlertFactory {
    static func makeAlert(title: String? = nil,
                          message: String? = nil,
                          style: UIAlertController.Style = .alert,
                          action1Title: String,
                          action1Style: UIAlertAction.Style = .default,
                          action1Handler: (() -> Void)? = nil,
                          action2Title: String? = nil,
                          action2Style: UIAlertAction.Style? = .default,
                          action2Handler: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let firstAction = UIAlertAction(title: action1Title,
                                        style: action1Style) { _ in
            action1Handler?()
        }
        alert.addAction(firstAction)
        
        if let action2Title = action2Title,
           let action2Style = action2Style {
            let secondAction = UIAlertAction(title: action2Title,
                                             style: action2Style) { _ in
                action2Handler?()
            }
            alert.addAction(secondAction)
        }
        return alert
    }
}
