import SwiftUI


public struct NavigationHeaderStyle: ViewModifier {
  private var kid: Kid
  @Environment(\.colorScheme) var colorScheme
  
  public init(kid: Kid) {
    self.kid = kid
  }
  
  public func body(content: Content) -> some View {
    content
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          HStack {
            KID_AVATAR_VIEW(kid: kid, monsterHeight: 24, size: CGSize(width: 40, height: 40), scheme: colorScheme)
            VStack(alignment: .leading) {
              Text(kid.fullNameOrNickname)
                .font(.body).fontWeight(.medium)
                .foregroundColor(.primary)
              Text("\(DateUtils.ageString(style: .abbreviated, from: kid.dateOfBirth)) - \(charabias.count) charabias")
                .font(.caption).fontWeight(.semibold)
                .foregroundColor(Color.secondary)
            }
          }
        }
      }
  }
  
  private var AVATAR_VIEW: some View {
    VStack {
      ZStack {
        Circle()
          .foregroundColor(colorScheme == .dark ? SwiftUI.Color(hex: "1c1c1e") : SwiftUI.Color(hex: "f2f2f7"))
        if let monster = kid.monster {
          Image(monster)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 24)
        } else {
          KID_PLACEHOLDER
        }
      }
      .frame(width: 40, height: 40)
      .clipped()
    }
  }
  
  private var KID_PLACEHOLDER: some View {
    Text(nameInitials(name: kid.fullName)?.uppercased() ?? "")
      .fontWeight(.bold)
      .font(.subheadline)
  }
}


public extension View {
  func navigationHeaderStyle(kid: Kid) -> some View {
    self.modifier(NavigationHeaderStyle(kid: kid
))
  }
}


public func nameInitials(name: String) -> String? {
  let formatter = PersonNameComponentsFormatter()
  if let components = formatter.personNameComponents(from: name) {
    formatter.style = .abbreviated
    return formatter.string(from: components)
  }
  return nil
}
