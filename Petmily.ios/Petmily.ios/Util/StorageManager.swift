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
    
    let shareInfoPath = "ShareInfoImages"
    private let compressionQuality: CGFloat = 1
    
    let progressSubject = PassthroughSubject<Double, Never>()
    
    private init() { }
}

extension StorageManager {
    /// Storage에 사진을 저장하기 위한 메서드
    /// - Parameters:
    ///   - storageRefName: Path1 (파일 경로)
    ///   - spaceRefName: Path2 (파일 경로)
    ///   - contentImage: 저장할 이미지
    /// - Tip: 사진 저장 경로: storageRefName/spaceRefName
    /// - Returns: **성공**: 이미지 URL, **실패**: Error
    func createContentImage(storageRefName: String, spaceRefName: String, contentImage: UIImage) async throws -> URL {
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

private extension StorageManager {
    func makeStorageRef(_ storageRefName: String, _ spaceRefName: String) -> StorageReference {
        let storageRef = storage.reference()
        let pathRef = storageRef.child(storageRefName)
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
