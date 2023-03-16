//
//  Player.swift
//  Assignment4
//
//  Created by H.Namikawa on 2023/03/15.
//

import Foundation

struct Player {
  //---------------------------------------------------------
  // Properties
  //---------------------------------------------------------
  private(set) var playlist:Playlist
  
  private enum MenuItem: String {
    case A = "A"
    case F = "F"
    case D = "D"
    case S = "S"
    case C = "C"
    case Z = "Z"
    case M = "M"
    case X = "X"
  }
  private let menuItems:[MenuItem] = [.A, .F, .D, .S, .C, .Z, .M, .X]
  private let menuItemDescriptions:[MenuItem:String] = [
    .A: "Add a song to the playlist",
    .F: "Find a song on the playlist",
    .D: "Delete a song from the playlist",
    .S: "Show the entire playlist",
    .C: "Category summary",
    .Z: "Show playlist size",
    .M: "Show this menu",
    .X: "Exit the program",
  ]
  
  private enum MsgId: String {
    case MSG001 = "MSG001"
    case MSG002 = "MSG002"
    case MSG003 = "MSG003"
    case MSG004 = "MSG004"
    case MSG005 = "MSG005"
    case MSG006 = "MSG006"
    case MSG007 = "MSG007"
    case MSG008 = "MSG008"
    case MSG009 = "MSG009"
    case MSG010 = "MSG010"
    case MSG011 = "MSG011"
    case MSG012 = "MSG012"
    case MSG013 = "MSG013"
    case MSG014 = "MSG014"
    case MSG015 = "MSG015"
    case MSG016 = "MSG016"
    case MSG017 = "MSG017"
    case MSG018 = "MSG018"
    case MSG019 = "MSG019"
    case MSG020 = "MSG020"
    case MSG021 = "MSG021"
    case MSG022 = "MSG022"
    case MSG023 = "MSG023"
    case MSG024 = "MSG024"
    case MSG025 = "MSG025"
    case MSG026 = "MSG026"
    case MSG027 = "MSG027"
    case MSG028 = "MSG028"
    case MSG029 = "MSG029"
    case MSG030 = "MSG030"
    case MSG031 = "MSG031"
    case MSG032 = "MSG032"
    case MSG033 = "MSG033"
    case MSG034 = "MSG034"
    case MSG035 = "MSG035"
    case MSG036 = "MSG036"
    case MSG037 = "MSG037"
    case MSG038 = "MSG038"
    case MSG039 = "MSG039"
    case MSG040 = "MSG040"
  }
  private let messages:[MsgId:String] = [
    .MSG001: "Enter your command from the menu:",
    .MSG002: "Invalid command. Please re-enter.",
    .MSG003: "Add a new song to the playlist!",
    .MSG004: "Enter a new song's title:",
    .MSG005: "Title should be more than 1 letter and less than 35 letters.",
    .MSG006: "Enter a new song's artist:",
    .MSG007: "Artist should be more than 1 letter and less than 20 letters.",
    .MSG008: "Enter a new song's category(P: Pop, R: Rock, A: Alternative, B: RnB, H: Hiphop, C: Classical):",
    .MSG009: "Invalid category. Please re-enter:",
    .MSG010: "Enter a song's size:",
    .MSG011: "Must enter a positive size. Please re-enter:",
    .MSG012: "Show playlist size!",
    .MSG013: "Total size:",
    .MSG014: "Find a song on the playlist!",
    .MSG015: "Enter your search keyward:",
    .MSG016: "Delete a song from the playlist!",
    .MSG017: "Enter the title of the song you want to remove from your playlist:",
    .MSG018: "Successflly removed the song from the playlist.",
    .MSG019: "No such title:",
    .MSG020: "You don't have any songs in your playlist.",
    .MSG021: "Select a category(P: Pop, R: Rock, A: Alternative, B: RnB, H: Hiphop, C: Classical):",
    .MSG022: "Find a song on the playlist!",
    .MSG023: "Enter your search keyword:",
    .MSG024: "=== Matched Titles ===",
    .MSG025: "Matched Artist ===",
    .MSG026: "Show this menu!",
    .MSG027: "",
    .MSG028: "",
    .MSG029: "",
    .MSG030: "",
    .MSG031: "",
    .MSG032: "",
    .MSG033: "",
    .MSG034: "",
    .MSG035: "",
    .MSG036: "",
    .MSG037: "",
    .MSG038: "",
    .MSG039: "",
    .MSG040: "",
  ]
  private enum Category: String {
    case P = "P"
    case R = "R"
    case A = "A"
    case B = "B"
    case H = "H"
    case C = "C"
  }
  private let categoryMap:[Category:Song.Style] = [
    .P: .pop,
    .R: .rock,
    .A: .alternative,
    .B: .rnb,
    .H: .hiphop,
    .C: .classical,
  ]
  
  //---------------------------------------------------------
  // Initializer
  //---------------------------------------------------------
  init(){
    playlist = Playlist()
  }
  
  //---------------------------------------------------------
  // Main process
  //---------------------------------------------------------
  mutating func startPlaying(){
    while true {
      showMenu()
      print(getMsg(.MSG001))
      
      // Check input value
      guard let _inputCommand = readLine() else {
        print(getMsg(.MSG002))
        continue
      }
      guard isValidMenuItem(_inputCommand) else {
        print(getMsg(.MSG002))
        continue
      }
      
      let inputCommand = MenuItem(rawValue: _inputCommand.uppercased())!
      
      if inputCommand == .X {
        break
      }
      
      switch inputCommand {
      case .A:
        addSong()
      case .F:
        find()
      case .D:
        deleteSong()
      case .S:
        showPlayList()
      case .C:
        showCategorySummary()
      case .Z:
        showPlayListSize()
      case .M:
        print(getMsg(.MSG026))
        showMenu()
      default:
        break
      }
      print("")
    }
  }
  
  //---------------------------------------------------------
  // Implement Menu items
  //---------------------------------------------------------
  // Menu A
  mutating private func addSong() {
    while true {
      print(getMsg(.MSG003))
      
      var title = ""
      var artist = ""
      var category:Song.Style = .pop
      var size:Int = 0
      
      // title
      while true {
        print(getMsg(.MSG004))
        title = readLine() ?? ""
        if !playlist.isValidTitle(title: title){
          print(getMsg(.MSG005))
          continue
        }
        break
      }
      // artist
      while true {
        print(getMsg(.MSG006))
        artist = readLine() ?? ""
        if !playlist.isValidArtist(artist: artist){
          print(getMsg(.MSG005))
          continue
        }
        break
      }
      // category
      while true {
        print(getMsg(.MSG008))
        let _category = readLine() ?? ""
        if !isValidCategory(_category){
          print(getMsg(.MSG009))
          continue
        }
        category = categoryMap[Category(rawValue: _category.uppercased())!]!
        break
      }
      // size
      while true {
        print(getMsg(.MSG010))
        guard let _size = Int(readLine() ?? "") else {
          print(getMsg(.MSG011))
          continue
        }
        if !isValidSize(_size){
          print(getMsg(.MSG011))
          continue
        }
        size = _size
        break
      }
      
      playlist.addSong(title: title, artist: artist, category: category, size: size)
      break
    }
  }
  // Menu F
  private func find() {
    print(getMsg(.MSG022))
    print(getMsg(.MSG023))
    
    let keyword = readLine() ?? ""

    let searchResultByTitle = playlist.findSongByTitle(keyword: keyword)
    let searchResultByArtist = playlist.findSongByArtistName(keyword: keyword)
    
    print(getMsg(.MSG024))
    if !searchResultByTitle.isEmpty {
      for song in searchResultByTitle {
        print(song.description)
      }
    }
    print("=== \(searchResultByTitle.count) matches ===")
    print(getMsg(.MSG025))
    if !searchResultByArtist.isEmpty {
      for song in searchResultByArtist {
        print(song.description)
      }
    }
    print("=== \(searchResultByArtist.count) matches ===")
  }
  // Menu D
  mutating private func deleteSong() {
    
    if playlist.songs.isEmpty {
      print(getMsg(.MSG020))
      return
    }
    
    print(getMsg(.MSG016))
    print(getMsg(.MSG017))
    
    let delTgt = readLine() ?? ""
    
    let result = playlist.deleteSong(title: delTgt)
    
    if result {
      print(getMsg(.MSG018))
    } else {
      print(getMsg(.MSG019) + "'\(delTgt)' in the list")
    }
  }
  // Menu S
  private func showPlayList() {
    let str = playlist.description
    print(str)
  }
  // Menu C
  private func showCategorySummary() {
    while true {
      print(getMsg(.MSG021))
      
      let category = readLine() ?? ""
      
      if !isValidCategory(category){
        print(getMsg(.MSG009))
        continue
      }
      
      print(playlist.getCategorySummary(category: categoryMap[Category(rawValue: category.uppercased())!]!))
      break
    }
  }
  // Menu Z
  private func showPlayListSize() {
    print(getMsg(.MSG012))
    print("\(getMsg(.MSG013)) \(playlist.allSize) KB")
  }
  // Menu M
  private func showMenu() {
    for (_, v) in menuItems.enumerated() {
      print("\(v): \(menuItemDescriptions[v] ?? "")")
    }
  }
  
  //---------------------------------------------------------
  // Private methods
  //---------------------------------------------------------
  private func getMsg(_ msgId:MsgId) -> String{
    return messages[msgId] ?? ""
  }
  
  // to do
  private func getMsg(_ msgId:MsgId, replacements:String...) -> String{
    return messages[msgId] ?? ""
  }
  
  private func isValidMenuItem(_ menuItem:String) -> Bool {
    let _menuItem = menuItem.uppercased()
    guard let _ = MenuItem(rawValue: _menuItem) else {
      return false
    }
    return true
  }
  
  private func isValidCategory(_ category:String) -> Bool {
    let _category = category.uppercased()
    guard let _ = Category(rawValue: _category) else {
      return false
    }
    return true
  }
  
  private func isValidSize(_ size:Int) -> Bool {
    if size < 0 {
      return false
    }
    return true
  }
}
