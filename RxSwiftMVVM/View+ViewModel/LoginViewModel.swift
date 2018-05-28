import Moya
import RxCocoa
import RxSwift
import SwiftEventBus

class LoginViewModel {

    let disposeBag = DisposeBag()
    let model: Auth
    
    // 公開データ
    let userId = BehaviorRelay<String?>(value: "")
    let password = BehaviorRelay<String?>(value: "")

    init(_ model: Auth) {
        self.model = model
        
        // 記憶領域のデータで初期化
        userId.accept(Repository.shared.get(.userIDKey))
        userId.accept(Repository.shared.get(.passwordKey))
        
        // イベントの登録
        registUpdateUI(relay: model.isLogin, operation: doneLogin)
    }
    
    /// BehaviorRelay<Bool>がTrueの時に実行される処理
    func registUpdateUI(relay: BehaviorRelay<Bool>, operation: @escaping () -> Void) {
        relay.filter {$0}
            .observeOn(MainScheduler.instance)
            .bind(onNext: { _ in operation() })
            .disposed(by: disposeBag)
    }
    
    /// ログインボタン押下処理
    public func loginButtonDidTap() {
        model.loginSingle(name: self.userId.value!, pass: self.password.value!)
            .observeOn(MainScheduler.instance)
            .subscribe { _ in self.doneLogin(/** state */) }
            .disposed(by: disposeBag)
    }
    
    /// ログイン完了後の処理
    private func doneLogin(/** state: LoginState */) {
        SwiftEventBus.post("EVENTBUS_KEY_SEGUE_MAIN")
    }
}
