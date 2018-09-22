
import PerfectHTTP
import PerfectHTTPServer
import MongoKitten
import SwiftRandom

func handler(request: HTTPRequest, response: HTTPResponse) {
do {
	let server = try Server("mongodb://localhost")
	//let database = server["caca"]
	let database = Database(named: "sandbox", atServer: server)
	let usersCollection = database["events"]

	let documentArray = Array(try usersCollection.find())
	print(documentArray)


} catch {

}


// Respond with a simple message.
	response.setHeader(.contentType, value: "text/html")
	response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
	// Ensure that response.completed() is called when your processing is done.
	response.completed()
}

// Configure one server which:
//	* Serves the hello world message at <host>:<port>/
//	* Serves static files out of the "./webroot"
//		directory (which must be located in the current working directory).
//	* Performs content compression on outgoing data when appropriate.
var routes = Routes()
routes.add(method: .get, uri: "/", handler: handler)
routes.add(method: .get, uri: "/**",
		   handler: StaticFileHandler(documentRoot: "./webroot", allowResponseFilters: true).handleRequest)
try HTTPServer.launch(name: "localhost",
					  port: 8181,
					  routes: routes,
					  responseFilters: [
						(PerfectHTTPServer.HTTPFilter.contentCompression(data: [:]), HTTPFilterPriority.high)])
