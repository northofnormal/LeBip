//
//  LeBipTests.swift
//  LeBipTests
//
//  Created by Anne Cahalan on 1/21/26.
//

import Foundation
import Testing
@testable import LeBip

@MainActor
struct GameStateTests {
    let firstTestPlayer = Player(id: UUID(), name: "FirstTestPlayer", color: AppColor.playerBlue)
    let secondTestPlayer = Player(id: UUID(), name: "SecondTestPlayer", color: AppColor.playerRose)

    @Test func addingPlayersOnlyWorksInSetup() async {
        let state = GameState()
        state.add(player: firstTestPlayer)
        #expect(state.players.count == 1)

        state.startGame()
        state.add(player: secondTestPlayer)
        #expect(state.players.count == 1)
    }

    @Test func endingTurnAdvancesPlayer() async {
        let testPlayers: [Player] = [firstTestPlayer, secondTestPlayer]
        let state = GameState(players: testPlayers)

        let startingIndex = state.currentIndex
        state.startGame()
        state.endTurn()

        #expect(state.currentIndex == (startingIndex + 1) % testPlayers.count)
    }

    @Test func endOfTurnWrapsAroundPlayers() async {
        let testPlayers: [Player] = [firstTestPlayer, secondTestPlayer]
        let state = GameState(players: testPlayers)

        let startingIndex = state.currentIndex
        state.startGame()
        state.endTurn()
        state.endTurn()

        #expect(state.currentIndex == startingIndex)
    }

    @Test func turnIDIncrementsAtEndOfTurn() async {
        let testPlayers: [Player] = [firstTestPlayer, secondTestPlayer]
        let state = GameState(players: testPlayers)

        let startingTurnID = state.turnID
        state.startGame()
        state.endTurn()

        #expect(state.turnID == startingTurnID + 1)
    }

    @Test func startingGameMovesPhaseToInGame() async  {
        let testPlayers: [Player] = [firstTestPlayer, secondTestPlayer]
        let state = GameState(players: testPlayers)
        state.startGame()

        #expect(state.gamePhase == .inGame)
    }

    @Test func chosingFirstPlayerMovesPhaseToInGame() async {
        let testPlayers: [Player] = [firstTestPlayer, secondTestPlayer]
        let state = GameState(players: testPlayers)
        state.proceedToChoseFirstPlayer()

        #expect(state.gamePhase == .choosingFirst)
    }

    @Test func endingGameMovesPhaseToGameOver() async {
        let testPlayers: [Player] = [firstTestPlayer, secondTestPlayer]
        let state = GameState(players: testPlayers)

        state.startGame()
        state.endGame()

        #expect(state.gamePhase == .gameOver)
    }

    @Test func noWinnerMovesPhaseToSetup() async {
        let testPlayers: [Player] = [firstTestPlayer, secondTestPlayer]
        let state = GameState(players: testPlayers)

        state.resetToSetup()

        #expect(state.gamePhase == .setup)
    }

    @Test func winnerMovesPhaseToCelebrate() async {
        let testPlayers: [Player] = [firstTestPlayer, secondTestPlayer]
        let state = GameState(players: testPlayers)
        state.startGame()
        state.endGame()
        state.setWinner(firstTestPlayer)

        #expect(state.gamePhase == .celebrate)
    }

}
