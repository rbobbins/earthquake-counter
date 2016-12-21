import Foundation
import PromiseKit
import OMGHTTPURLRQ

public typealias JSONPromise = Promise<NSDictionary>
public protocol HTTPClient {
    func get(_ url: String, query: [String: AnyObject]) -> JSONPromise
}

class RealHTTPClient: HTTPClient {
    func get(_ url: String, query: [String: AnyObject]) -> JSONPromise {
        let rq = try! OMGHTTPURLRQ.get(url, query)
        return URLSession.shared.dataTask(with: rq as URLRequest).asDictionary()
    }
}
