## This is still a work in progress ##

# Vapor RBAC

Vapor RBAC provides a simple, but powerful hierarchial role based access control system, based on the [NIST model](https://csrc.nist.gov/Projects/Role-Based-Access-Control)

It is built generically for all major RDBS and provides fine granular control over users and their authroizations

# Installation

```swift
dependencies: [
    ...,
   .package(url: "https://github.com/jonny7/rbac", from: "0.0.6")
]

# Usage