import SwiftUI

struct ContentView: View {
  @State private var selectedCharabia: Charabia?
  private var gridItems: [GridItem] { [GridItem(.adaptive(minimum: 160), spacing: 16)] }
  
  var body: some View {
    HStack(alignment: .top) {
      ScrollView {
        VStack(spacing: 8) {
          // Text(" ").hidden() // Workaround to show the sharing modal
          LazyVGrid(columns: gridItems, spacing: 16) {
            ForEach(charabias) { charabia in
              VStack {
                Button(action: { self.selectedCharabia = charabia }) {
                  CharabiaItemView(charabia: charabia).frame(minHeight: 160)
                }
              }
            }
          }
          .padding(16)
        }
      }
    }
    .background(backgroundPatternView)
    .navigationHeaderStyle(kid: adji)
    .sheet(item: $selectedCharabia, content: { charabia in
      ShareCharabiaView(charabia: charabia)
        .presentationDetents([.large])
    })
  }
  
  private var backgroundPatternView: some View {
    ZStack(alignment: .top) {
      Color(UIColor.secondarySystemBackground)
        .edgesIgnoringSafeArea(.all)
      Image("main-background")
        .resizable()
        .aspectRatio(contentMode: .fill)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
