import SwiftUI

public func KID_AVATAR_VIEW(
  kid: Kid,
  monsterHeight: CGFloat = 28,
  size: CGSize = .init(width: 42, height: 42),
  scheme: ColorScheme,
  bgColor: SwiftUI.Color? = nil
) -> some View {
  VStack {
    ZStack {
      if let bgColor = bgColor {
        Circle().foregroundColor(bgColor)
      } else {
        Circle().foregroundColor(scheme == .dark ? SwiftUI.Color(hex: "1c1c1e") : SwiftUI.Color(hex: "f2f2f7"))
      }
      if let monster = kid.monster {
        Image(monster)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: monsterHeight)
      } else {
        KID_PLACEHOLDER(kid: kid)
      }
    }
    .frame(width: size.width, height: size.height)
    .clipped()
  }
}

private func KID_PLACEHOLDER(kid: Kid) -> some View {
  Text(nameInitials(name: kid.fullName)?.uppercased() ?? "")
    .fontWeight(.bold)
    .font(.subheadline)
}
