//
//  UIView+Extension.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import UIKit

/**
 @extension UIView
 */

/** @brief UIView: custom class to UIDesignable / xib에서 확인가능 */
@IBDesignable
class UIDesignable: UIView {
}
extension UIView {
    
    /** @brief XIb에서 Radius를 설정할수 있도록 한다.*/
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
            return layer.cornerRadius
        }
        set {
            if newValue == 9999 {
                layer.cornerRadius = self.frame.height / 2
            } else {
                layer.cornerRadius = newValue
            }
//            layer.masksToBounds = newValue > 0
        }
    }
    
    /** @brief XIb에서 borderWidth를 설정할수 있도록 한다.*/
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /** @brief XIb에서 borderColor를 설정할수 있도록 한다.*/
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /** @brief XIb에서 shadowRadius를 설정할수 있도록 한다.*/
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /** @brief XIb에서 shadowColor를 설정할수 있도록 한다.*/
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
            
        }
    }
    
    /** @brief XIb에서 shadowOpacity를 설정할수 있도록 한다.*/
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            
        }
    }
    
    /** @brief XIb에서 shadowOffset를 설정할수 있도록 한다.*/
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            
        }
    }

    
}

@IBDesignable
class CardShadowView: UIView {
  
    let containerView = UIView()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        layoutView()
    }

    func layoutView() {
      
      // set the shadow of the view's layer
      layer.backgroundColor = UIColor.clear.cgColor
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0, height: 3.0)
      layer.shadowOpacity = 0.16
      layer.shadowRadius = 6.0
        
      // set the cornerRadius of the containerView's layer
      containerView.layer.cornerRadius = 10
      containerView.layer.masksToBounds = true
        self.layer.cornerRadius = 10
      addSubview(containerView)
      
      //
      // add additional views to the containerView here
      //
      
      // add constraints
      containerView.translatesAutoresizingMaskIntoConstraints = false
      
      // pin the containerView to the edges to the view
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
      containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

