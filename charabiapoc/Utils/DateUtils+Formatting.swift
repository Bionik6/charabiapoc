import Foundation

public struct DateUtils {
  
  public static func string(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter.string(from: date)
  }
  
  public static func ageString(style: DateComponentsFormatter.UnitsStyle, from start: Date, to: Date = Date()) -> String {
    let components = age(between: start, end: to)
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = style
    formatter.allowedUnits = [.month, .year]
    formatter.zeroFormattingBehavior = .pad
    if let day = components.day, let month = components.month, let year = components.year, day == 0, month == 0, year == 0 {
      return NSLocalizedString("utils.born_today", tableName: "shared", comment: "")
    }
    if let days = components.day, let month = components.month, let year = components.year, month == 0, year == 0, days >= 1 {
      formatter.allowedUnits = [.day]
      formatter.unitsStyle = .full
    }
    if let month = components.month, let year = components.year, month >= 1, year == 0 {
      formatter.allowedUnits = [.month]
      formatter.unitsStyle = .full
    }
    if let month = components.month, let year = components.year, month == 0, year >= 1 {
      formatter.allowedUnits = [.year]
      formatter.unitsStyle = .full
    }
    return formatter.string(from: components) ?? NSLocalizedString("utils.born_today", tableName: "shared", comment: "")
  }
  
  private static func age(between start: Date, end: Date) -> DateComponents {
    let calendar = Calendar.current
    let date1 = calendar.startOfDay(for: start)
    let date2 = calendar.startOfDay(for: end)
    return calendar.dateComponents([.year, .month, .day], from: date1, to: date2)
  }
}


func date(year: Int, month: Int, day: Int) -> Date {
  var calendar = Calendar(identifier: .gregorian)
  let components = DateComponents(year: year, month: month, day: day)
  return calendar.date(from: components)!
}
