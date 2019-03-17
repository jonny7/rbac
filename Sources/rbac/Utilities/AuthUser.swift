import Vapor
import Foundation

/// Defines a generic User ID
public protocol AuthUser: Codable {
    /// Type of the User's ID
    typealias UserKey = WritableKeyPath<Self, String>
    /// The key under which the user's username,
    /// email, or other identifing value is stored.
    static var userKey: UserKey { get }
}
