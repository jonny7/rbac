import Vapor
import Fluent
import Foundation

public final class AuthRule<Database>: Model where Database: SchemaSupporting {
    
    /// See Model.ID
    public typealias ID = UUID
    
    /// See Model.idKey
    public static var idKey: IDKey { return \.id }
    
    /// id for Model
    public var id: UUID?
    
    /// name of rule
    public var name: String
    
    // data included with this rule
    public var data: String
    
    public init(name: String, data: String){
        self.name = name
        self.data = data
    }
}

extension AuthRule: AnyMigration, Migration where
Database: SchemaSupporting & MigrationSupporting {
    
    public static func prepare(on connection: Database.Connection) -> EventLoopFuture<Void> {
        return Database.create(AuthRule<Database>.self, on: connection) { builder in
            builder.field(for: \AuthRule<Database>.id)
            builder.field(for: \AuthRule<Database>.name)
            builder.field(for: \AuthRule<Database>.data)
        }
    }
    
    public static func revert(on connection: Database.Connection) -> EventLoopFuture<Void> {
        return Database.delete(AuthRule<Database>.self, on: connection)
    }
}
