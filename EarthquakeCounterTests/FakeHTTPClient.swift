import EarthquakeCounter
import Foundation
import PromiseKit

class FakeHTTPClient: HTTPClient {
    //MARK: Track methods that were called
    var get_wasCalled = false
    var get_wasCalled_withURL: String?
    var fulfillLastRequest: (NSDictionary -> Void)?
    var rejectLastRequest: (NSError -> Void)?


    //MARK: HTTPClient
    func get(url: String) -> JSONPromise {
        get_wasCalled = true
        get_wasCalled_withURL = url

        let deferred = JSONPromise.pendingPromise()
        fulfillLastRequest = deferred.fulfill
        rejectLastRequest = { (deferred.reject)($0) }
        return deferred.promise
    }



    func reset(stubGetWith: JSONPromise) {
        get_wasCalled = false
        get_wasCalled_withURL = nil
    }
}