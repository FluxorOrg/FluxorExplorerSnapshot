import AnyCodable
import Fluxor
import Foundation

public struct FluxorExplorerSnapshot<State: Codable>: Encodable, Equatable {
    public let actionData: ActionData
    public let newState: [String: AnyCodable]
    public internal(set) var date: Date

    public init(action: Action, newState: State) {
        self.actionData = .init(name: String(describing: type(of: action)), payload: action.encodablePayload)
        let encodedState = try! JSONEncoder().encode(newState)
        self.newState = try! JSONDecoder().decode([String: AnyCodable].self, from: encodedState)
        self.date = Date()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(actionData, forKey: .action)
        try container.encode(newState, forKey: .newState)
    }

    enum CodingKeys: String, CodingKey {
        case date
        case action
        case newState
    }

    public struct ActionData: Encodable, Equatable {
        let name: String
        let payload: [String: AnyEncodable]?
    }
}
