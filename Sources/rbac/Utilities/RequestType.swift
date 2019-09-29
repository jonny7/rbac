/// Defines a request type eg - PUT, POST...
public struct RequestType: Codable {
    public var route: String
    
    public init(route: String){
        self.route = route
    }
}
