import AnyCodable
import Fluxor
import Foundation

public struct FluxorExplorerSnapshot: Codable, Equatable {
    public let actionData: ActionData
    public let newState: [String: AnyCodable]
    public internal(set) var date: Date

    public init<State: Encodable>(action: Action, newState: State, date: Date = .init()) {
        self.actionData = .init(name: String(describing: type(of: action)), payload: action.encodablePayload)
        let encodedState = try! JSONEncoder().encode(newState)
        self.newState = try! JSONDecoder().decode([String: AnyCodable].self, from: encodedState)
        self.date = date
    }

    enum CodingKeys: String, CodingKey {
        case date
        case actionData = "action"
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
