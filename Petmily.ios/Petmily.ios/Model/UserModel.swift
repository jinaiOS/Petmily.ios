//
//  UserModel.swift
//  Petmily.ios
//
//  Created by 박상우 on 2/16/24.
//

import Foundation

struct UserModel: Codable {
    let id: String
    var imageURL: String = ""
    let name: String?
    let animalName: String?
    let gender: String?
    let birth: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case animalName
        case gender
        case birth
        case type
    }
}

struct User: Codable {
    let id: String?
    let nickName: String?
    let image: String?
    let pet: [Pet]?
}
