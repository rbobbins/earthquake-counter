import Foundation
import PromiseKit

public typealias JSONPromise = Promise<NSDictionary>
public protocol HTTPClient {
    func get(url: NSURL) -> JSONPromise
}

class RealHTTPClient: HTTPClient {
    func get(url: NSURL) -> JSONPromise {
        return NSURLSession.GET(url.absoluteString).asDictionary()
    }
}