import Vapor

/// Stores user ID
public final class RBACCache: Service {
    /// The internal storage.
    private var storage: [ObjectIdentifier: Any]
    
    /// Create a new rbac cache.
    public init() {
        self.storage = [:]
    }
    
    /// Access the cache using types.
    internal subscript<A>(_ type: A.Type) -> A?
    {
        get { return storage[ObjectIdentifier(A.self)] as? A }
        set { storage[ObjectIdentifier(A.self)] = newValue }
    }
}

// MARK: Request
extension Request {
    // cache's the user's ID, 
    public func userIdentifier<A>(_ instance: A) throws
    {
        let cache = try privateContainer.make(RBACCache.self)
        cache[A.self] = instance
    }
}
