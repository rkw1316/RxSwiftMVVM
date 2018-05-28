import UIKit
import RxCocoa
import RxSwift
import SwiftEventBus
//import UI+RxExtention

extension UITextField {
    /// テキストボックスとViewModelのストリームを双方向バインディング
    func setRelay(relay: BehaviorRelay<String?>!, by bag: DisposeBag) {
        relay.asDriver().drive(self.rx.text).disposed(by: bag)
        self.rx.text.bind(to: relay).disposed(by: bag)
    }
}

extension UIButton {
    /// タップイベントのバインディング
    func setEvent(event: (() -> Void)!, by bag: DisposeBag) {
        self.rx.tap.asObservable().bind(onNext: { () in event() }).disposed(by: bag)
    }
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginViewModel(Auth.sheard)
        
        // データバインディング
        userIDTextField.setRelay(relay: viewModel.userId, by: disposeBag)
        passwordTextField.setRelay(relay: viewModel.password, by: disposeBag)
        
        // タップイベント
        loginButton.setEvent(event: viewModel.loginButtonDidTap, by: disposeBag)
        
        // イベントハンドラ登録
        registEventOnMainThread()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// 遷移・ダイアログ表示系の処理（SwiftEventBusでオブサーブする）
    func registEventOnMainThread() {
        // 画面遷移
        SwiftEventBus.onMainThread(self, name: "EVENTBUS_KEY_SEGUE_MAIN") { _ in
            self.performSegue(withIdentifier: "main", sender: nil)
        }
        // エラーダイアログ表示
        SwiftEventBus.onMainThread(self, name: "VIEW_ERROR_DIALOG") { _ in
            // self.viewDialog()
        }
    }
}
