//
//  AddDailyViewModel.swift
//  Petmily.ios
//
//  Created by 김지은 on 3/10/24.
//

import Foundation
import Combine

@MainActor
class AddDailyViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isCreateSuccess: Bool = false
    
    private let shareDailyManager = ShareDailyManager.shared
    private let storageManager = StorageManager.shared
    
    func createShareDaily(breed: Breed, data: ShareDaily) async {
        do {
            let convertURL = try copyFileToDocumentsDirectory(fileURL: data.contentVideoUrl)
            
            let videoResult = try await storageManager
                .createContentVideo(storageRefName: StorageManager.ImagePath.shareDailyVideos,
                                    spaceRefName: data.shareID.uuidString,
                                    contentVideo: convertURL)
            
            var updatedData = data
            updatedData.contentVideoUrl = videoResult
            
            let result = await shareDailyManager.createShareDaily(breed: breed, data: data)
            
            switch result {
            case .success(let success):
                isCreateSuccess = true
            case .failure(let error):
                errorMessage = "ShareDaily 생성 실패"
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func copyFileToDocumentsDirectory(fileURL: URL) throws -> URL {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectory.appendingPathComponent(fileURL.lastPathComponent)

        // 기존 파일이 있다면 삭제
        if fileManager.fileExists(atPath: destinationURL.path) {
            try fileManager.removeItem(at: destinationURL)
        }

        // 파일 복사
        try fileManager.copyItem(at: fileURL, to: destinationURL)
        return destinationURL
    }

}
