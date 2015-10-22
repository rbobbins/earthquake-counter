import UIKit

func advanceRunLoopSlightly() {
    NSRunLoop.mainRunLoop().runUntilDate(NSDate().dateByAddingTimeInterval(0.01))
}