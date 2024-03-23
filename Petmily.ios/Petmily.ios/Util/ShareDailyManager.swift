//
//  ShareDailyManager.swift
//  Petmily.ios
//
//  Created by 김지은 on 3/10/24.
//

import Foundation
import FirebaseFirestore
import Combine

final class ShareDailyManager {
    static let shared = ShareDailyManager()
    private let userDB = Firestore.firestore().collection("ShareDailies")
    private let orderbyCreateTime = "createTime"
    private let orderbyLikeCount = "likeCount"
    
    private init() { }
}

extension ShareDailyManager {
    /// Firestore에 ShareDaily를 생성하기 위한 메서드
    /// - Parameters:
    ///   - breed: 동물 타입(종)
    ///   - data: 생성하려는 ShareDaily 데이터
    /// - Returns: **성공**: success(true), **실패**: failure(FireStoreError)
    func createShareDaily(breed: Breed, data: ShareDaily) async -> Result<Bool, FireStoreError> {
        do {
            let collectionRef = makeCollectionReference(breed)
            let docRef = collectionRef.document(data.shareID.uuidString)
            try docRef.setData(from: data, encoder: .init())
            return .success(true)
        } catch {
            return .failure(.firestoreError(Error: error))
        }
    }
    
    /// Firestore에서 ShareSection 데이터를 가져오기 위한 메서드
    /// - Parameters:
    ///   - breed: 동물 타입(종)
    ///   - createTime: 커서의 기준이 되는 시간
    ///   - limitCount: 가져올 데이터 개수
    /// - Returns: **성공**: success([ShareDaily]), **실패**: failure(FireStoreError)
    func getShareData(breed: Breed, createTime: Date, limitCount: Int) async -> Result<[ShareDaily], FireStoreError> {
        do {
            let collectionRef = makeCollectionReference(breed)
            let query = makeShareDailyQuery(collectionRef, createTime, limitCount)
            
            let shareDailyList = try await getShareDaily(query)
            return .success(shareDailyList)
        } catch {
            return .failure(.firestoreError(Error: error))
        }
    }
}
private extension ShareDailyManager {
    /// ShareDaily CRUD를 위한 경로를 만드는 메서드
    /// - Parameter breed: 동물 타입(종)
    /// - Returns: ShareDaily의 FireStore 경로
    func makeCollectionReference(_ breed: Breed) -> CollectionReference {
        return userDB.document("Breed").collection(breed.name)
    }
    
    func makeShareDailyQuery(_ collectionRef: CollectionReference, _ createTime: Date, _ limitCount: Int) -> Query {
        let query = collectionRef
            .order(by: orderbyCreateTime, descending: true)
            .start(after: [createTime])
            .limit(to: limitCount)
        return query
    }
}

private extension ShareDailyManager {
    func getShareDaily(_ query: Query) async throws -> [ShareDaily] {
        let querySnapshot = try await query.getDocuments()
        let queryDocumentSnapshot = querySnapshot.documents
        let shareDailyList = try decodeDocSnapshotToShareDaily(queryDocumentSnapshot)
        return shareDailyList
    }
    
    /// Firestore에서 받은 Snapshot을 ShareDaily로 디코딩 하는 메서드
    /// - Parameter queryDocumentSnapshot: Documents의 queryDocumentSnapshot
    /// - Returns: ShareDaily 배열을 반환
    func decodeDocSnapshotToShareDaily(_ queryDocumentSnapshot: [QueryDocumentSnapshot]) throws -> [ShareDaily] {
        var shareDailyList: [ShareDaily] = []
        
        if queryDocumentSnapshot.isEmpty {
            throw FireStoreError.emptyData
        }
        
        for snapShot in queryDocumentSnapshot {
            do {
                let shareDaily = try snapShot.data(as: ShareDaily.self, decoder: .init())
                shareDailyList.append(shareDaily)
            } catch {
                throw FireStoreError.decodeError
            }
        }
        return shareDailyList
    }
}
