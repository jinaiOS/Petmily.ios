//
//  CommonHeaderView.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import UIKit

class CommonHeaderView: UIView {
    
    /** @brief Xib로 그려진 containerView */
    @IBOutlet var containerView: UIView!

    /** @brief Header Title Label*/
    @IBOutlet var titleLabel: UILabel!
  
    /** 뒤로가기 버튼*/
    @IBOutlet var backButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CommonHeaderView", owner: self, options: nil)
        containerView.layer.frame = self.bounds
        self.addSubview(containerView)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

