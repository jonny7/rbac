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

Register the RBAC Middleware as a service
```swift
    services.register(RBACMiddleware.self)
```

Then add the needed DB models as a migration inside `Sources/App/configure.swift`
```swift
    migrations.add(model: AuthAssignment.self, database: .sqlite)
    migrations.add(model: AuthItem.self, database: .sqlite)
    migrations.add(model: AuthItemChild.self, database: .sqlite)
    migrations.add(model: AuthRule.self, database: .sqlite)
```

# Usage

You can simply apply the middleare to routes with something like:
```swift
    router.group(RBACMiddleware.self){ rbacRoute in
        rbacRoute.get("demo"){ req in
            return "you passed"
        }
    }
```