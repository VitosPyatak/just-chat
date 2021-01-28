import Foundation

protocol MessageProtocol: Codable {
    var type: String { get set }
}
