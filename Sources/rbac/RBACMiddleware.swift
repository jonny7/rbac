import Vapor

public final class RBACMiddleware: Middleware {
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> Future<Response> {
        // use User ID from the cache, and query DB to clarify if they have access to the route
        /*return Future.map(on: request){
            return Response(http: HTTPResponse(status: .ok), using: request)
        }*/
        // essentiall this will guard that user can perform the action on the route
        guard 1 > 2 else {
            throw Abort(.unauthorized, reason: "You are not authorized to perform this action")
        }
        return try next.respond(to: request)
        
    }
}

extension RBACMiddleware: ServiceType {
    public static func makeService(for worker: Container) throws -> RBACMiddleware {
        return RBACMiddleware()
    }
}
