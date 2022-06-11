Class {
	#name : 'Tournament',
	#superclass : 'Object',
	#instVars : [
		'tournamentType',
		'games',
		'name',
		'numberOfGames',
		'numberOfPlayedGames',
		'gameMode',
		'membercollection'
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

	"<^iOf String>"
	"Answer the gameMode of the receiver"

	^gameMode
]

{ #category : 'Accessing' }
Tournament >> gameMode: aString [

	"<aString: iOf String, ^self>"
	"Set the gameMode of the receiver"

	gameMode := aString
]

{ #category : 'Accessing' }
Tournament >> games [

	"<^hOf Collection of: {hOf Game}>"
	"Answer the games of the receiver"

	^games
]

{ #category : 'Accessing' }
Tournament >> games: aCollection [

	"<aCollection: hOf Collection of: {hOf Game}, ^self>"
	"Set the games of the receiver"

	games := aCollection
]

{ #category : 'Accessing' }
Tournament >> membercollection [

	"<^hOf Collection of: {hOf PlayerOrTeam}>"
	"Answer the membercollection of the receiver"

	^membercollection
]

{ #category : 'Accessing' }
Tournament >> membercollection: aCollection [

	"<aCollection: hOf Collection of: {hOf PlayerOrTeam}, ^self>"
	"Set the membercollection of the receiver"

	membercollection := aCollection
]

{ #category : 'Accessing' }
Tournament >> name [

	"<^iOf String>"
	"Answer the name of the receiver"

	^name
]

{ #category : 'Accessing' }
Tournament >> name: aString [

	"<aString: iOf String, ^self>"
	"Set the name of the receiver"

	name := aString
]

{ #category : 'Accessing' }
Tournament >> numberOfGames [

	"<^hOf Number>"
	"Answer the numberOfGames of the receiver"

	^numberOfGames
]

{ #category : 'Accessing' }
Tournament >> numberOfGames: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the numberOfGames of the receiver"

	numberOfGames := aNumber
]

{ #category : 'Accessing' }
Tournament >> numberOfPlayedGames [

	"<^hOf Number>"
	"Answer the numberOfPlayedGames of the receiver"

	^numberOfPlayedGames
]

{ #category : 'Accessing' }
Tournament >> numberOfPlayedGames: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the numberOfPlayedGames of the receiver"

	numberOfPlayedGames := aNumber
]

{ #category : 'Accessing' }
Tournament >> tournamentType [

	"<^iOf TournamentType>"
	"Answer the tournamentType of the receiver"

	^tournamentType
]

{ #category : 'Accessing' }
Tournament >> tournamentType: aTournamentType [

	"<aTournamentType: iOf TournamentType, ^self>"
	"Set the tournamentType of the receiver"

	tournamentType := aTournamentType
]
