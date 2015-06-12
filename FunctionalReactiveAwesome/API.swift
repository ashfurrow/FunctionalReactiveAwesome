import Foundation
import Moya
import RxSwift

enum API {
    case Signup(email: String, password: String)
    case Friends
}

extension API: MoyaPath, MoyaTarget {
    var path: String {
        switch self {
        case .Signup(let email, let password):
            return "/signup"
        case .Friends:
            return "/friends"
        }
    }

    var baseURL: NSURL {
        return NSURL(string: "http://example.com")!
    }

    var method: Moya.Method {
        switch self {
        case .Signup(_, _):
            return .POST
        default:
            return .GET
        }
    }

    var parameters: [String: AnyObject] {
        return [:]
    }

    var sampleData: NSData {
        switch self{
        case .Signup(let email, _):
            return ("Welcome, \(email)!" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        case .Friends:
            return friendsData
        }
    }
}

let stubbedBehavior: MoyaProvider<API>.MoyaStubbedBehavior = { target -> Moya.StubbedBehavior in
    return .Delayed(seconds: 1)
}

let api = RxMoyaProvider<API>(stubResponses: true, stubBehavior: stubbedBehavior)

let friendsData = NSArray(array: ["Alloy", "Laura", "Orta", "Sarah"]).componentsJoinedByString(",").dataUsingEncoding(NSUTF8StringEncoding)!
