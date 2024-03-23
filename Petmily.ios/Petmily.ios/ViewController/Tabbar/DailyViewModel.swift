//
//  DailyViewModel.swift
//  Petmily.ios
//
//  Created by 김지은 on 3/17/24.
//

import Foundation
import Combine

@MainActor
class DailyViewModel: ObservableObject {
    @Published var shareDailies: [ShareDaily] = []
    @Published var errorMessage: String?
    
    private let shareDailyManager = ShareDailyManager.shared
    
    func getShareDaily(breed: Breed, lastData: ShareDaily?, limitCount: Int = 10) async {
        let createTime = lastData?.createTime ?? Date()
        
        switch await shareDailyManager.getShareData(breed: breed, createTime: createTime, limitCount: limitCount) {
        case .success(let shareDailyList):
            shareDailies = shareDailyList
            CommonUtil.print(output: shareDailyList)
        case .failure(let error):
            errorMessage = error.localizedDescription
            CommonUtil.print(output: error.localizedDescription)
        }
    }
}
