import UIKit
import RxSwift
import RxCocoa
import Moya
import SVProgressHUD

extension SignupDemoViewController {
    var signup: Observable<MoyaResponse> {
        return combineLatest(emailAddressTextField.rx_text, passwordTextField.rx_text) { (email, password) -> Observable<MoyaResponse> in
            return api.request(.Signup(email: email, password: password))
            } >- switchLatest
    }

    func signup(input: Observable<Void>) -> Observable<String> {
        return input
            >- doOnNext { _ -> Void in
                SVProgressHUD.showWithMaskType(.Black)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            }
            >- map { [weak self] _ -> Observable<MoyaResponse> in
                return self?.signup ?? empty()
            }
            >- switchLatest
            >- doOnNext { _ -> Void in
                SVProgressHUD.dismiss()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            >- map { response -> String in
                return NSString(data: response.data, encoding: NSUTF8StringEncoding) as! String
            }
    }

}
