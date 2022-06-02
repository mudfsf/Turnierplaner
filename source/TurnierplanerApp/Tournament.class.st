Class {
	#name : 'Tournament',
	#superclass : 'Resultable',
	#instVars : [
		'tournamentType',
		'games'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'instance creation' }
Tournament class >> tournamentType: aTournamentType games: aListOfGames [

	^(self new)
	tournamentType: aTournamentType;
	games: aListOfGames;
	yourself.
]

{ #category : 'Accessing' }
Tournament >> games [

	^games
]

{ #category : 'Accessing' }
Tournament >> games: aListOfGame [

	games := aListOfGame
]

{ #category : 'Accessing' }
Tournament >> tournamentType [

	^tournamentType
]

{ #category : 'Accessing' }
Tournament >> tournamentType: aTournamentType [

	tournamentType := aTournamentType
]
