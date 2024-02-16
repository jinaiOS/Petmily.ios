//
//  BaseViewController.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import Foundation
import UIKit

/**
 @class BaseViewController.swift
 
 @brief 가장 기본이 되는 ViewController
 
 @detail 인디케이터, 통신, 스크롤뷰 Delegate, 네비게이션 gesture, 네비게이션간 이동을 포함하고 있다.
 */
class BaseViewController : UIViewController, UIGestureRecognizerDelegate {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setNeedsUpdateOfHomeIndicatorAutoHidden()
        }
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //gesture의 이벤트가 끝나도 뒤에 이벤트를 View로 전달
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // 화면에 터치 했을 때 키보드 사라짐
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /** @brief bottom home bar indicator auto hidden true */
    override var prefersHomeIndicatorAutoHidden: Bool
    {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //네비게이션 gesture는 기본적으로 사용 가능하며 상속받은 하위 ViewController에서 override viewDidAppear에서 변경하면 우선 적용된다.
        setNavigationGesture(animated: true)
        
        //쌓여있는 navigationController의 vIewcontroller를 print
        for index in 0..<AppDelegate.navigationViewControllers().count {
            CommonUtil.print(output: "controller stack count : \(index)\(AppDelegate.navigationViewControllers()[index].self)")
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        CommonUtil.print(output:"Dispose of any resources that can be recreated.")
    }
    
    /**
     @brief 네비게이션 컨트롤러 제스쳐 설정
     
     @param animated : true(제스쳐가능), false(제스쳐 불가능)
     */
    func setNavigationGesture(animated : Bool)
    {
        if animated
        {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
        else
        {
            //네비게이션 swipe 애니메이션 없음
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    /// 모달인지 확인
    /// - Returns: Bool
    var isModal: Bool {
        return self.presentingViewController?.presentedViewController == self
        || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
        || self.tabBarController?.presentingViewController is UITabBarController
    }
    
    /**
     @brief 네비게이션 이동
     
     @param viewController - 이동하려는 viewController
     
     @param animated - 애니메이션 여부
     
     @param duration - 네비게이션 이동 duration
     
     @param transitionType - 네비게이션 이동 transition type
     */
    func navigationPushController(viewController : UIViewController, animated : Bool, duration : Double = 0.3, transitionType : (CATransitionType, CATransitionSubtype) = (.push, .fromRight))
    {
        //modal이 떠있으면 modal은 삭제하고 이동한다.
        CommonUtil.popUpAllDismissViewControllerAnimated(animateFlag: animated) { () -> (Void) in
            let array = AppDelegate.navigationViewControllers()
            if  array.count > 0
            {
                CommonUtil.print(output: "navigationStack : \(array.count)")
                
                //navigation 커스터마이징
                let transition = CATransition.init()
                transition.duration = duration
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                transition.type = transitionType.0  //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
                transition.subtype = transitionType.1 //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
                AppDelegate.applicationDelegate().navigationController?.view.layer.add(transition, forKey: nil)
                AppDelegate.applicationDelegate().navigationController?.pushViewController(viewController, animated: animated)
            }
        }
    }
    /**
     @brief 네비게이션 이동
     
     @param viewControllers - 이동하려는 viewController 리스트
     
     @param animated - 애니메이션 여부
     
     @param duration - 네비게이션 이동 duration
     
     @param transitionType - 네비게이션 이동 transition type
     */
    func navigationPushController(viewControllers : [UIViewController], animated : Bool, duration : Double = 0.3, transitionType : (CATransitionType, CATransitionSubtype) = (.push, .fromRight))
    {
        //modal이 떠있으면 modal은 삭제하고 이동한다.
        CommonUtil.popUpAllDismissViewControllerAnimated(animateFlag: animated) { () -> (Void) in
            let array = AppDelegate.navigationViewControllers()
            if  array.count > 0
            {
                CommonUtil.print(output: "navigationStack : \(array.count)")
                
                //navigation 커스터마이징
                let transition = CATransition.init()
                transition.duration = duration
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                transition.type = transitionType.0  //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
                transition.subtype = transitionType.1 //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
                AppDelegate.applicationDelegate().navigationController?.view.layer.add(transition, forKey: nil)
                AppDelegate.applicationDelegate().navigationController?.setViewControllers(viewControllers, animated: animated)
            }
        }
    }
    /**
     @brief navigation의 Root로 이동한다.
     
     @param animated - 애니메이션 여부
     
     @param completion - 실행 후 적용할 closure
     */
    func navigationPopToRootViewController(animated : Bool, completion : (() -> (Void))?) {
        CommonUtil.popUpAllDismissViewControllerAnimated(animateFlag: false) { () -> (Void) in
            AppDelegate.applicationDelegate().navigationController?.popToRootViewController(animated: animated)
            completion?()
        }
    }
    
    /**
     @brief deleteCount만큼 뒤로 이동한다. 네비게이션 이동(이전단계로 이동)
     
     @param animated - 애니메이션 여부
     
     @param deleteCount - 삭제할 스택의 수 (입력하지 않으면 기본적으로 바로 앞으로 이동한다)
     
     @param completion - 실행 후 적용할 closure
     */
    func navigationPopViewController(animated : Bool, deleteCount : Int = 1, completion : (() -> (Void))?)
    {
        let array = AppDelegate.navigationViewControllers()
        
        if (array.count - deleteCount) <= 1
        {
            //쌓여있는 스택의 수보다 삭제하려는 수가 많으면 메인으로 이동한다.
            AppDelegate.applicationDelegate().navigationController?.popToRootViewController(animated: true)
            //            self.navigationController?.popToRootViewController(animated: true)
        }
        else
        {
            //쌓여있는 스택에서 count만큼 삭제 한 viewcontroller로 이동한다.
            var mArr = Array<UIViewController>()
            for index in 0..<array.count
            {
                if array.count - deleteCount == index
                {
                    break
                }
                mArr.append(array[index])
            }
            
            if mArr.count > 0
            {
                AppDelegate.applicationDelegate().navigationController?.popToViewController(mArr.last!, animated: true)
            }
        }
    }
}

/**
 @extension BaseViewController : UIScrollViewDelegate
 */
extension BaseViewController : UIScrollViewDelegate {
    //MARK:- UIScrollView Delegate
    /**
     @brief 스크롤 될때 호출되는 호출되는 delegate
     
     @param scrollView - 스크롤뷰 객체
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    /**
     @brief 드래그가 시작되었을때 호출되는 delegate
     
     @param scrollView - 스크롤뷰 객체
     */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    /**
     @brief 드래그가 끝날때 호출되는 delegate
     
     @param scrollView - 스크롤뷰 객체
     
     @param decelerate - 스크롤 애니메이션이 계속될지 여부(순간가속도 등)
     */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    
    /**
     @brief 가속에 의한 애니메이션이 시작될때 호출되는 delegate
     
     @param scrollView - 스크롤뷰 객체
     */
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    }
    
    /**
     @brief 가속에 의한 애니메이션이 끝날때 호출되는 delegate
     
     @param scrollView - 스크롤뷰 객체
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
}

