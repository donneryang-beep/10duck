import Foundation

struct MediaItem: Identifiable, Codable {
    let id: String
    let title: String
    let platform: String
    let thumbnail: String
    let date: Date
    let url: String
    var isSaved: Bool = false
    var downloadedPath: String? = nil
}
