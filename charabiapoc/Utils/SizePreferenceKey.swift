import SwiftUI

public struct SizePreferenceKey: PreferenceKey {
  public static var defaultValue: CGSize = .zero
  public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
  public func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear.preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}
