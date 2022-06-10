import SwiftUI

public enum AvenirNext: String {
  case light = "AvenirNext-UltraLight"
  case regular = "AvenirNext-Regular"
  case medium = "AvenirNext-Medium"
  case semiBold = "AvenirNext-DemiBold"
  case bold = "AvenirNext-Bold"
  case heavy = "AvenirNext-Heavy"
}

public enum LovelyKids: String {
  case regular = "Lovely Kids"
}


extension Font {
  
  public static func avenirNext(_ avenir: AvenirNext, size: CGFloat) -> Font {
    return .custom(avenir.rawValue, size: size, relativeTo: .body)
  }
  
  public static func lovelyKids(size: CGFloat, fixed: Bool = false) -> Font {
    if fixed {
      return .custom(LovelyKids.regular.rawValue, fixedSize: size)
    }
    return .custom(LovelyKids.regular.rawValue, size: size, relativeTo: .body)
  }
  
}
