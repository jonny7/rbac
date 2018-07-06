import Service

/// Adds the RBAC service to the container
public final class RBACProvider: Provider {
    /// See Provider.repositoryName
    public static var repositoryName: String = "rbac"
    
    /// Create a new authentication provider
    public init() { }
    
    /// See Provider.register
    public func register(_ services: inout Services) throws {
        services.register { container in
            return RBACCache()
        }
    }
    
    /// See Provider.boot
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
    

}
