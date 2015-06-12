import UIKit
import RxSwift

extension UIViewController {
    func display(input: Observable<String>) -> Disposable {
        return input
            >- subscribe { [weak self] (event) -> Void in
                self?.displayMessage(event.value, title: "Signed up!")
            }
    }

    func displayMessage(message: String?, title: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        let ok = UIAlertAction(title: "OK", style: .Default, handler: { [weak self] (_) -> Void in
            self?.navigationController?.popToRootViewControllerAnimated(true)
        })

        alert.addAction(ok)

        self.presentViewController(alert, animated: true, completion: nil)
    }

}