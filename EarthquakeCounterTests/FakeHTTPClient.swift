import EarthquakeCounter
import Foundation
import PromiseKit

class FakeHTTPClient: HTTPClient {
    //MARK: Track methods that were called
    var get_wasCalled = false
    var get_wasCalled_withArgs: (url: String, query: [String: AnyObject])? = nil
    var lastRequest: (promise: JSONPromise, fulfill: (NSDictionary) -> Void, reject: (ErrorType) -> Void)?


    //MARK: HTTPClient
    func get(url: String, query: [String: AnyObject]) -> JSONPromise {
        get_wasCalled = true
        get_wasCalled_withArgs = (url: url, query: query)

        lastRequest = JSONPromise.pendingPromise()
        return lastRequest!.promise
    }

    func fulfillLastRequest(representation: NSDictionary) {
        lastRequest?.fulfill(representation)
        advanceRunLoopSlightly()
    }

    func rejectLastRequest(error: NSError) {
        lastRequest?.reject(error)
        advanceRunLoopSlightly()
    }



    func reset(stubGetWith: JSONPromise) {
        get_wasCalled = false
        get_wasCalled_withArgs = nil
    }
}