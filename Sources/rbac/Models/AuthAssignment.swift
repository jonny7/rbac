import Vapor
import Fluent
import Foundation

public final class AuthAssignment<Database, T>: Model where Database: SchemaSupporting & JoinSupporting, T: Codable {
    
    /// See Model.ID
    public typealias ID = UUID
    
    /// See Model.idKey
    public static var idKey: IDKey { return \.id }
    
    /// Primary Key for this model
    public var id: UUID?
    
    /// generic user ID, provides flexibilty for differing user ID types
    public var userId: T
    
    /// AuthItem assigned to User
    public var authItemId: AuthItem<Database>.ID
    
    public init(userId: T, authItemId: UUID){
        self.userId = userId
        self.authItemId = authItemId
    }
}

// build SQL constraints
extension AuthAssignment: AnyMigration, Migration where
Database: SchemaSupporting & MigrationSupporting {
    
    public static func prepare(on connection: Database.Connection) -> Future<Void> {
        return Database.create(AuthAssignment<Database, T>.self, on: connection) { builder in
            builder.field(for: \AuthAssignment<Database, T>.id)
            builder.field(for: \AuthAssignment<Database, T>.userId)
            builder.field(for: \AuthAssignment<Database, T>.authItemId)
            builder.reference(from: \AuthAssignment<Database, T>.authItemId, to: \AuthItem<Database>.id, onUpdate: nil, onDelete: nil)
        }
    }
    
    public static func revert(on connection: Database.Connection) -> Future<Void> {
        return Database.delete(AuthAssignment<Database, T>.self, on: connection)
    }
}
