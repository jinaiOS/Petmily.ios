//
//  UIImage+Extension.swift
//  Petmily.ios
//
//  Created by 김지은 on 2/24/24.
//

import UIKit

extension UIImage {
    
    /**
     @brief 이미지를 resize 해서 리턴
     
     @param newWidth
     
     @detail 이미지 사이즈를 rendering 하여 draw 후 이미지 리턴
     */
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale

        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        
        CommonUtil.print(output: "화면 배율: \(UIScreen.main.scale)")
        CommonUtil.print(output: "origin: \(self), resize: \(renderImage)")
        CommonUtil.print(output: renderImage)
        
        return renderImage
    }
    
}
