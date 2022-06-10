import SwiftUI


public struct ShareCharabiaView: View {
  private let charabia: Charabia
  private var cardColors: [Color] = [.blue, .yellow, .mint, .pink, .indigo, .orange, .teal, .gray]
  
  @Environment(\.dismiss) var dismiss
  @Environment(\.colorScheme) var colorScheme
  
  @State private var imageToShare: Image?
  @State private var selectedColor: Color = .blue
  @State private var includeBackgroundPattern = true
  
  init(charabia: Charabia) {
    self.charabia = charabia
  }
  
  public var body: some View {
    NavigationStack {
      ZStack {
        Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
        
        VStack {
          Spacer()
          
          VScrollView { VERTICAL_CARD() }
          
          Spacer()
          
          VStack(spacing: 28) {
            VStack(spacing: 16) {
              COLORS_SELECTION
              BACKGROUND_TOGGLE
            }.frame(width: 280)
            
            SHARE_BUTTON
          }
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Share charabia")
      .navigationBarItems(
        leading: Button(action: { dismiss() }, label: { Text("Dismiss") }))
    }
    .onAppear {
      self.selectedColor = charabia.color
      let renderer = ImageRenderer(content: VERTICAL_CARD(radius: 0))
      if let image = renderer.cgImage { self.imageToShare = Image(image, scale: 1, label: Text("Charabia Image")) }
    }
  }
}


// MARK: - SUBVIEWS
extension ShareCharabiaView {
  private func VERTICAL_CARD(radius: CGFloat = 20) -> some View {
    VStack {
      HEADER.padding(.top, 8)
      VStack(spacing: 16) {
        IMAGE_IN_BOX.padding(.bottom, 10)
        CHARADE.padding(.horizontal, 12)
      }.padding(.vertical, 16)
      FOOTER
    }
    .frame(width: 320)
    .background(
      GeometryReader { proxy in
        Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
        Image("top-left")
          .position(x: 90, y: 10)
        Image("top-right")
          .position(x: proxy.size.width, y: proxy.size.height / 2)
          .offset(x: -10, y: -proxy.size.height / 5)
        Image("bottom-right")
          .position(x: 20, y: proxy.size.height)
          .offset(y: -proxy.size.height / 6)
      }.opacity(includeBackgroundPattern ? 1 : 0)
    )
    .background(selectedColor.gradient)
    .cornerRadius(radius)
    .clipped()
  }
  
  private var COLORS_SELECTION: some View {
    HStack {
      ForEach(cardColors, id: \.gradient) { color in
        Circle()
          .fill(color.gradient)
          .frame(width: 24, height: 24)
          .addBorder(colorScheme == .dark ? Color.white : Color.black, width: selectedColor == color ? 2 : 0, cornerRadius: 24 / 2)
          .onTapGesture { withAnimation { selectedColor = color } }
        if color != .gray { Spacer() }
      }
    }
  }
  
  private var BACKGROUND_TOGGLE: some View {
    Toggle(isOn: $includeBackgroundPattern.animation(.spring())) {
      Text("Include pattern")
        .font(.system(size: 14, weight: .bold, design: .default))
    }
  }
  
  private var IMAGE_IN_BOX: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(selectedColor)
        .frame(width: 80, height: 80)
      Text(charabia.emoji).font(.system(size: 50, weight: .bold, design: .monospaced))
    }
  }
  
  private var CHARADE: some View {
    VStack(spacing: 10) {
      VStack {
        Text("Gibberish".uppercased())
          .font(.avenirNext(.semiBold, size: 14))
          .foregroundColor(Color.black.opacity(0.6))
        Text(charabia.gibberish.firstUppercased)
          .foregroundColor(Color.black)
          .fixedSize(horizontal: false, vertical: true)
          .multilineTextAlignment(.center)
          .font(.lovelyKids(size: 36, fixed: true))
      }
      Image(systemName: "arrow.down")
        .foregroundColor(.orange)
        .font(.system(size: 20, weight: .medium, design: .default))
      VStack {
        Text("Meaning".uppercased())
          .font(.avenirNext(.semiBold, size: 14))
          .foregroundColor(Color.black.opacity(0.6))
        Text(charabia.meaning.firstUppercased)
          .fixedSize(horizontal: false, vertical: true)
          .multilineTextAlignment(.center)
          .font(.lovelyKids(size: 36, fixed: true))
          .foregroundColor(Color.black)
      }
    }
  }
  
  private var HEADER: some View {
    HStack {
      HStack {
        KID_AVATAR_VIEW(kid: adji, size: CGSize(width: 50, height: 50), scheme: colorScheme, bgColor: selectedColor)
          .addBorder(Color.white, width: 0, cornerRadius: 50)
        VStack(alignment: .leading, spacing: 0) {
          Text(adji.fullName)
            .font(.avenirNext(.semiBold, size: 18))
            .foregroundColor(Color.black)
          Text(DateUtils.ageString(style: .full, from: adji.dateOfBirth))
            .font(.avenirNext(.semiBold, size: 14))
            .foregroundColor(Color.black.opacity(0.6))
        }
      }
      Spacer()
    }
    .padding(.horizontal, 16)
  }
  
  private var FOOTER: some View {
    HStack {
      Spacer()
      HStack(spacing: 4) {
        Image(systemName: "pencil.and.outline")
        Text("charabia.app")
          .font(.avenirNext(.semiBold, size: 14))
      }
      .foregroundColor(Color.black.opacity(0.6))
      Spacer()
    }
    .padding(.horizontal, 16)
    .padding(.bottom, 10)
  }
  
  private var SHARE_BUTTON: some View {
    VStack {
      if let imageToShare {
        ShareLink(item: imageToShare, preview: SharePreview("charabia", image: imageToShare)) {
          Text("Share Now")
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(RoundedRectangle(cornerRadius: 8).fill(selectedColor))
            .padding(.horizontal, 32)
        }
      }
    }
  }
}
