//
//  SelectPhoto.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import UIKit

struct SelectPhoto: Hashable {
    let photoID: UUID
    let image: UIImage
    
    init(image: UIImage) {
        self.photoID = UUID()
        self.image = image
    }
}
