/// `AuthItemType` represents the type of `AuthItem`
/// Could be a role 1:N or permission/route 1:1
public enum AuthItemType: String, Codable {
    case role
    case permissionOrRoute
}
