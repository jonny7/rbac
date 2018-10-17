import Vapor
import Fluent

public final class RBACMiddleware<Database, R>: Middleware where Database: SchemaSupporting & JoinSupporting, R: AuthUser {
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> Future<Response> {

        // essentiall this will guard that user can perform the action on the route
        let path = request.http.url.path
        let permissions = AuthItemChild<Database>
                            .query(on: request)
                            .join(\AuthItem<Database>.id, to: \AuthItemChild<Database>.parent)
                            .join(\AuthAssignment<Database, R>.authItemId, to: \AuthItem<Database>.id)
                            .filter(\AuthItem<Database>.name == path)
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
