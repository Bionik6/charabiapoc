import SwiftUI

public struct CharabiaItemView: View {
  
  private var charabia: Charabia
  @State private var showCharabiaDetails: Bool = false
  
  public init(charabia: Charabia) {
    self.charabia = charabia
  }
  
  public var body: some View {
    VStack {
      imageInBox.padding(.vertical, 12)
      
      charade
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
    }
    .background(
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(Color(uiColor: UIColor.systemBackground))
    )
    .shadow(color: Color.black.opacity(0.06), radius: 10, x: 2, y: 4)
  }
  
  private var charade: some View {
    VStack(spacing: 10) {
      Text(charabia.gibberish.firstUppercased).charabiaTitleStyle()
      Image(systemName: "arrow.down")
        .foregroundColor(.orange)
        .font(.title3)
      Text(charabia.meaning.firstUppercased).charabiaTitleStyle()
    }
  }
  
  private var imageInBox: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(charabia.color.gradient)
        .frame(width: 60, height: 60)
      Text(charabia.emoji)
        .font(.system(size: 40, weight: .bold, design: .monospaced))
    }
  }
  
}


struct CharabiaItemView_Previews: PreviewProvider {
  static let charabia = Charabia.init(
    id: "",
    gibberish: "Dayi",
    meaning: "Les Chaussures",
    emoji: "🙏",
    sayingDate: Date(),
    creationDate: Date(),
    color: .purple,
    author: nil
  )
  static var previews: some View {
    Group {
      ZStack {
        Image("iPhoneBG")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .edgesIgnoringSafeArea(.all)
        CharabiaItemView(charabia: charabia)
      }
    }
  }
}
