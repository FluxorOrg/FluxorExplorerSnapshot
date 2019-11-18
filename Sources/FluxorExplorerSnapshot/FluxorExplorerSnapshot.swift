import AnyCodable
import Fluxor
import Foundation

public struct FluxorExplorerSnapshot<State: Encodable>: Encodable, Equatable {
    public let action: Action
    public let newState: State
    internal var date = Date()
    private var actionData: ActionData { .init(name: String(describing: action), payload: action.encodablePayload) }

    public init(action: Action, newState: State) {
        self.action = action
        self.newState = newState
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

    private struct ActionData: Encodable, Equatable {
        let name: String
        let payload: [String: AnyEncodable]?
    }

    public static func ==(lhs: FluxorExplorerSnapshot, rhs: FluxorExplorerSnapshot) -> Bool {
        let lhsData = try? JSONEncoder().encode(lhs)
        let rhsData = try? JSONEncoder().encode(rhs)
        return lhsData == rhsData
    }
}
