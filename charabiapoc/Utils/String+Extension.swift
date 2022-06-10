public extension StringProtocol {
  var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
  var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
