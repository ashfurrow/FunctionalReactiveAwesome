import UIKit
import RxSwift
import RxCocoa
import Moya

class SignupDemoViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let emailIsValid = emailAddressTextField.rx_text >- map (isEmail)
        let passwordIsValid = passwordTextField.rx_text >- map (isPassword)

        combineLatest(emailIsValid, passwordIsValid)
            >- and
            >- signupButton.rx_subscribeEnabledTo
            >- disposeBag.addDisposable

        let signupSignal = combineLatest(emailAddressTextField.rx_text, passwordTextField.rx_text) { (email, password) -> Observable<MoyaResponse> in
                return api.request(.Signup(email: email, password: password))
            } >- switchLatest


        signupButton.rx_tap
            >- signup
            >- display("OK")
            >- disposeBag.addDisposable
    }
}