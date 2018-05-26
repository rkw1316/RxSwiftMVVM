//
//  Repository.swift
//  swiftMVVM
//

import Foundation

enum RepositoryKey: String {
    case userIDKey = "userID"
    case passwordKey = "password"
}

class Repository {

    private init() {}
    static let shared = Repository()
    let userDefaults: UserDefaults! = UserDefaults.standard

    func get(_ key: RepositoryKey) -> String {
       return userDefaults.string(forKey: key.rawValue) ?? ""
    }
    
    func set(value: String, _ key: RepositoryKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }

}
