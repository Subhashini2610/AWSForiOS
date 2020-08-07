// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "b23b060ba9b0e848cc1d5895a4cfb1d5"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: LandmarkData.self)
  }
}