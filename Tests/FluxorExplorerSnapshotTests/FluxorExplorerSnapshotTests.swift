import AnyCodable
import Fluxor
@testable import FluxorExplorerSnapshot
import XCTest

final class FluxorExplorerSnapshotTests: XCTestCase {
    let action = TestAction(increment: 1)
    let otherAction = OtherTestAction()
    let state = State()
    let otherState = State(count: 1337)
    let date = Date(timeIntervalSince1970: 1576706397)
    let json = #"{"date":598399197,"action":{"name":"TestAction","payload":{"increment":1}},"newState":{"count":42}}"#

    func testEqual() throws {
        let snapshot1 = FluxorExplorerSnapshot(action: action, newState: state, date: date)
        let snapshot2 = FluxorExplorerSnapshot(action: action, newState: state, date: date)
        XCTAssertTrue(snapshot1 == snapshot2)
    }

    func testNotEqualByAction() throws {
        let snapshot1 = FluxorExplorerSnapshot(action: action, newState: state, date: date)
        let snapshot2 = FluxorExplorerSnapshot(action: otherAction, newState: state, date: date)
        XCTAssertFalse(snapshot1 == snapshot2)
    }

    func testNotEqualByState() throws {
        let snapshot1 = FluxorExplorerSnapshot(action: action, newState: state, date: date)
        let snapshot2 = FluxorExplorerSnapshot(action: action, newState: otherState, date: date)
        XCTAssertFalse(snapshot1 == snapshot2)
    }

    func testInitWithActionAndState() throws {
        let snapshot = FluxorExplorerSnapshot(action: action, newState: state, date: date)
        XCTAssertEqual(snapshot.actionData.name, "TestAction")
        XCTAssertEqual(snapshot.actionData.payload, ["increment": AnyCodable(action.increment)])
        XCTAssertEqual(snapshot.newState, ["count": AnyCodable(state.count)])
    }

    func testEncode() throws {
        let snapshot = FluxorExplorerSnapshot(action: action, newState: state, date: date)
        let data = try JSONEncoder().encode(snapshot)
        XCTAssertEqual(String(data: data, encoding: .utf8), json)
    }

    func testDecode() throws {
        let data = json.data(using: .utf8)!
        let snapshot = try JSONDecoder().decode(FluxorExplorerSnapshot.self, from: data)
        let expectedSnapshot = FluxorExplorerSnapshot(action: action, newState: state, date: date)
        XCTAssertEqual(snapshot, expectedSnapshot)
    }
}

struct TestAction: Action {
    let increment: Int
    var encodablePayload: [String: AnyEncodable]? {
        ["increment": AnyEncodable(increment)]
    }
}

struct OtherTestAction: Action {}
struct State: Encodable {
    var count = 42
}
