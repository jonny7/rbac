import Vapor
import Fluent

public final class RBACMiddleware<Database, R>: Middleware where Database: SchemaSupporting & JoinSupporting, R: AuthUser {
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> Future<Response> {

        /// essentiall this will guard that user can perform the action on the route
        let path = request.http.url.path
        /// path is used for a firect route "api/v1/users"
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
    public static func makeService(for worker: Container) throws -> RBACMiddleware {
        return RBACMiddleware()
    }
}
