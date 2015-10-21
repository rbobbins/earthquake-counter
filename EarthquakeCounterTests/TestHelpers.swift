import UIKit

func advanceRunLoopSlightly() {
    NSRunLoop.mainRunLoop().runUntilDate(NSDate())
}