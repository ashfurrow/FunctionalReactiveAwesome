import UIKit
import RxSwift
import RxCocoa

class EmailValidationDemoViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.rx_text
            >- map (isEmail)
            >- submitButton.rx_subscribeEnabledTo
            >- disposeBag.addDisposable
    }
}
