import Vapor
import Fluent
import Authentication
import Foundation

public final class RBACMiddleware<Database, R>: Middleware where Database: SchemaSupporting & JoinSupporting, R: ID {
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> Future<Response> {

        /// essentiall this will guard that user can perform the action on the route
        let path = request.http.url.path
        /// method is the type of request being sent, user may need access to `get` api/v1/user/1 but not `put`
        let method = request.http.method
        //let x = request.requireAuthenticated(AuthAssignment<Database, R>.self)
        /// path is used for a direct route "api/v1/users"
        /// can also use a permission or role name to access
        let permissions = AuthItem<Database>
            .query(on: request)
            .join(\AuthAssignment<Database, R>.authItemId, to: \AuthItem<Database>.id)
            .filter(\AuthItem<Database>.name == path)
            // and assignment == cached User
            // and the rule works if applied to route eg update user.id == post.userId
            .all()
        
        // @todo add in cache, for less DB reqs
        return try next.respond(to: request)
    }
}

extension RBACMiddleware: ServiceType {
    public static func makeService(for container: Container) throws -> RBACMiddleware {
        return RBACMiddleware()
    }
}
