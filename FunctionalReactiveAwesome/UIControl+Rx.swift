import RxSwift
import UIKit

extension UIControl {
    func rx_subscribeEnabledTo(source: Observable<Bool>) -> Disposable {
        return source.subscribe(AnonymousObserver {[weak self] event in
            MainScheduler.ensureExecutingOnScheduler()

            switch event {
            case .Next(let boxedValue):
                let value = boxedValue.value
                self?.enabled = value
            case .Error(let error):
                #if DEBUG
                    rxFatalError("Binding error to textbox: \(error)")
                #endif
                break
            case .Completed:
                break
            }
        })
    }
}