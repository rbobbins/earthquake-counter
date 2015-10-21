import Foundation
import PromiseKit

public typealias JSONPromise = Promise<NSDictionary>
public protocol HTTPClient {
    func get(url: String, query: [String: AnyObject]) -> JSONPromise
}

class RealHTTPClient: HTTPClient {
    func get(url: String, query: [String: AnyObject]) -> JSONPromise {
        return NSURLSession.GET(url, query: query).asDictionary()
    }
}