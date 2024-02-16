//
//  Common.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import UIKit

/**
 @struct Common.swift
 
 @brief 공통으로 사용하는 struct
 */
struct Common {
    
    /**
     @static
     
     @brief  시뮬레이터 여부
     
     @detail Bool값을 리턴하는 변수  true : 디바이스, false : 시뮬레이터 (read only)
     */
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
    
    /** @static TitleBar높이 (CGFloat)*/
    static let kTitleBarHeight  : CGFloat =  50
    
    /** @static http 리퀘스트 타임아웃 (초단위 Double) */
    static let kTimeOutInterval  : Double =  30
    
    /** @static 네비게이션 슬라이드 속도 (Double)*/
    static let kSlideAnimationDuration  : Double =  0.3

    /** @static statusbar높이 (CGFloat)*/
    static var kStatusbarHeight  : CGFloat {
        get {
            return UIApplication.shared.windows[0].safeAreaInsets.top
        }
    }
    
    /** @static BottomBar 높이 (CGFloat)*/
    static var kBottomHeight  : CGFloat {
        get {
            return UIApplication.shared.windows[0].safeAreaInsets.bottom
        }
    }
    
    /** @static safeArea Top  (CGFloat)*/
    static var safeAreaTopMargin: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 99
    }
    
    /** @static safeArea Left  (CGFloat)*/
    static var safeAreaLeftMargin: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.left ?? 99
    }
    
    /** @static safeArea Right  (CGFloat)*/
    static var safeAreaRightMargin: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.right ?? 99
    }
    
    /** @static safeArea Bottom  (CGFloat)*/
    static var safeAreaBottomMargin: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 99
    }
    
    /**
     @static
     
     @brief  screen 전체 사이즈
     
     @return CGRect
     */
    static func SCREEN_FULL() -> CGRect {
        return UIScreen.main.bounds
    }
    
    /**
     @static
     
     @brief  screen 넓이
     
     @return CGFloat
     */
    static func SCREEN_WIDTH() -> CGFloat {
        return Common.SCREEN_FULL().size.width
    }
    
    /**
     @static
     
     @brief  screen 높이
     
     @return CGFloat
     */
    static func SCREEN_HEIGHT() -> CGFloat {
        return Common.SCREEN_FULL().size.height
    }
    
    /**
     @static
     
     @brief  아이폰 X시리즈
     
     @return Bool
     */
    static func IS_IPHONE_X() -> Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        print(UIApplication.shared.windows[0].safeAreaInsets)
        return UIApplication.shared.windows[0].safeAreaInsets.top > 20
//        return (IS_IPHONE() && SCREEN_HEIGHT() >= 812.0)
    }
    
    static var hasSafeArea: Bool {
        guard #available(iOS 11.0, *), let topPadding = (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.top, topPadding > 24 else {
            return false
        }
        return true
    }
    
    static func IS_IPHONE_SE() -> Bool {
      
        return (IS_IPHONE() && SCREEN_WIDTH() == 320)
    }
    static func IS_IPHONE_XSMAX() -> Bool {
        
        return (IS_IPHONE() && SCREEN_HEIGHT() == 896)
    }
    static func IS_IPHONE_PLUS() -> Bool {
        
        return (IS_IPHONE() && SCREEN_HEIGHT() == 736)
    }
    
    /**
     @static
     
     @brief  아이폰 XR인지 체크
     
     @return Bool
     */
    static func IS_IPHONE_XR() -> Bool {
        if IS_IPHONE() {
            switch UIScreen.main.nativeBounds.height {
            case 1792:
                return true
            default:
                return false
            }
        }
        return false
    }
    
    
    /**
     @static
     
     @brief  아이폰 인지 체크
     
     @return Bool
     */
    static func IS_IPHONE() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
    }
    
    /**
     @static
     
     @brief  아이패드 인지 체크
     
     @return Bool
     */
    static func IS_IPAD() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
    }
}
