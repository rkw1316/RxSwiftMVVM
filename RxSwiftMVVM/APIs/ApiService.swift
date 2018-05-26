//
//  ApiService.swift
//  swiftMVVM
//

import Moya
import RxCocoa
import RxSwift

protocol ApiTargetType: TargetType {
    associatedtype Response: Codable
}

class ApiService {

    init() {}
    static let shard = ApiService()
    let provider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)

    func request<R>(_ request: R) -> Single<R.Response> where R: ApiTargetType {
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map(R.Response.self)
    }

}
