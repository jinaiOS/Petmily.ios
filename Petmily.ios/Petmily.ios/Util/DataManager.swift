//
//  DataManager.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import Foundation
import UIKit

/**
 @class DataManager.swift
 
 @brief 앱에서 사용하는 Data들을 관리하기 위한 manager
 */
class DataManager {
    /**
     @static
     
     @brief 앱에서 저장될 데이타를 관리하기 위한 싱글톤 객체
     */
    static let sharedInstance = DataManager()
    
    var userInfo: UserModel?
    
    /** @brief modal로 이동한 Viewcontroller리스트 */
    var modalViewControllerList : NSMutableArray?
    
    /** @brief iOS platform list 배열 */
    var platformList : Array<Dictionary<String,String>>?
    
    /** @brief 현재 버젼 */
    var version : String {
        if let dict = Bundle.main.infoDictionary {
            if let version = dict["CFBundleShortVersionString"] as? String {
                return version
            }
        }
        return ""
    }
    
    /** @brief 현재 빌드버전 */
    var buildVersion : String {
        if let dict = Bundle.main.infoDictionary {
            if let version = dict["CFBundleVersion"] as? String {
                return version
            }
        }
        return ""
    }
    /** @brief 현재 os 버젼 */
    var osVersion :  String {
        return UIDevice.current.systemVersion
    }
    
    /** @brief 현재 device name */
    var deviceName : String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
}

