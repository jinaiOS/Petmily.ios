//
//  SocialButtonType.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

enum SocialButtonType {
    case like(LikeBtnState)
    case comment
    
    enum LikeBtnState {
        case unlike
        case like
    }
}
