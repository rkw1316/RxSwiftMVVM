//
//  Auth.swift
//  swiftMVVM
//

import Foundation
import RxSwift
import RxCocoa
import SwiftEventBus

/// ログイン状態
struct LoginState {
    var isLogin = false
}

class Auth {

    static let sheard = Auth()
    init() {
    }
    
    let disposeBag = DisposeBag()
    let repository = Repository.shared
    
    /// シングルトンにあっていいんかな？
    let isLogin = BehaviorRelay<Bool>(value: false)

    /// ログインのシーケンス
    //func login(name: String, pass: String) {
    //    //色々エラー処理・分岐・リトライ・画面遷移通知を行う予定
    //    ApiService.shard.request(LoginAPIService.login(name, pass))
    //        .map {$0.result}
    //        .flatMap {_ -> Single<Login> in  ApiService.shard.request(LoginAPIService.login(name, pass))}
    //        .map {$0.result == "1"}
    //        .subscribe(onSuccess: {result in
    //            self.isLogin.accept(result)
    //        })
    //        .disposed(by: disposeBag)
    //}
    
    /// ログインのシーケンス
    func loginSingle(name: String, pass: String) -> Single<LoginState> {
        //色々エラー処理・分岐・リトライ・画面遷移通知を行う予定
        return ApiService.shard.request(LoginAPIService.login(name, pass))
            .map {$0.result}
            .flatMap {_ -> Single<Login> in
                ApiService.shard.request(LoginAPIService.login(name, pass))
            }
            .map {
                LoginState(isLogin: ($0.result == "1"))
            }
            .catchError { (error) -> Single<LoginState> in
                SwiftEventBus.post("VIEW_ERROR_DIALOG")
                return Single.error(error)
            }
    }
}
