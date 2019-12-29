import AnyCodable
import Foundation

public struct FluxorExplorerSnapshot: Codable, Equatable {
    public let actionData: ActionData
    public let oldState: [String: AnyCodable]
    public let newState: [String: AnyCodable]
    public internal(set) var date: Date

    public init<A: Encodable, State: Encodable>(action: A, oldState: State, newState: State) {
        self.init(action: action, oldState: oldState, newState: newState, date: .init())
    }

    internal init<A: Encodable, State: Encodable>(action: A, oldState: State, newState: State, date: Date) {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let encodedAction = try! encoder.encode(action)
        let actionPayload = try! decoder.decode([String: AnyCodable].self, from: encodedAction)
        self.actionData = .init(name: String(describing: type(of: action)), payload: actionPayload)
        let encodedOldState = try! encoder.encode(oldState)
        self.oldState = try! decoder.decode([String: AnyCodable].self, from: encodedOldState)
        let encodedNewState = try! encoder.encode(newState)
        self.newState = try! decoder.decode([String: AnyCodable].self, from: encodedNewState)
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
    }
}
