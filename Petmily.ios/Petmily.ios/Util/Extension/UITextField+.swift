//
//  UITextField+.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import UIKit

extension UITextField {
    var debounceTextFieldPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification,
                                             object: self)
        .compactMap { $0.object as? UITextField }
        .map { $0.text ?? "" }
        .debounce(for: 0.5, scheduler: RunLoop.main) // debounce는 일정 시간 동안 발생하는 중간 값을 제거하여 마지막 값을 방출, 주로 사용자 입력과 같은 빠른 연속적인 이벤트에서 유용하게 사용
        .filter { $0.count > 0 }
        .eraseToAnyPublisher()
    }
}
