Class {
	#name : 'Mixed',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
Mixed >> getCollectionOfGames: aNumberOfGames [
	|startUp players games|
	startUp:= StartUp new. 
	players:=startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\players.dat'.
	games:=OrderedCollection new.
	games add: (Game new).
		
	
 ^self error: 'Method not implemented'
]

{ #category : 'API' }
Mixed >> getNumberOfLaps: aNumber [

	|theNumberofLaps theLaps theKO|
	
	theLaps := Laps new.
	theKO := KO new.
	
	theNumberofLaps := theLaps getNumberOfLaps: aNumber asNumber.
	theNumberofLaps := theNumberofLaps + (theKO getNumberOfLaps: aNumber asNumber / 2).
	
	^theNumberofLaps
]
