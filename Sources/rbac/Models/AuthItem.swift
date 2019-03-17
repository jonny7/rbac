import Vapor
import Fluent
import Foundation

public final class AuthItem<Database>: Model where Database: SchemaSupporting & JoinSupporting {
    
    /// See Model.ID
    public typealias ID = UUID
    
    /// See Model.idKey
    public static var idKey: IDKey { return \.id }
    
    /// id for AuthItem
    public var id: UUID?
    
    /// name for AuthItem eg "Standard User" could be a role, "Can View Management Metrics" if a permission
    /// or even just a route "api/v1/user"
    public var name: String
    
    /// type for AuthItem, @todo make this a type, 1 is a role, 2 is a permission or route
    public var type: Int
    
    /// for an API, it may be neccessary to specify what type of request on the routes. ie, a user can "get" api/messages/1
    /// but they can't perform "put" api/messages/1.
    public var requestType: RequestType?
    
    /// optional description to help identify what each permission/role does, useful for large numbers of permission groups
    public var description: String?
    
    /// what rule do you want to attach to this AuthItem
    /// examples, might be that User.userId == Posts.userId, so only the person who created the post can edit it
    public var rule: UUID?
    
    public init(name: String, type: Int){
        self.name = name
        self.type = type
    }
}

extension AuthItem: AnyMigration, Migration where
Database: SchemaSupporting & MigrationSupporting {
    
    public static func prepare(on connection: Database.Connection) -> Future<Void> {
        return Database.create(AuthItem<Database>.self, on: connection) { builder in
            builder.field(for: \AuthItem<Database>.id)
            builder.field(for: \AuthItem<Database>.name)
            builder.field(for: \AuthItem<Database>.type)
            builder.field(for: \AuthItem<Database>.requestType)
            builder.field(for: \AuthItem<Database>.description)
            builder.field(for: \AuthItem<Database>.rule)
        }
    }
    
    public static func revert(on connection: Database.Connection) -> Future<Void> {
        return Database.delete(AuthItem<Database>.self, on: connection)
    }
}
