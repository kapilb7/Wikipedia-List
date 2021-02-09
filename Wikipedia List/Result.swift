
import Foundation

// MARK: - Wiki
struct Wiki: Codable {
    let batchcomplete: String
    let query: Query
}

// MARK: - Query
struct Query: Codable {
    let pages: [String: Page]
}

// MARK: - Page
struct Page: Codable {
    let pageid, ns: Int
    let title: String
    let thumbnail: Thumbnail?
    let terms: [String: [String]]?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let source: String
    let width, height: Int
}
