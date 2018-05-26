//
//  SplashViewController.swift
//  swiftMVVM
//

import UIKit
import RxCocoa
import RxSwift

class SplashViewController: UIViewController {

    var viewModel: SplashViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SplashViewModel()
        
        //        viewModel.transport.asObservable()
        //            .subscribe(onNext:{ [unowned self] segue in
        //                self.performSegue(withIdentifier: segue, sender: nil)
        //            })
        //            .disposed(by: disposeBag)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
