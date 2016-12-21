import UIKit

func advanceRunLoopSlightly() {
    RunLoop.main.run(until: Date().addingTimeInterval(0.01))
}
