import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectLogger

// --------
LogFile.location = "./customLogFile.log"
let eventid = LogFile.info("Server Setup message")
let server = HTTPServer()

// --------
// ROUTES

var routes = Routes(baseUri:"/api/v1")

func JSONMessage(message: String, response: HTTPResponse) {
    do {
        try response.setBody(json: ["message" : message])
            .setHeader(.contentType, value: "application/json")
            .completed()
    } catch {
        response.setBody(string: "Error in handling request: \(error)")
            .completed(status: .internalServerError)
    }
}


routes.add(method: .get, uri: "/hello", handler: {
    request, response in
    JSONMessage(message: "Hello, JSON!", response: response)
})

// --------
// SERVER

server.addRoutes(routes)


server.serverPort = 8181
server.documentRoot = "webroot"

LogFile.info("Server port is: \(server.serverPort)", eventid: eventid)
LogFile.debug("Demonstrating a logging event without the linked event id")

do {
    LogFile.info("Starting server", eventid: eventid)
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
