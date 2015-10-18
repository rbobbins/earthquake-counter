import EarthquakeCounter
import Foundation
import PromiseKit

class FakeHTTPClient: HTTPClient {
    //MARK: Track methods that were called
    var get_wasCalled = false
    var get_wasCalled_withURL: String?
    var lastRequest: (promise: JSONPromise, fulfill: (NSDictionary) -> Void, reject: (ErrorType) -> Void)?


    //MARK: HTTPClient
    func get(url: String) -> JSONPromise {
        get_wasCalled = true
        get_wasCalled_withURL = url

        lastRequest = JSONPromise.pendingPromise()
        return lastRequest!.promise
    }

    func fulfillLastRequest(representation: NSDictionary) {
        lastRequest?.fulfill(representation)
        NSRunLoop.mainRunLoop().runUntilDate(NSDate())
    }

    func rejectLastRequest(error: NSError) {
        lastRequest?.reject(error)
        NSRunLoop.mainRunLoop().runUntilDate(NSDate())
    }



    func reset(stubGetWith: JSONPromise) {
        get_wasCalled = false
        get_wasCalled_withURL = nil
    }
}