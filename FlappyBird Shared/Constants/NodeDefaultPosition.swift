//
//  NodeDefaultPosition.swift
//  FlappyBird
//
//  Created by Air on 28.10.2023.
//

import Foundation

class NodeDefaultPosition {
    #if os(OSX)
    
    static var Bird = CGPoint(x: -300, y: 150)
    static var Base = CGPoint(x: 0, y: -350)
    static var Pipes = CGPoint(x: 1000, y: -300)
    static var ScoreLabel = CGPoint(x: 0, y: 250)
    static var BackgroundMessage = CGPoint(x: 0, y: 100)
    
    #endif
    
    
    
    #if os(iOS)
    
    static var Bird = CGPoint(x: -150, y: 150)
    static var Base = CGPoint(x: 0, y: -400)
    static var Pipes = CGPoint(x: 1000, y: -300)
    static var ScoreLabel = CGPoint(x: 0, y: 250)
    static var BackgroundMessage = CGPoint(x: 0, y: 100)
    
    #endif
}
