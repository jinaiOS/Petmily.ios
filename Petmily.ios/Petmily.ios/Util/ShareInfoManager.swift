//
//  ShareInfoManager.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import FirebaseFirestore
import Foundation

enum FireStoreError: Error {
    case decodeError
    case firestoreError(Error: Error) // Firestore 에러를 담기 위한 케이스
    case emptyData
    case unknownError
}

final class ShareInfoManager {
    static let shared = ShareInfoManager()
    private let userDB = Firestore.firestore().collection("ShareInfos")
    private let orderbyCreateTime = "createTime"
    private let orderbyLikeCount = "likeCount"
    
    private init() { }
}

extension ShareInfoManager {
    /// Firestore에 ShareInfo를 생성하기 위한 메서드
    /// - Parameters:
    ///   - breed: 동물 타입(종)
    ///   - data: 생성하려는 ShareInfo 데이터
    /// - Returns: **성공**: success(true), **실패**: failure(FireStoreError)
    func createShareInfo(breed: Breed, data: ShareInfo) async -> Result<Bool, FireStoreError> {
        do {
            let collectionRef = makeCollectionReference(breed)
            let docRef = collectionRef.document(data.shareID.uuidString)
            try docRef.setData(from: data, encoder: .init())
            return .success(true)
        } catch {
            return .failure(.firestoreError(Error: error))
        }
    }
}

extension ShareInfoManager {
    /// Firestore에서 PopularSection 데이터를 가져오기 위한 메서드
    /// - Parameters:
    ///   - breed: 동물 타입(종)
    ///   - createTime: 커서의 기준이 되는 시간
    ///   - limitCount: 가져올 데이터 개수
    /// - Returns: **성공**: success([ShareInfo]), **실패**: failure(FireStoreError)
    func getPopularSectionData(breed: Breed, createTime: Date, limitCount: Int) async -> Result<[ShareInfo], FireStoreError> {
        let collectionRef = makeCollectionReference(breed)
        let query = makePopularShareInfoQuery(collectionRef, createTime, limitCount)
        
        do {
            let querySnapshot = try await query.getDocuments()
            let queryDocumentSnapshot = querySnapshot.documents
            let shareInfoList = try decodeDocSnapshotToShareInfo(queryDocumentSnapshot)
            return .success(shareInfoList)
        } catch {
            return .failure(.firestoreError(Error: error))
        }
    }
    
    /// Firestore에서 ShareSection 데이터를 가져오기 위한 메서드
    /// - Parameters:
    ///   - breed: 동물 타입(종)
    ///   - createTime: 커서의 기준이 되는 시간
    ///   - limitCount: 가져올 데이터 개수
    /// - Returns: **성공**: success([ShareInfo]), **실패**: failure(FireStoreError)
    func getShareSectionData(breed: Breed, createTime: Date, limitCount: Int) async -> Result<[ShareInfo], FireStoreError> {
        do {
            let collectionRef = makeCollectionReference(breed)
            let query = makeShareInfoQuery(collectionRef, createTime, limitCount)
            
            let shareInfoList = try await getShareInfo(query)
            return .success(shareInfoList)
        } catch {
            return .failure(.firestoreError(Error: error))
        }
    }
}

extension ShareInfoManager {
    func updateShareInfo(breed: Breed, data: ShareInfo) async -> Result<Bool, FireStoreError> {
        let collectionRef = makeCollectionReference(breed)
        let docRef = collectionRef.document(data.shareID.uuidString)
        let newData = makeUpdateData(data)
        
        do {
            try await docRef.updateData(newData)
            return .success(true)
        } catch {
            return .failure(.firestoreError(Error: error))
        }
    }
}

extension ShareInfoManager {
    func removeShareInfo(breed: Breed, id: UUID) async -> Result<Bool, FireStoreError> {
        let collectionDocRef = makeCollectionReference(breed).document(id.uuidString)
        do {
            try await collectionDocRef.delete()
            return .success(true)
        } catch {
            return .failure(.firestoreError(Error: error))
        }
    }
}

private extension ShareInfoManager {
    /// ShareInfo CRUD를 위한 경로를 만드는 메서드
    /// - Parameter breed: 동물 타입(종)
    /// - Returns: ShareInfo의 FireStore 경로
    func makeCollectionReference(_ breed: Breed) -> CollectionReference {
        return userDB.document("Breed").collection(breed.name)
    }
    
    func makePopularShareInfoQuery(_ collectionRef: CollectionReference, _ createTime: Date, _ limitCount: Int) -> Query {
        let query = collectionRef
            .order(by: orderbyLikeCount, descending: true)
            .whereField(orderbyLikeCount, isGreaterThan: 0)
            .start(after: [createTime])
            .limit(to: limitCount)
        return query
    }
    
    func makeShareInfoQuery(_ collectionRef: CollectionReference, _ createTime: Date, _ limitCount: Int) -> Query {
        let query = collectionRef
            .order(by: orderbyCreateTime, descending: true)
            .start(after: [createTime])
            .limit(to: limitCount)
        return query
    }
}

private extension ShareInfoManager {
    func getShareInfo(_ query: Query) async throws -> [ShareInfo] {
        let querySnapshot = try await query.getDocuments()
        let queryDocumentSnapshot = querySnapshot.documents
        let shareInfoList = try decodeDocSnapshotToShareInfo(queryDocumentSnapshot)
        return shareInfoList
    }
    
    func makeUpdateData(_ data: ShareInfo) -> [String : Any] {
        let updateData: [String : Any] = [
            "title": data.title,
            "content": data.content,
            "hashtag": data.hashtag
        ]
        return updateData
    }
    
    /// Firestore에서 받은 Snapshot을 ShareInfo로 디코딩 하는 메서드
    /// - Parameter queryDocumentSnapshot: Documents의 queryDocumentSnapshot
    /// - Returns: ShareInfo 배열을 반환
    func decodeDocSnapshotToShareInfo(_ queryDocumentSnapshot: [QueryDocumentSnapshot]) throws -> [ShareInfo] {
        var shareInfoList: [ShareInfo] = []
        
        if queryDocumentSnapshot.isEmpty {
            throw FireStoreError.emptyData
        }
        
        for snapShot in queryDocumentSnapshot {
            do {
                let shareInfo = try snapShot.data(as: ShareInfo.self, decoder: .init())
                shareInfoList.append(shareInfo)
            } catch {
                throw FireStoreError.decodeError
            }
        }
        return shareInfoList
    }
}
