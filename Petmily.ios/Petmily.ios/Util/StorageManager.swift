//
//  StorageManager.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import FirebaseStorage
import UIKit

enum StorageError: Error {
    case compressError
    case unknownError
}

final class StorageManager {
    static let shared = StorageManager()
    private let storage = Storage.storage()
    
    private let compressionQuality: CGFloat = 1
    let progressSubject = PassthroughSubject<Double, Never>()
    
    private init() { }
}

extension StorageManager {
    enum ImagePath {
        case shareInfoPath
        case shareDailyVideos
        
        var path: String {
            switch self {
            case .shareInfoPath:
                return "ShareInfoImages"
                
            case .shareDailyVideos:
                return "shareDailyVideos"
            }
        }
    }
}

extension StorageManager {
    /// Storage에 사진을 저장하기 위한 메서드
    /// - Parameters:
    ///   - storageRefName: StorageManager.ImagePath
    ///   - spaceRefName: 파일명
    ///   - contentImage: 저장할 이미지
    /// - Tip: 사진 저장 경로: storageRefName/spaceRefName
    /// - Returns: **성공**: 이미지 URL, **실패**: Error
    func createContentImage(storageRefName: ImagePath, spaceRefName: String, contentImage: UIImage) async throws -> URL {
        let storageRef = makeStorageRef(storageRefName, spaceRefName)
        do {
            let data = try makeImageData(contentImage)
            let imageUrl = try await putImageData(storageRef, data)
            return imageUrl
        } catch {
            throw error
        }
    }
}

extension StorageManager {
    func deleteContentImage(storageRefName: ImagePath, spaceRefName: String) async throws -> Bool {
        let storageRef = makeStorageRef(storageRefName, spaceRefName)
        do {
            try await storageRef.delete()
            return true
        } catch {
            throw error
        }
    }
}

private extension StorageManager {
    func makeStorageRef(_ storageRefName: ImagePath, _ spaceRefName: String) -> StorageReference {
        let storageRef = storage.reference()
        let pathRef = storageRef.child(storageRefName.path)
        let spaceRef = pathRef.child(spaceRefName)
        return spaceRef
    }
    
    func makeImageData(_ image: UIImage) throws -> Data {
        guard let data = image.jpegData(compressionQuality: compressionQuality) else {
            throw StorageError.compressError
        }
        return data
    }
}

private extension StorageManager {
    func putImageData(_ storageRef: StorageReference, _ imageData: Data) async throws -> URL {
        do {
            let _ = try await storageRef.putDataAsync(imageData) { [weak self] progress in
                guard let self,
                      let progress else { return }
                Task {
                    await self.updateProgressBar(fractionCompleted: progress.fractionCompleted)
                }
            }
            let downloadUrl = try await storageRef.downloadURL()
            return downloadUrl
        } catch {
            throw error
        }
    }
    
    @MainActor
    func updateProgressBar(fractionCompleted: Double) async {
        progressSubject.send(fractionCompleted * 100)
    }
}
