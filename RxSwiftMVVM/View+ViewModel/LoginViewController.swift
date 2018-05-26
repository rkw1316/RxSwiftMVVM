import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(Auth.sheard)
        
        viewModel.userId.asDriver()
                .drive(userIDTextField.rx.text)
                .disposed(by: disposeBag)

        viewModel.password.asDriver()
            .drive(passwordTextField.rx.text)
            .disposed(by: disposeBag)

        userIDTextField.rx.text.asDriver()
            .drive(viewModel.userId)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.asDriver()
            .drive(viewModel.password)
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .bind(to: viewModel.loginButtonDidTap)
            .disposed(by: disposeBag)
        
        viewModel.loginSuccess
            .subscribe(onNext: { segue in
                self.performSegue(withIdentifier: segue, sender: nil)
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
