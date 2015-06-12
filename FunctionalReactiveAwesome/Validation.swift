import Foundation

extension String {
    func contains(substring: String) -> Bool {
        return (self as NSString).containsString(substring)
    }

    func contains(substrings: [String]) -> Bool {
        return substrings.reduce(true) { (memo, substring) -> Bool in
            return memo && contains(substring)
        }
    }
}

func isEmail(text: String) -> Bool {
    return text.contains(["@", "."])
}

func isPassword(text: String) -> Bool {
    return count(text) > 6
}
