//
//  StackFactory.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import UIKit

struct StackFactory {
    static func makeStackView(axis: NSLayoutConstraint.Axis = .vertical,
                              alignment: UIStackView.Alignment = .fill,
                              distribution: UIStackView.Distribution = .fill,
                              spacing: CGFloat = 0,
                              subViews: [UIView]) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.alignment = alignment
        stack.distribution = distribution
        stack.spacing = spacing
        
        subViews.forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }
}
