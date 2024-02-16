//
//  CommonUtil.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import UIKit
import os.log
import AVKit

/**
 @struct CommonUtil.swift
 
 @brief 공통으로 사용하는 Util을 모아 놓은 struct
 */
struct CommonUtil {
    
    
    /// os_log로 볼지 말지 결정 (os로그는 adhoc버전에서도 로그를 볼수 있다.)
    private static let logTypeIsOSLog = false
    
    private static let FORCE_LOG = false //강제로 로그를 볼떄 사용. AdHoc에서 로그 확인하고 싶을떄 true로 값을 변경해서 로그를 확인한다.
    
    /**
     @static
     
     @brief Debug모드 로그와 Release모드의 로그를 다르게 노출
     */
    static func print(output: Any = "", function: String = #function, file: String = #file, line: Int = #line) {
        
        if FORCE_LOG {
            if let output = output as? CVarArg {
                NSLog("%@ ----- %i Line ----- %@ \n%@", file,line,function,output)
            }
        } else {
#if DEBUG
            var filename: NSString = file as NSString
            filename = filename.lastPathComponent as NSString
            
            if CommonUtil.logTypeIsOSLog {
                DispatchQueue.main.async {
                    let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Petmily")
                    if #available(iOS 12.0, *) {
                        if let output = output as? CVarArg {
                            os_log(.default, log: log,"%@ ----- %i Line ----- %@ %@", filename,line,function,output)
                        }
                    } else {
                        Swift.print("\(filename) ----- \(line) Line ----- \(function) ----- \(output)")
                    }
                }
            } else {
                Swift.print("Petmily : \(filename) ----- \(line) Line ----- \(function) ----- \(output)")
            }
            
            
#else
            DispatchQueue.main.async {
                if #available(iOS 12.0, *) {
                    os_log("", "")
                } else {
                    Swift.print("")
                }
            }
#endif
        }
    }
    
    
    /**
     @static
     
     @brief 어플리케이션 외부에서 url주소를 연다
     
     @param [urlString] url주소
     
     */
    static func applicationOpenURL (urlString : String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        //버전에 따라 다르게 처리
        if #available(iOS 10.0, *)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else
        {
            UIApplication.shared.openURL(url)
        }
    }
    
    /**
     @static
     
     @brief AppStore 열기
     
     @param [appId] App ID
     
     */
    static func openAppStore(appId: String) {
        let url = "itms-apps://itunes.apple.com/app/" + appId;
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    /**
     @brief 아이디 유효성 체크
     
     @param stringValue : 체크할 문자열
     
     @return Bool
     */
    static func isValidId(id: String) -> Bool {
        
        let expression1 = "[a-zA-Z0-9]{4,12}"
        if !NSPredicate(format: "SELF MATCHES %@", expression1).evaluate(with: id){
            return false
            
        }
        return true
    }
    
    /**
     @static
     
     @brief 비밀번호 유효성 체크
     
     @param [pw] 비밀번호
     
     */
    static func isValidPassWord(pw : String) -> String {
        var errorStr = ""
        let english = ".*[a-zA-Z]+.*"
        let number = ".*[0-9]+.*"
        let specialCharacters = ".*[~!@\\#$%^&*\\()\\-=+_\'\\\"]+.*"
        
        if (pw as NSString).range(of: english, options: .regularExpression).location == NSNotFound {
            errorStr = "비밀번호는 적어도 한 개의 영문을 포함하여야 합니다."
        } else {
            var validLv = 0
            if (pw as NSString).range(of: number, options: .regularExpression).location != NSNotFound {
                validLv += 1
            }
            
            if (pw as NSString).range(of: specialCharacters, options: .regularExpression).location != NSNotFound {
                validLv += 1
            }
            
            // 영문만 있는 경우
            if validLv == 0 {
                errorStr = "비밀번호는 영문 숫자 특수문자 중 2개 이상 혼용해서 사용해야 합니다."
            }
            else if(validLv >= 1 && (pw.count < 10 || pw.count > 15)) {
                errorStr = "비밀번호는 영문 숫자 특수문자 중 2개 이상 혼용 시 10 ~ 15 자리로 구성해야 합니다."
            }
        }
        
        return errorStr
    }
    
    /**
     @brief 핸드폰번호 유효성 체크
     
     @param stringValue : 체크할 문자열
     
     @return Bool
     */
    static func isValidPhone(phoneNum: String) ->Bool {
        let phoneRegEx = "^01[0|1|6|7|8|9]-?([0-9]{3,4})-?([0-9]{4})$"
        let phoneValid = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneValid.evaluate(with: phoneNum)
    }
    
    /**
     @brief 비밀번호 확인 유효성 체크
     
     @param [pw] 비밀번호
     
     */
    func isValidPassWordReCheck(pw : String , rePw: String) -> Bool {
        if pw.isEmpty || rePw.isEmpty {
            return false
        }
        return pw == rePw
    }
    
    /**
     @static
     
     @brief 입력받은 질문의 갯수를 String으로 리턴
     
     @param [code] 질문 갯수 Int
     
     @return 갯수를 String으로 리턴
     
     */
    static func getFormatCode(code : Int) -> String {
        var result = "\(code)"
        if code < 10 {
            result = "0\(code)"
        }
        return result
    }
    
    /**
     @static
     
     @brief jsonData convert Dictionary
     
     @param [data] jsonString
     
     */
    static func convertJsonToDic(data : String) -> Dictionary<String, Any>? {
        if  let jsonData = data.data(using: .utf8), let dic = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers), let jsonDic = dic as? Dictionary<String, Any> {
            return jsonDic
        }
        return nil
    }
    
    static func convertJsonToDictionaryString(data : String) -> Dictionary<String, String>? {
        if  let jsonData = data.data(using: .utf8), let dic = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers), let jsonDic = dic as? Dictionary<String, String> {
            return jsonDic
        }
        return nil
    }
    /**
     @brief modal을 띄운다.
     
     @param viewController - 이동하는 ViewController를 저장하고 있다가 모달을 닫을때 사용한다.
     
     @param isSideMenuClose - 사이드메뉴를 닫고 팝업을 띄워야할지 여부  true : 메뉴를 닫고 팝업을띄운다. false : 메뉴위에 팝업을 띄운다.
     
     @param animateFlag - animation여부
     
     @param modalStyle - modal띄우려는 스타일
     
     @param completion - 함수 실행 후 처리할 closure
     */
    static func popUpPresentViewController(viewController : UIViewController, isSideMenuClose : Bool = true, animateFlag : Bool = true,  modalStyle : UIModalTransitionStyle = .coverVertical, completion : (() -> (Void))?) {
        
        let present = {
            if DataManager.sharedInstance.modalViewControllerList == nil {
                DataManager.sharedInstance.modalViewControllerList = NSMutableArray.init()
            }
            
            viewController.modalTransitionStyle = modalStyle
            viewController.modalPresentationStyle = .overFullScreen
            DispatchQueue.main.async {
                AppDelegate.applicationTopViewController()?.present(viewController, animated: animateFlag, completion: {
                    completion?()
                })
            }
            //modal로 이동한 List는 저장하고 있다가 dismiss시킬때 사용한다.
            DataManager.sharedInstance.modalViewControllerList?.add(viewController)
            
            for vc in DataManager.sharedInstance.modalViewControllerList! {
                CommonUtil.print(output: "modal List : \(vc.self))")
            }
        }
        present()
    }
    
    /**
     @brief 최상단 modal을 내린다.
     
     @param animateFlag - animation여부
     
     @param completion - 함수 실행 후 처리할 closure
     */
    static func popUpDismissViewControllerAnimated(animateFlag : Bool, completion : (() -> (Void))?) {
        //modal을 사용한 ViewController가 없으면 블럭함수 유무에 따라 실행한다.
        if DataManager.sharedInstance.modalViewControllerList == nil || DataManager.sharedInstance.modalViewControllerList?.count == 0 {
            completion?()
        } else {
            //마지막 Modal을 내리고 리스트에서 제거한다. 그후 블럭 유무에 따라 실행한다.
            DispatchQueue.main.async {
                (DataManager.sharedInstance.modalViewControllerList?.lastObject as! UIViewController).dismiss(animated: animateFlag) {
                    DataManager.sharedInstance.modalViewControllerList?.removeLastObject()
                    completion?()
                }
            }
        }
    }
    
    /**
     @brief modal을 모두 내린다.
     
     @param animateFlag - animation여부
     
     @param completion - 함수 실행 후 처리할 블럭
     */
    static func popUpAllDismissViewControllerAnimated(animateFlag : Bool, completion : (() -> (Void))?) {
        //modal을 사용한 ViewController가 없으면 블럭 유무에 따라 실행한다.
        if DataManager.sharedInstance.modalViewControllerList == nil || DataManager.sharedInstance.modalViewControllerList?.count == 0 {
            completion?()
            
        } else {
            //모든 Modal을 한번에 내리고 리스트를 모두 초기화 한다. 그후 블럭 유무에 따라 실행한다.
            var modalVC = (DataManager.sharedInstance.modalViewControllerList?.lastObject as! UIViewController).presentingViewController
            while (modalVC?.presentingViewController) != nil {
                modalVC = modalVC?.presentingViewController
            }
            DispatchQueue.main.async {
                modalVC?.dismiss(animated: animateFlag, completion: {
                    DataManager.sharedInstance.modalViewControllerList?.removeAllObjects()
                    completion?()
                })
            }
        }
    }
    /**
     @static
     
     @brief ActionSheet를 띄운다.
     
     @param title 제목
     
     @param message 내용
     
     @param actionTitle 액션시트 항목에 들어갈 버튼 이름 배열
     
     @param actionHandler 액션시트 항목 버튼을 눌렀을때 실행할 핸들러 배열
     */
    static func showActionsheet(title: String?, message: String?, actionTitle : [String], actionHandler : [(() -> (Void))?], cancelHandler : (() -> (Void))?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        if actionTitle.isEmpty || (actionTitle.count != actionHandler.count) {
            return
        }
        
        for index in 0..<actionTitle.count {
            let action = UIAlertAction(title: actionTitle[index], style: .default, handler: { (action) -> (Void) in
                actionHandler[index]?()
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            cancelHandler?()
        }
        cancelAction.setValue(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            AppDelegate.applicationTopViewController()?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showOneButtonAlertView(title: String, message: String) {
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        sheet.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in CommonUtil.print(output: "yes 클릭") }))
        
        DispatchQueue.main.async {
            AppDelegate.applicationTopViewController()?.present(sheet, animated: true, completion: nil)
        }
    }
}

