//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let components = NSURLComponents()
components.scheme = "https"
components.host = "api.flickr.com"
components.path = "/services/rest"
components.queryItems = [NSURLQueryItem]()

let queryItem1 = NSURLQueryItem(name: "method", value: "flickr.photos.search")
let queryItem2 = NSURLQueryItem(name: "api_key", value: "1234")
let queryItem3 = NSURLQueryItem(name: "text", value: "purple")

components.queryItems!.append(queryItem1)
components.queryItems!.append(queryItem2)
components.queryItems!.append(queryItem3)

print(components.URL!)
