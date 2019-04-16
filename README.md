## This is still a work in progress, and not currently ready for any use ##

# Vapor RBAC

Vapor RBAC provides a simple, but powerful hierarchial role based access control system, based on the [NIST model](https://csrc.nist.gov/Projects/Role-Based-Access-Control)

It is built generically for all major RDBS and provides fine granular control over users and their authroizations

# Installation

```swift
dependencies: [
    ...,
   .package(url: "https://github.com/jonny7/rbac", from: "0.0.6")
]
```

# Configuration

First, add the module to your `Sources/App/configure.swift`
```swift
    import rbac
```

Register the RBAC Middleware as a service also in `Sources/App/configure.swift`
```swift
    // register rbac
    services.register(RBACMiddleware.self)
    services.register(RBACCache.self) { container in
        return RBACCache()
    }

```

Then add the needed DB models as a migration inside `Sources/App/configure.swift`
Here you should replace `MySQLDatabase` with the relational database you are using
Replace UUID in the `AuthAssignment` model with the type the primary key of your user model is using
```swift
    migrations.add(model: AuthAssignment<MySQLDatabase,  UUID>.self, database: .sqlite)
    migrations.add(model: AuthItem<MySQLDatabase>.self, database: .sqlite)
    migrations.add(model: AuthItemChild<MySQLDatabase>.self, database: .sqlite)
    migrations.add(model: AuthRule<MySQLDatabase>.self, database: .sqlite)
```

# Usage

You can simply apply the middleware to routes with something like:
```swift
    router.group(RBACMiddleware.self){ rbacRoute in
        rbacRoute.get("demo"){ req in
            return "you passed"
        }
    }
```

# Roles, permissions and routes

This package uses a hierarchical system that essentially works like this:

**Routes** - These are the paths for your API. examples would be

`api/user/find`

`api/user/* -> All actions within a parent route group`

Routes can also specify a request type eg - get, put, post etc

Routes can then be grouped to form a permission. 
__Routes shouldn't be left in the wild, all routes should be assigned to a permission(s)__

**Permissions**

Permissions are groups of related routes.

