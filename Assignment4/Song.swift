//
//  Song.swift
//  Assignment4
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation

struct Song {
  enum Style: String {
    case pop = "Pop"
    case rock = "Rock"
    case alternative = "Alternative"
    case rnb = "RnB"
    case hiphop = "Hiphop"
    case classical = "Classical"
  }
  // title of the song
  private(set) var title: String
  // artist of the song
  private(set) var artist: String
  // category of the song
  private(set) var category: Style
  // file size, stored in kilobytes
  private(set) var size: Int
  
  private let TITLE_MAX_LENGTH = 35
  private let ARTIST_MAX_LENGTH = 24
  
  init(title: String, artist: String, category: Style, size: Int) {
    self.title = title
    self.artist = artist
    self.category = category
    self.size = size
  }
  
  mutating func setSong(title: String, artist: String, category: Style, size: Int) {
    self.title = title
    self.artist = artist
    self.category = category
    self.size = size
  }
}

extension Song: CustomStringConvertible {
  // Size should be printed in Megabytes (use 1000 kilobytes = 1 MB for this calculation), to 1 decimal place.
  // The category abbreviations used should be: Pop, Rock, Alt, Cls, HH, RnB
  // Example:
  // | Title                               | Artist                   | Style       | Size (MB)
  var description: String {
    let STYLE_LENGTH = 11
    
    let START_STR = "| "
    let END_STR = " "
    
    var str = ""
    // title
    str.append(START_STR)
    str.append(title)
    for _ in 0..<(TITLE_MAX_LENGTH - title.count) {
      str.append(" ")
    }
    str.append(END_STR)
    // artist
    str.append(START_STR)
    str.append(artist)
    for _ in 0..<(ARTIST_MAX_LENGTH - artist.count) {
      str.append(" ")
    }
    str.append(END_STR)
    // style
    str.append(START_STR)
    str.append(category.rawValue)
    for _ in 0..<(STYLE_LENGTH - category.rawValue.count) {
      str.append(" ")
    }
    str.append(END_STR)
    // size (MB)
    str.append(START_STR)
    str.append(String(convert2MegaByte(size: size)))
    
    return str
  }
}

extension Song {
  //---------------------------------------------
  // Private Method
  //---------------------------------------------
  private func convert2MegaByte(size:Int) -> Double {
    return Double(size) / 1000
  }
  
}
