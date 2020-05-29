/**
 * FluxorExplorerSnapshotTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import AnyCodable
import Fluxor
@testable import FluxorExplorerSnapshot
import XCTest

class FluxorExplorerSnapshotTests: XCTestCase {
    private let action = TestAction(increment: 1)
    private let otherAction = OtherTestAction()
    private let actionTemplte = ActionTemplate(id: "Set color", payloadType: String.self)
    private let oldState = State(count: 1)
    private let otherOldState = State(count: 2)
    private let newState = State(count: 3)
    private let otherNewState = State(count: 4)
    private let oldColorState = ColorState(color: "blue")
    private let newColorState = ColorState(color: "red")
    let date = Date(timeIntervalSince1970: 1576706397)
    let json = #"{"action":{"name":"TestAction","payload":{"increment":1}},"date":598399197,"newState":{"count":3},"oldState":{"count":1}}"#
    let anonymousJson = #"{"action":{"name":"Set color","payload":{"id":"Set color","payload":"red"}},"date":598399197,"newState":{"color":"red"},"oldState":{"color":"blue"}}"#

    func testEqual() throws {
        let snapshot1 = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: newState, date: date)
        let snapshot2 = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: newState, date: date)
        XCTAssertTrue(snapshot1 == snapshot2)
    }

    func testNotEqualByAction() throws {
        let snapshot1 = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: newState, date: date)
        let snapshot2 = FluxorExplorerSnapshot(action: otherAction, oldState: oldState, newState: newState, date: date)
        XCTAssertFalse(snapshot1 == snapshot2)
    }

    func testNotEqualByOldState() throws {
        let snapshot1 = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: newState, date: date)
        let snapshot2 = FluxorExplorerSnapshot(action: action, oldState: otherOldState, newState: newState, date: date)
        XCTAssertFalse(snapshot1 == snapshot2)
    }

    func testNotEqualByNewState() throws {
        let snapshot1 = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: newState, date: date)
        let snapshot2 = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: otherNewState, date: date)
        XCTAssertFalse(snapshot1 == snapshot2)
    }

    func testInitWithStateAndActionWithPayload() throws {
        let snapshot = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: newState, date: date)
        XCTAssertEqual(snapshot.actionData.name, "TestAction")
        XCTAssertEqual(snapshot.actionData.payload, ["increment": AnyCodable(action.increment)])
        XCTAssertEqual(snapshot.oldState, ["count": AnyCodable(oldState.count)])
        XCTAssertEqual(snapshot.newState, ["count": AnyCodable(newState.count)])
    }

    func testInitWithStateAndActionWithoutPayload() throws {
        let snapshot = FluxorExplorerSnapshot(action: otherAction, oldState: oldState, newState: newState, date: date)
        XCTAssertEqual(snapshot.actionData.name, "OtherTestAction")
        XCTAssertEqual(snapshot.actionData.payload, nil)
        XCTAssertEqual(snapshot.oldState, ["count": AnyCodable(oldState.count)])
        XCTAssertEqual(snapshot.newState, ["count": AnyCodable(newState.count)])
    }

    func testEncodeKnownAction() throws {
        let snapshot = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: newState, date: date)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try encoder.encode(snapshot)
        XCTAssertEqual(String(data: data, encoding: .utf8), json)
    }

    func testEncodeAnonymousAction() throws {
        let snapshot = FluxorExplorerSnapshot(action: actionTemplte.createAction(payload: "red"),
                                              oldState: oldColorState, newState: newColorState, date: date)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try encoder.encode(snapshot)
        XCTAssertEqual(String(data: data, encoding: .utf8), anonymousJson)
    }

    func testDecode() throws {
        let data = json.data(using: .utf8)!
        let snapshot = try JSONDecoder().decode(FluxorExplorerSnapshot.self, from: data)
        let expectedSnapshot = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: newState, date: date)
        XCTAssertEqual(snapshot, expectedSnapshot)
    }

    func testPublicInit() {
        let snapshot = FluxorExplorerSnapshot(action: action, oldState: oldState, newState: newState)
        XCTAssertLessThan(snapshot.date, Date())
    }
}

private struct TestAction: Action {
    let increment: Int
}

private struct OtherTestAction: Action {}

private struct State: Encodable {
    var count = 42
}

private struct ColorState: Encodable {
    var color = "blue"
}
