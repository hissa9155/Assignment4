//
//  Playlist.swift
//  Assignment4
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation

struct Playlist: CustomStringConvertible {
  private(set) var songs: [Song] = []
  
  private let descriptionHeader = """
    --------------------------------------------------------------------------------------------
    | Title                               | Artist                   | Style       | Size (MB)
    --------------------------------------------------------------------------------------------
    
    """
  
  var description: String {
    var str = descriptionHeader
    for song in songs {
      str.append(song.description)
      str.append("\n")
    }
    str.append("--------------------------------------------------------------------------------------------")
    str.append("\n")
    str.append("Total: \(songs.count) songs in the playlist")
    str.append("\n")
    str.append("Size: \(Double(allSize) / 1000)")
    return str
  }
  
  var allSize:Int {
    var size = 0
    for song in songs {
      size += song.size
    }
    return size
  }
  
  mutating func addSong(title:String, artist:String, category:Song.Style, size:Int){
    let newSong = Song(title: title, artist: artist, category: category, size: size)
    songs.append(newSong)
  }
  
  mutating func deleteSong(title:String) -> Bool{
    for (i, song) in songs.enumerated() {
      if song.title == title {
        songs.remove(at: i)
        return true
      }
    }
    return false
  }
  
  func findSongByTitle(keyword:String) -> [Song]{
    let searchResult = songs.filter{$0.title.lowercased().contains(keyword.lowercased())}
    return searchResult
  }
  
  func findSongByArtistName(keyword:String) -> [Song]{
    let searchResult = songs.filter{$0.artist.lowercased().contains(keyword.lowercased())}
    return searchResult
  }
  
  func getCategorySummary(category:Song.Style) -> String {
    var str = descriptionHeader
    
    let filteredSongs = songs.filter{$0.category == category}
    
    for song in filteredSongs {
      str.append(song.description)
      str.append("\n")
    }
    str.append("--------------------------------------------------------------------------------------------")
    str.append("\n")
    str.append("Total: \(filteredSongs.count) in the playlist")
    str.append("\n")
    str.append("Size: \(Double(filteredSongs.reduce(0, {$0 + $1.size})) / 1000 )")
    return str
  }
  
  func isValidTitle(title:String) -> Bool {
    let MAX_LENGTH = 35
    let MIN_LENGTH = 1
    var isValid = true
    
    if title.count < MIN_LENGTH && MAX_LENGTH < title.count {
      isValid = false
    }
    
    return isValid
  }
  
  func isValidArtist(artist:String) -> Bool {
    let MAX_LENGTH = 20
    let MIN_LENGTH = 1
    var isValid = true
    
    if artist.count < MIN_LENGTH && MAX_LENGTH < artist.count {
      isValid = false
    }
    
    return isValid
  }
}
