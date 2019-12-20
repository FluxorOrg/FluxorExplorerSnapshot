import AnyCodable
import Fluxor
import Foundation

public struct FluxorExplorerSnapshot: Codable, Equatable {
    public let actionData: ActionData
    public let oldState: [String: AnyCodable]
    public let newState: [String: AnyCodable]
    public internal(set) var date: Date

    public init<State: Encodable>(action: Action, oldState: State, newState: State, date: Date = .init()) {
        self.actionData = .init(name: String(describing: type(of: action)), payload: action.encodablePayload)
        let encodedOldState = try! JSONEncoder().encode(oldState)
        self.oldState = try! JSONDecoder().decode([String: AnyCodable].self, from: encodedOldState)
        let encodedNewState = try! JSONEncoder().encode(newState)
        self.newState = try! JSONDecoder().decode([String: AnyCodable].self, from: encodedNewState)
        self.date = date
    }

    enum CodingKeys: String, CodingKey {
        case date
        case actionData = "action"
        case oldState
        case newState
    }

    public struct ActionData: Codable, Equatable {
        public let name: String
        public let payload: [String: AnyCodable]?

        init(name: String, payload: [String: AnyEncodable]?) {
            self.name = name
            self.payload = payload?.mapValues { AnyCodable($0.value) }
        }
    }
}
