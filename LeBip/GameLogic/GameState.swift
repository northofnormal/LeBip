//
//  GameState.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class GameState: ObservableObject {
    @Published private(set) var players: [Player] = []
    @Published private(set) var currentIndex: Int = 0
    @Published private(set) var turnID: Int = 0

    @Published var gamePhase: GamePhase = .setup
    @Published var turnDuration: TimeInterval?
    @Published var remainingTime: TimeInterval?
    @Published var winner: Player? = nil
    @Published var timerStatus: TimerStatus = .stopped

    private var timerTask: Task<Void, Never>?

    enum TimerStatus {
        case stopped
        case running
        case paused
    }

    init(players: [Player] = [], currentIndex: Int = 0, turnID: Int = 0, gamePhase: GamePhase = .setup, turnDuration: TimeInterval? = nil, remainingTime: TimeInterval? = nil, timerTask: Task<Void, Never>? = nil, winner: Player? = nil) {
        self.players = players
        self.currentIndex = currentIndex
        self.turnID = turnID
        self.gamePhase = gamePhase
        self.turnDuration = turnDuration
        self.remainingTime = remainingTime
        self.timerTask = timerTask
        self.winner = winner
    }

}

extension GameState {
    var currentPlayer: Player {
        players[currentIndex]
    }

    var nextPlayer: Player {
        let nextIndex = (currentIndex + 1) % players.count
        return players[nextIndex]
    }

    var nextNextPlayer: Player {
        let nextNextIndex = (currentIndex + 2) % players.count
        return players[nextNextIndex]
    }

    var progress: Double? {
        guard let remainingTime, let turnDuration else { return nil }

        return remainingTime / turnDuration
    }

    func startTurn() {
        resetTimer()
    }

    func endTurn() {
        turnID += 1
        advanceIndex()
        resetTimer()
    }

    private func advanceIndex() {
        currentIndex = (currentIndex + 1) % players.count
    }

    private func resetTimer() {
        timerTask?.cancel()
        timerTask = nil

        guard let turnDuration else {
            remainingTime = nil
            timerStatus = .stopped
            return
        }

        remainingTime = turnDuration
        startTimer()
    }


    private func startTimer() {
        timerTask?.cancel()

        guard let _ = turnDuration else { return }

        timerStatus = .running

        timerTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))

                await MainActor.run {
                    guard timerStatus == .running,
                          let remaining = remainingTime,
                          remaining > 0
                    else { return }

                    withAnimation(.linear(duration: 1)) {
                        remainingTime = remaining - 1
                    }

                    if remainingTime == 0 {
                        timerStatus = .stopped
                        // trigger timeout effects here later
                    }
                }
            }
        }
    }

    func pauseTimer() {
        guard remainingTime != nil, timerStatus == .running else { return }
        timerStatus = .paused
    }

    func resumeTimer() {
        guard remainingTime != nil, timerStatus == .paused else { return }
        timerStatus = .running
    }

    func add(player: Player) {
        guard gamePhase == .setup else { return }
        players.append(player)
    }

    func removePlayer(at offsets: IndexSet) {
        guard gamePhase == .setup else { return }
        players.remove(atOffsets: offsets)
    }

    func movePlayers(from source: IndexSet, to destination: Int) {
        guard gamePhase == .setup else { return }
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
            players.move(fromOffsets: source, toOffset: destination)
        }
    }

    func shufflePlayers() {
        guard gamePhase == .setup else { return }
        guard players.count > 1 else { return }

        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
            players.shuffle()
        }
    }

    func setFirstPlayer(id: UUID) {
        if let index = players.firstIndex(where: {  $0.id == id } ) {
            currentIndex = index
        }
    }

    func setTurnDuration(_ duration: TimeInterval?) {
        guard gamePhase == .setup else { return }
        turnDuration = duration
    }

    func startGame() {
        guard gamePhase == .setup || gamePhase == .choosingFirst else { return }
        guard players.count > 0 else { return }

        gamePhase = .inGame
        remainingTime = turnDuration
        startTurn()
    }

    func resetToSetup() {
        timerTask?.cancel()
        timerTask = nil

        players.removeAll()
        currentIndex = 0
        turnID = 0
        turnDuration = nil
        remainingTime = nil
        timerStatus = .stopped
        winner = nil

        gamePhase = .setup
    }

    func chooseFirstPlayer() async {
        guard gamePhase == .choosingFirst else { return }

        for _ in 0..<20 {
            currentIndex = Int.random(in: 0..<players.count)
            try? await Task.sleep(for: .milliseconds(80))
        }

        gamePhase = .inGame
        resetTimer()
    }

    func endGame() {
        guard gamePhase == .inGame else { return }

        gamePhase = .gameOver
    }

    func setWinner(_ player: Player) {
        guard gamePhase == .gameOver else { return }

        winner = player
        gamePhase = .celebrate
    }
}
