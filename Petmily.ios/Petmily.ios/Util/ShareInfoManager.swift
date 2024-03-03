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
    case errorString(description: Error)
    case emptyData
    case unknownError
}

final class ShareInfoManager {
    static let shared = ShareInfoManager()
    private let userDB = Firestore.firestore().collection("ShareInfos")
    private let dateFormat = "yyyy-MM-dd"
    private let createTime = "createTime"
    private let limitCount = 2
    
    private init() { }
}

private extension ShareInfoManager {
    /// ShareInfo CRUD를 위한 경로를 만드는 메서드
    /// - Parameters:
    ///   - date: 접근하려는 날짜, **default value**: 오늘 날짜
    ///   - breed: 동물 타입(종)
    /// - Returns: ShareInfo의 FireStore 경로
    func makeCollectionReference(date: String? = nil, breed: Breed) -> CollectionReference {
        let dateString: String
        if let date = date {
            dateString = date
        } else {
            dateString = Date.stringFromDate(date: Date(), format: dateFormat)
        }
        
        let collectionReference = userDB.document(breed.name)
            .collection(dateString)
        return collectionReference
    }
}

extension ShareInfoManager {
    /// Firestore에 ShareInfo를 생성하기 위한 메서드
    /// - Parameters:
    ///   - breed: 동물 타입(종)
    ///   - data: 생성하려는 ShareInfo 데이터
    /// - Returns: **성공**: success, **실패**: error(String)
    func createShareInfo(_ breed: Breed, _ data: ShareInfo) async -> Result<Bool, FireStoreError> {
        do {
            let collectionRef = makeCollectionReference(breed: breed)
            let docRef = collectionRef.document(data.shareID.uuidString)
            try docRef.setData(from: data, encoder: .init())
            return .success(true)
        } catch {
            return .failure(.errorString(description: error))
        }
    }
    
    /// Firestore에 ShareInfo list를 가져오기 위한 메서드
    /// - Parameters:
    ///   - date: 가져올 날짜
    ///   - breed: 동물 타입(종)
    /// - Returns: **성공**: [ShareInfo], **실패**: error(String)
    func getShreInfoQueryDocumentSnapshot(_ date: String, _ breed: Breed) async -> Result<[ShareInfo], FireStoreError> {
        let collectionRef = makeCollectionReference(date: date, breed: breed)
        let query = collectionRef
            .order(by: createTime, descending: true)
//            .order(by: "author", descending: true)
            .limit(to: limitCount)
        
        do {
            let querySnapshot = try await query.getDocuments()
            let queryDocumentSnapshot = querySnapshot.documents
            let shareInfoList = try decodeDocSnapshotToShareInfo(queryDocumentSnapshot)
            return .success(shareInfoList)
        } catch {
            return .failure(.errorString(description: error))
        }
    }
    
//    func getShareInfoList(_ breed: Breed) async {
//        let reference = userDB.document(breed.name).collection("2024-03-03")
//        let query = reference
//            .order(by: createTime, descending: true)
//            .limit(to: limitCount)
//        
//        query.addSnapshotListener { [weak self] snapshot, error in
//            guard let self else { return }
//            guard let snapshot else {
//                print("Error retreving cities: \(error.debugDescription)")
//                return
//            }
//            
//            guard let lastSnapshot = snapshot.documents.last else {
//                return
//            }
//            
//            let next = reference
//                .order(by: createTime, descending: true)
//                .start(afterDocument: lastSnapshot)
//                .limit(to: limitCount)
//            
//            Task {
//                let queryDocumentSnapshot = try await next.getDocuments().documents
//                self.decodeDocSnapshotToShareInfo(queryDocumentSnapshot)
//            }
//        }
//    }
    
//    func getTodoList(strDate: String) async -> [Todo]? {
//        guard let uid = FirebaseManager.shared.getUID() else { return nil }
//        
//        do {
//            let querySnapshot = try await userDB.document(uid).collection(strDate).getDocuments()
//            let documentSnapshot = querySnapshot.documents
//            
//            let todoList = documentSnapshot.compactMap { document -> Todo? in
//                guard
//                    let id = document["id"] as? String,
//                    let content = document["content"] as? String,
//                    let date = document["date"] as? String,
//                    let priority = (document["priority"] as? Timestamp)?.dateValue(),
//                    let done = document["done"] as? Bool else { return nil }
//                // 알람은 복귀 유저가 저장하지 않아도 되는 정보이므로 제외함
//                
//                let todo = Todo(
//                    id: UUID(uuidString: id) ?? UUID(),
//                    content: content,
//                    date: date,
//                    priority: priority,
//                    done: done
//                )
//                return todo
//            }
//            return todoList
//        } catch {
//            print("error: \(error.localizedDescription)")
//            return nil
//        }
//    }
}

private extension ShareInfoManager {
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
