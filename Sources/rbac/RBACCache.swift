import Vapor
import Fluent

/// Stores user ID
public final class RBACCache: Service {
    /// The internal storage.
    /// Uses the user as cache key and Array of Optional Route paths as User may not have access to any routes. See `RoutePath`
    private var storage: [ObjectIdentifier: [RoutePath]? ]
    
    /// Create a new rbac cache.
    public init() {
        self.storage = [:]
    }
    
    /// Access the cache using types.
    internal subscript<R>(_ type: R.Type) -> [RoutePath]? {
        get { return storage[ObjectIdentifier(R.self)] as? [RoutePath] }
        set { storage[ObjectIdentifier(R.self)] = newValue }
    }
}

// MARK: Request
extension Request {
    
    /// caches the user's ID
    ///
    /// - Parameter instance: R
    /// - Throws: throws if there was a problem
    public func setUserIdentifier<R>(_ instance: R) throws {
        let cache = try privateContainer.make(RBACCache.self)
        let a: [RoutePath]? = nil
        cache[R.self] = a
    }
    
    /*public func setUsersAvailablePermissions<R>(_ type: R.Type = R.self) throws {
    }*/
    
    /// gets the requested cached user
    ///
    /// - Parameter type: User Object
    /// - Returns: Cache for User (Optional)
    /// - Throws: thros if problem
    /*public func getUserIdentifier<R>(_ type: R.Type = R.self) throws -> R? {
        let cache = try privateContainer.make(RBACCache.self)
        return cache[R.self]
    }*/
    
    /// Check a user can access this request
    ///
    /// - Returns: Bool
    public func checkAccess() -> Bool {
        return true
    }
}
