import Vapor
import Fluent
import Foundation

public final class AuthItem<Database>: Model where Database: SchemaSupporting {
    
    /// See Model.ID
    public typealias ID = UUID
    
    /// See Model.idKey
    public static var idKey: IDKey { return \.id }
    
    /// id for AuthItem
    public var id: UUID?
    
    /// name for AuthItem -> "Standard User" etc
    public var name: String
    
    /// type for AuthItem, @todo make this a type, 1 is a role, 2 is a permission
    public var type: Int
    
    /// optional description to help identify what each permission/role does, useful for large numbers of permission groups
    public var description: String?
    
    /// what rule do you want to attach to this AuthItem
    /// examples, might be that User.userId == Posts.userId, so only the person who created the post can edit it
    public var rule: UUID?
    
    /// the additional data associated with this item
    public var data: String? // @todo this may be unused
    
    public init(name: String, type: Int){
        self.name = name
        self.type = type
    }
}

extension AuthItem: AnyMigration, Migration where
Database: SchemaSupporting & MigrationSupporting {
    
    public static func prepare(on connection: Database.Connection) -> EventLoopFuture<Void> {
        return Database.create(AuthItem<Database>.self, on: connection) { builder in
            builder.field(for: \AuthItem<Database>.id)
            builder.field(for: \AuthItem<Database>.name)
            builder.field(for: \AuthItem<Database>.type)
            builder.field(for: \AuthItem<Database>.description)
            builder.field(for: \AuthItem<Database>.rule)
            builder.field(for: \AuthItem<Database>.data)
        }
    }
    
    public static func revert(on connection: Database.Connection) -> EventLoopFuture<Void> {
        return Database.delete(AuthItem<Database>.self, on: connection)
    }
}
