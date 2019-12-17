import AnyCodable
import Fluxor
import Foundation

public struct FluxorExplorerSnapshot<State: Codable>: Codable, Equatable {
    public let actionData: ActionData
    public let newState: [String: AnyCodable]
    public internal(set) var date: Date

    public init(action: Action, newState: State) {
        self.actionData = .init(name: String(describing: type(of: action)), payload: action.encodablePayload)
        let encodedState = try! JSONEncoder().encode(newState)
        self.newState = try! JSONDecoder().decode([String: AnyCodable].self, from: encodedState)
        self.date = Date()
    }

    enum CodingKeys: String, CodingKey {
        case date
        case actionData = "action"
        case newState
    }

    public struct ActionData: Codable, Equatable {
        let name: String
        let payload: [String: AnyCodable]?

        init(name: String, payload: [String: AnyEncodable]?) {
            self.name = name
            self.payload = payload?.mapValues { AnyCodable($0.value) }
        }
    }
}
