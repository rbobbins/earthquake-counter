import EarthquakeCounter
import Foundation
import PromiseKit

class FakeHTTPClient: HTTPClient {
    //MARK: Track methods that were called
    var get_wasCalled = false
    var get_wasCalled_withArgs: (url: String, query: [String: AnyObject])? = nil
    var lastRequest: (promise: JSONPromise, fulfill: (NSDictionary) -> Void, reject: (Error) -> Void)?


    //MARK: HTTPClient
    func get(_ url: String, query: [String: AnyObject]) -> JSONPromise {
        get_wasCalled = true
        get_wasCalled_withArgs = (url: url, query: query)

        lastRequest = JSONPromise.pending()
        return lastRequest!.promise
    }

    func fulfillLastRequest(_ representation: NSDictionary) {
        lastRequest?.fulfill(representation)
        advanceRunLoopSlightly()
    }

    func rejectLastRequest(_ error: NSError) {
        lastRequest?.reject(error)
        advanceRunLoopSlightly()
    }



    func reset(_ stubGetWith: JSONPromise) {
        get_wasCalled = false
        get_wasCalled_withArgs = nil
    }
}
