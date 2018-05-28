// To parse the JSON, add this file to your project and do:
//
//   let login = try? JSONDecoder().decode(Login.self, from: jsonData)

import Foundation

struct Login: Codable {
    let result: String
    let url: String
}
