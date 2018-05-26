//
//  Auth.swift
//  swiftMVVM
//

import Foundation
import RxSwift
import RxCocoa

class Auth {

    static let sheard = Auth()
    init() {
        userId.accept(Repository.shared.get(.userIDKey))
        password.accept(Repository.shared.get(.passwordKey))
    }
    
    let disposeBag = DisposeBag()
    let repository = Repository.shared
    let isLogin = BehaviorRelay<Bool>(value: false)
    let loginQueue = PublishRelay<Void>()
    
    let userId = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    func login(name: String, pass: String) {
        
        //色々エラー処理・分岐・リトライ・画面遷移通知を行う予定
//        _ = loginQueue
//            .flatMap { ApiService.shard.request(LoginAPIService.login(name, pass))}
//            .flatMap { _ -> Single<Login> in ApiService.shard.request(LoginAPIService.login(name, pass))}
//            .subscribe(onNext: {result in print(result.result) })
//            .disposed(by: disposeBag)
        
        ApiService.shard.request(LoginAPIService.login(name, pass))
            .map {$0.result}
            .flatMap {_ -> Single<Login> in  ApiService.shard.request(LoginAPIService.login(name, pass))}
            .map {$0.result == "1"}
            .subscribe(onSuccess: {result in
                self.isLogin.accept(result)
            })
            .disposed(by: disposeBag)

    }
}
