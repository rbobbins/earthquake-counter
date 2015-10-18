import Foundation
import PromiseKit

public typealias JSONPromise = Promise<NSDictionary>
public protocol HTTPClient {
    func get(url: String) -> JSONPromise
}

class RealHTTPClient: HTTPClient {
    func get(url: String) -> JSONPromise {
        return NSURLSession.GET(url).asDictionary()
    }
}