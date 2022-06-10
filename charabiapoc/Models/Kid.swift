import Foundation

public struct Kid: Identifiable, Equatable {
  
  public private(set) var id: String
  public private(set) var firstName: String
  public private(set) var lastName: String
  public private(set) var nickname: String?
  public private(set) var monster: String?
  public private(set) var dateOfBirth: Date

  var fullNameOrNickname: String {
    return nickname?.capitalized ?? firstName.capitalized
  }
  
  public var fullName: String {
    return firstName + " " + lastName
  }
  
  public static func == (lhs: Kid, rhs: Kid) -> Bool {
    return lhs.id == rhs.id
  }
  
  public init(
    id: String,
    firstName: String,
    lastName: String,
    dateOfBirth: Date,
    nickname: String? = nil,
    monster: String? = nil
  ) {
    self.id = id
    self.monster = monster
    self.lastName = lastName
    self.nickname = nickname
    self.firstName = firstName
    self.dateOfBirth = dateOfBirth
  }
}
