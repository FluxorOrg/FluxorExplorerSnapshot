import AnyCodable
import Fluxor
@testable import FluxorExplorerSnapshot
import XCTest

final class FluxorExplorerSnapshotTests: XCTestCase {
    func testEqual() throws {
        let date = Date()
        var snapshot1 = FluxorExplorerSnapshot(action: TestAction(increment: 1), newState: State())
        snapshot1.date = date
        var snapshot2 = FluxorExplorerSnapshot(action: TestAction(increment: 1), newState: State())
        snapshot2.date = date
        XCTAssertTrue(snapshot1 == snapshot2)
    }

    func testNotEqualByAction() throws {
        let snapshot1 = FluxorExplorerSnapshot(action: TestAction(increment: 1), newState: State(count: 1))
        let snapshot2 = FluxorExplorerSnapshot(action: OtherTestAction(), newState: State(count: 1))
        XCTAssertFalse(snapshot1 == snapshot2)
    }

    func testNotEqualByState() throws {
        let snapshot1 = FluxorExplorerSnapshot(action: TestAction(increment: 1), newState: State(count: 1))
        let snapshot2 = FluxorExplorerSnapshot(action: TestAction(increment: 1), newState: State(count: 2))
        XCTAssertFalse(snapshot1 == snapshot2)
    }
}

struct TestAction: Action {
    let increment: Int
    var encodablePayload: [String: AnyEncodable]? {
        ["increment": AnyEncodable(increment)]
    }
}

struct OtherTestAction: Action {}
struct State: Codable {
    var count = 42
}
