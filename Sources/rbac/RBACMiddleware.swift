import Vapor

public final class RBACMiddleware: Middleware {
    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        // use User ID from the cache, and query DB to clarify if they have access to the route
        return Future.map(on: request){
            return Response(http: HTTPResponse(status: .ok), using: request)
        }
    }
    
}
