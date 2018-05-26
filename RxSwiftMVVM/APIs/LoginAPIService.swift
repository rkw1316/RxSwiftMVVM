//
//  LoginAPIService.swift
//  swiftMVVM
//

import Moya
import RxCocoa
import RxSwift

enum LoginAPIService {
    case login(String, String)
}

extension LoginAPIService: ApiTargetType {

    typealias Response = Login

    var baseURL: URL { return URL(string: "http://localhost:3000/")! }

    var path: String {
        switch self {
        case .login:
            return "login"
        }
    }
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .login:
            return .requestPlain
        }
    }
    var headers: [String: String]? { return nil }

    var sampleData: Data {
        let path = Bundle.main.path(forResource: "login", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }

}
