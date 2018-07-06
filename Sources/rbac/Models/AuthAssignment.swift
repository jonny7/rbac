import Vapor
import Fluent
import Foundation

public final class AuthAssignment<Database>: Model where Database: SchemaSupporting {
    
    /// See Model.ID
    public typealias ID = UUID
    
    /// See Model.idKey
    public static var idKey: IDKey { return \.id }
    
    /// Primary Key for this model
    public var id: UUID?
    
    /// user ID, this perhaps needs to be more generic type
    public var userId: UUID
    
    /// AuthItem assigned to User
    public var authItemId: AuthItem<Database>.ID
    
    public init(userId: UUID, authItemId: UUID){
        self.userId = userId
        self.authItemId = authItemId
    }
}

extension AuthAssignment: AnyMigration, Migration where
Database: SchemaSupporting & MigrationSupporting {
    
    public static func prepare(on connection: Database.Connection) -> EventLoopFuture<Void> {
        return Database.create(AuthAssignment<Database>.self, on: connection) { builder in
            builder.field(for: \AuthAssignment<Database>.id)
            builder.field(for: \AuthAssignment<Database>.userId)
            builder.field(for: \AuthAssignment<Database>.authItemId)
            builder.reference(from: \AuthAssignment<Database>.authItemId, to: \AuthItem<Database>.id, onUpdate: nil, onDelete: nil)
        }
    }
    
    public static func revert(on connection: Database.Connection) -> EventLoopFuture<Void> {
        return Database.delete(AuthAssignment<Database>.self, on: connection)
    }
}
