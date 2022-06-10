Class {
	#name : 'Laps',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
Laps >> getCollectionOfGamesWithPlayers: aCollectionOfPlayers [

	| theCollectionOfGames theOuterPlayer theGame |
	theCollectionOfGames := OrderedCollection new.
	1 to: (aCollectionOfPlayers size -1) do: [
		:eachOuterIndex |
		theOuterPlayer := aCollectionOfPlayers at: eachOuterIndex.
		1 to:  (aCollectionOfPlayers size - eachOuterIndex) do: [
			:eachInnerIndex |
				theGame := Game new.
				theGame layer: 0.
				theGame members: OrderedCollection new.
				theGame members add: theOuterPlayer.
				theGame members add: (aCollectionOfPlayers at: (eachOuterIndex + eachInnerIndex)).
				theCollectionOfGames add: theGame.
		].
	].
	
	^theCollectionOfGames
]

{ #category : 'API' }
Laps >> getCollectionOfGamesWithTeams: aCollectionOfTeams [

	|startUp players theCollectionOfGames theOuterTeam theGame |
	theCollectionOfGames := OrderedCollection new.
	1 to: (aCollectionOfTeams size -1) do: [
		:eachOuterIndex |
		theOuterTeam := aCollectionOfTeams at: eachOuterIndex.
		1 to:  (aCollectionOfTeams size - eachOuterIndex) do: [
			:eachInnerIndex |
				theGame := Game new.
				theGame layer: 0.
				theGame members: OrderedCollection new.
				theGame members add: theOuterTeam.
				theGame members add: (aCollectionOfTeams at: (eachOuterIndex + eachInnerIndex)).
				theCollectionOfGames add: theGame.
		].
	].
	
	^theCollectionOfGames
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
