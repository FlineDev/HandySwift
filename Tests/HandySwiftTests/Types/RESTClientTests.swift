import Foundation
import Testing

@testable import HandySwift

@Suite("RESTClient Tests")
struct RESTClientTests {

   @Test("Complete multipart form-data integration")
   func completeMultipartFormDataIntegration() throws {
      struct TestModel: Codable, Sendable {
         let name: String
         let value: Int
      }

      let imageData = Data(repeating: 0xFF, count: 100)
      let testModel = TestModel(name: "test", value: 42)

      let multipartItems: [RESTClient.MultipartItem] = [
         .init(name: "model", value: .text("gpt-image-1")),
         .init(name: "prompt", value: .text("Generate a liquid glass icon")),
         .init(name: "quality", value: .text("high")),
         .init(name: "style", value: .text("natural")),
         .init(name: "size", value: .text("1024x1024")),
         .init(name: "image", value: .data(imageData, fileName: "input.png", mimeType: "image/png")),
         .init(name: "settings", value: .json(testModel)),
         .init(name: "file_no_meta", value: .data(Data("content".utf8), fileName: nil, mimeType: nil)),
      ]

      let body = RESTClient.Body.multipart(multipartItems)
      let contentType = body.contentType
      let httpData = try body.httpData(jsonEncoder: JSONEncoder())
      let dataString = String(decoding: httpData, as: UTF8.self)

      // Extract boundary for testing
      #expect(contentType.hasPrefix("multipart/form-data; boundary="))
      let boundary = String(contentType.dropFirst("multipart/form-data; boundary=".count))
      #expect(boundary.hasPrefix("handy-swift-boundary-"))

      // Build expected multipart structure with actual binary data
      let imageDataString = String(decoding: imageData, as: UTF8.self)  // Convert the actual imageData to string
      let expectedStructure = """
         --\(boundary)\r
         Content-Disposition: form-data; name="model"\r
         \r
         gpt-image-1\r
         --\(boundary)\r
         Content-Disposition: form-data; name="prompt"\r
         \r
         Generate a liquid glass icon\r
         --\(boundary)\r
         Content-Disposition: form-data; name="quality"\r
         \r
         high\r
         --\(boundary)\r
         Content-Disposition: form-data; name="style"\r
         \r
         natural\r
         --\(boundary)\r
         Content-Disposition: form-data; name="size"\r
         \r
         1024x1024\r
         --\(boundary)\r
         Content-Disposition: form-data; name="image"; filename="input.png"\r
         Content-Type: image/png\r
         \r
         \(imageDataString)\r
         --\(boundary)\r
         Content-Disposition: form-data; name="settings"\r
         Content-Type: application/json\r
         \r
         {"name":"test","value":42}\r
         --\(boundary)\r
         Content-Disposition: form-data; name="file_no_meta"\r
         \r
         content\r
         --\(boundary)--\r

         """

      // Verify the complete structure matches exactly what we expect
      #expect(dataString == expectedStructure)

      // Additional RFC 2046 compliance checks
      #expect(dataString.contains("\r\n"))
      #expect(!dataString.replacingOccurrences(of: "\r\n", with: "").contains("\n"))
      #expect(dataString.hasSuffix("--\(boundary)--\r\n"))

      // Verify boundary consistency and uniqueness
      #expect(dataString.components(separatedBy: "--\(boundary)").count >= 9)  // 8 items + final boundary

      let body2 = RESTClient.Body.multipart(multipartItems)
      let boundary2 = String(body2.contentType.dropFirst("multipart/form-data; boundary=".count))
      #expect(boundary != boundary2)  // Different instances have unique boundaries

      #expect(body.contentType == body.contentType)  // Same instance maintains consistent boundary
   }
}
