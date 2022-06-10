import SwiftUI

public struct VScrollView<Content>: View where Content: View {
  @ViewBuilder let content: Content
  
  public var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical, showsIndicators: true) {
        content
          .frame(width: geometry.size.width)
          .frame(minHeight: geometry.size.height)
      }
    }
  }
}
