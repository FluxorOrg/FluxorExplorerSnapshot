import Fluxor
@testable import FluxorExplorerSnapshot
import XCTest

final class FluxorExplorerSnapshotTests: XCTestCase {
    func testEqual() {
        let date = Date()
        var snapshot1 = FluxorExplorerSnapshot(action: TestAction(), newState: State())
        snapshot1.date = date
        var snapshot2 = FluxorExplorerSnapshot(action: TestAction(), newState: State())
        snapshot2.date = date
        XCTAssertTrue(snapshot1 == snapshot2)
    }

    func testNotEqualByAction() {
        let snapshot1 = FluxorExplorerSnapshot(action: TestAction(), newState: State(count: 1))
        let snapshot2 = FluxorExplorerSnapshot(action: OtherTestAction(), newState: State(count: 1))
        XCTAssertFalse(snapshot1 == snapshot2)
    }

    func testNotEqualByState() {
        let snapshot1 = FluxorExplorerSnapshot(action: TestAction(), newState: State(count: 1))
        let snapshot2 = FluxorExplorerSnapshot(action: TestAction(), newState: State(count: 2))
        XCTAssertFalse(snapshot1 == snapshot2)
    }
}

struct TestAction: Action {}
struct OtherTestAction: Action {}
struct State: Encodable {
    var count = 42
}
