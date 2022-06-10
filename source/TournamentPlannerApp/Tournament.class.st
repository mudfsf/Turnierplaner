Class {
	#name : 'Tournament',
	#superclass : 'Resultable',
	#instVars : [
		'tournamentType',
		'games',
		'name',
		'numberOfGames',
		'numberOfPlayedGames',
		'gameMode'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'instance creation' }
Tournament class >> tournamentType: aTournamentType games: aListOfGames [

	^(self new)
	tournamentType: aTournamentType;
	games: aListOfGames;
	yourself.
]

{ #category : 'Accessing' }
Tournament >> gameMode [

	^gameMode
]

{ #category : 'Accessing' }
Tournament >> gameMode: aSymbol [

	gameMode := aSymbol
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
Tournament >> name [

	^name
]

{ #category : 'Accessing' }
Tournament >> name: anObject [

	name := anObject
]

{ #category : 'Accessing' }
Tournament >> numberOfGames [

	^numberOfGames
	
]

{ #category : 'Accessing' }
Tournament >> numberOfGames: aNumber [

	numberOfGames := aNumber
	
]

{ #category : 'Accessing' }
Tournament >> numberOfPlayedGames [

	^numberOfPlayedGames
]

{ #category : 'Accessing' }
Tournament >> numberOfPlayedGames: aNumber [

	numberOfPlayedGames := aNumber
]

{ #category : 'Accessing' }
Tournament >> tournamentType [

	^tournamentType
]

{ #category : 'Accessing' }
Tournament >> tournamentType: aTournamentType [

	tournamentType := aTournamentType
]
