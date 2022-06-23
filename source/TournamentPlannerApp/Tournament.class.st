Class {
	#name : 'Tournament',
	#superclass : 'Object',
	#instVars : [
		'tournamentType',
		'playedGames',
		'games',
		'name',
		'gameMode',
		'memberCollection'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
Tournament class >> newWithTournamentType: aTournamentType games: aCollectionOfGames [

	"<aTournamentType: iOF TournamentType, aCollectionOfGames: hOf Collection {iOf Game}, ^self>"
	"Create instance of game with teamName @aString"

	^self new
		tournamentType: aTournamentType;
		games: aCollectionOfGames;
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

	"<^hOf Collection of: {iOf Game}>"
	"Answer the games of the receiver"

	^games
]

{ #category : 'Accessing' }
Tournament >> games: aCollection [

	"<aCollection: hOf Collection of: {iOf Game}, ^self>"
	"Set the games of the receiver"

	games := aCollection
]

{ #category : 'Accessing' }
Tournament >> memberCollection [

	"<^hOf Collection of: {iOf Member}>"
	"Answer the memberCollection of the receiver"

	^memberCollection
]

{ #category : 'Accessing' }
Tournament >> memberCollection: aCollection [

	"<aCollection: hOf Collection of: {iOf Member}, ^self>"
	"Set the memberCollection of the receiver"

	memberCollection := aCollection
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
Tournament >> playedGames [

	"<^hOf Collection of: {iOf Game}>"
	"Answer the playedGames of the receiver"

	^playedGames
]

{ #category : 'Accessing' }
Tournament >> playedGames: aCollection [

	"<aCollection: hOf Collection of: {iOf Game}, ^self>"
	"Set the playedGames of the receiver"

	playedGames := aCollection
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
