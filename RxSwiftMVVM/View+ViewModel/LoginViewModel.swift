import Moya
import RxCocoa
import RxSwift

class LoginViewModel {

    let disposeBag = DisposeBag()
    let model: Auth
    //公開操作
    let loginButtonDidTap = PublishRelay<Void>()
    let loginSuccess = PublishRelay<String>()

    //公開データ
    let userId = BehaviorRelay<String?>(value: "")
    let password = BehaviorRelay<String?>(value: "")

    init(_ model: Auth) {
        self.model = model
        
        model.userId.asDriver()
            .drive(userId)
            .disposed(by: disposeBag)

        model.password.asDriver()
            .drive(password)
            .disposed(by: disposeBag)
        
        loginButtonDidTap
            .subscribe(onNext: {[unowned self] _ in
                model.login(name: self.userId.value!, pass: self.password.value!)
            })
            .disposed(by: disposeBag)
        
        model.isLogin
            .filter {$0}
            .subscribe({[unowned self] _ in
                self.loginSuccess.accept("Main")
            })
            .disposed(by: disposeBag)

    }
}
