// swiftlint:disable all
import Amplify
import Foundation

extension CoordinateData {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case longitude
    case latitude
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let coordinateData = CoordinateData.keys
    
    model.pluralName = "CoordinateData"
    
    model.fields(
      .field(coordinateData.longitude, is: .optional, ofType: .double),
      .field(coordinateData.latitude, is: .optional, ofType: .double)
    )
    }
}