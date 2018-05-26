import UIKit

class MainViewController: UIViewController {

    var viewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = MainViewModel()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
