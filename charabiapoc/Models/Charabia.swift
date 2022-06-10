import SwiftUI
import Foundation


public class Charabia: Identifiable {
  public private(set) var id: String
  public private(set) var gibberish: String
  public private(set) var meaning: String
  public private(set) var emoji: String
  public private(set) var sayingDate: Date
  public private(set) var creationDate: Date
  public private(set) var color: Color
  public var isFavorite: Bool
  public var author: Kid?
  
  public init(
    id: String,
    gibberish: String,
    meaning: String,
    emoji: String,
    sayingDate: Date,
    creationDate: Date,
    isFavorite: Bool = false,
    color: Color,
    author: Kid?
  ) {
    self.id = id
    self.gibberish = gibberish
    self.meaning = meaning
    self.emoji = emoji
    self.color = color
    self.sayingDate = sayingDate
    self.creationDate = creationDate
    self.author = author
    self.isFavorite = isFavorite
  }
}
