import UIKit
import RxSwift
import RxCocoa
import Moya

extension NetworkDemoViewController {

    func fetchFriends() -> Observable<[String]> {
        return defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            return api.request(.Friends)
                >- doOnNext({ _ -> Void in
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
                >- map({ response -> [String] in
                    let friends = NSString(data: response.data, encoding: NSUTF8StringEncoding)!.componentsSeparatedByString(",")
                    return friends as! [String]
                })
        }
    }

    func subscribeFriendsTo(source: Observable<[String]>) -> Disposable {
        return source.subscribe(AnonymousObserver { event in

            switch event {
            case .Next(let boxedValue):
                self.friends = boxedValue.value
                self.tableView.reloadData()
            case .Error(let error):
                self.displayMessage("Could not retrieve friends.", title: "Network error")
            case .Completed:
                break
            }
        })
    }

}
