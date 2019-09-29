import Foundation

/// Used to house the url path and the request types available for this route
// used in part of the caching mechanism
public struct RoutePath {
    public var id: UUID
    public var path: String
    public var requestType: RequestType?
    
    public init(id: UUID, path: String, requestType: RequestType){
        self.id = id
        self.path = path
        self.requestType = requestType
    }
}
