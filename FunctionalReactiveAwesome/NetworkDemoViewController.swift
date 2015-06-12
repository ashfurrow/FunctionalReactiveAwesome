import UIKit
import RxSwift
import RxCocoa
import Moya

class NetworkDemoViewController: UITableViewController {

    var friends: [String] = []
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchFriends()
            >- subscribeFriendsTo
            >- disposeBag.addDisposable
    }
}

extension NetworkDemoViewController: UITableViewDataSource {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count(friends)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell

        cell.textLabel?.text = friends[indexPath.row]

        return cell
    }

}