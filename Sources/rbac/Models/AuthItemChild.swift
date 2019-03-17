import Vapor
import Fluent
import Foundation

public final class AuthItemChild<Database>: Model where Database: SchemaSupporting & JoinSupporting {
    
    /// See Model.ID
    public typealias ID = UUID
    
    /// See Model.idKey
    public static var idKey: IDKey { return \.id }
    
    /// id for AuthItemChild
    public var id: UUID?
    
    /// AuthItem parent eg role "contributor"
    public var parent: AuthItem<Database>.ID
    
    /// AuthItem child eg "contributor" role is parent of route "post/edit"
    public var child: AuthItem<Database>.ID
    
    /// Creates a new child item
    public init(parent: UUID, child: UUID){
        self.parent = parent
        self.child = child
    }
}

extension AuthItemChild: AnyMigration, Migration where
Database: SchemaSupporting & MigrationSupporting {
    
    public static func prepare(on connection: Database.Connection) -> EventLoopFuture<Void> {
        return Database.create(AuthItemChild<Database>.self, on: connection) { builder in
            builder.field(for: \AuthItemChild<Database>.id)
            builder.field(for: \AuthItemChild<Database>.parent)
            builder.field(for: \AuthItemChild<Database>.child)
        }
    }
    
    public static func revert(on connection: Database.Connection) -> EventLoopFuture<Void> {
        return Database.delete(AuthItemChild<Database>.self, on: connection)
    }
}
