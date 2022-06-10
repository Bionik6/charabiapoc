import SwiftUI
import Foundation

public struct CharabiaTextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .fixedSize(horizontal: false, vertical: true)
      .multilineTextAlignment(.center)
      .font(.lovelyKids(size: 30))
      .foregroundColor(Color.primary)
  }
}

public struct BigBoldHeadingTextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.avenirNext(.bold, size: 26))
      .lineSpacing(6.0)
      .frame(maxWidth: .infinity, alignment: .leading)
      .multilineTextAlignment(.leading)
  }
}

public struct NewEditCharabiaTextfieldStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .frame(height: 44)
      .fixedSize(horizontal: false, vertical: true)
      .multilineTextAlignment(.center)
      .font(.lovelyKids(size: 32, fixed: true))
      .foregroundColor(Color("darkTextColor"))
      .autocapitalization(.sentences)
      .disableAutocorrection(true)
      .padding()
  }
}

public extension View {
  func charabiaTitleStyle() -> some View {
    self.modifier(CharabiaTextStyle())
  }
  
  func bigBoldHeadingStyle() -> some View {
    self.modifier(BigBoldHeadingTextStyle())
  }
  
  func newEditCharabiaTextfieldStyle(when: Bool, placeholderText: String) -> some View {
    self.modifier(NewEditCharabiaTextfieldStyle())
      .placeholder(when: when, placeholder: {
        Text(placeholderText)
          .font(.lovelyKids(size: 32, fixed: true))
          .foregroundColor(Color("darkTextColor").opacity(0.4))
      })
  }
  
  func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
    let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
    return clipShape(roundedRect)
      .overlay(roundedRect.strokeBorder(content, lineWidth: width))
  }
  
  func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .center, @ViewBuilder placeholder: () -> Content) -> some View {
    ZStack(alignment: alignment) {
      placeholder().opacity(shouldShow ? 1 : 0)
      self
    }
  }
}
