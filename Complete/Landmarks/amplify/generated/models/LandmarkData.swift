// swiftlint:disable all
import Amplify
import Foundation

public struct LandmarkData: Model {
  public let id: String
  public var name: String
  public var category: String?
  public var city: String?
  public var state: String?
  public var isFeatured: Bool?
  public var isFavorite: Bool?
  public var park: String?
  public var coordinates: CoordinateData?
  public var imageName: String?
  
  public init(id: String = UUID().uuidString,
      name: String,
      category: String? = nil,
      city: String? = nil,
      state: String? = nil,
      isFeatured: Bool? = nil,
      isFavorite: Bool? = nil,
      park: String? = nil,
      coordinates: CoordinateData? = nil,
      imageName: String? = nil) {
      self.id = id
      self.name = name
      self.category = category
      self.city = city
      self.state = state
      self.isFeatured = isFeatured
      self.isFavorite = isFavorite
      self.park = park
      self.coordinates = coordinates
      self.imageName = imageName
  }
}