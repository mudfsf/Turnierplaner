Class {
	#name : 'Laps',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
Laps >> getCollectionOfGames: aNumberOfGames [
	|startUp players|
	startUp:= StartUp new. 
	"players:=startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\players.dat'."
	players:=startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\tournaments.dat'.
	
 ^self error: 'Method not implemented'
]

{ #category : 'API' }
Laps >> getNumberOfLaps: aNumber [

	|theSum theCurrentIteration|

	theSum := 0.
	theCurrentIteration := 1.
	
	[ theCurrentIteration < aNumber asNumber ] whileTrue: [
		theSum := theSum + theCurrentIteration.
		theCurrentIteration := theCurrentIteration + 1
	]. 
	^theSum
]
