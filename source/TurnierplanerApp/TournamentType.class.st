Class {
	#name : 'TournamentType',
	#superclass : 'Object',
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
TournamentType >> getCollectionOfGamesWithPlayers: aCollectionOfPlayers [

	"<aCollectionOfPlayers hOf Collection of: iOf Player ^self>"
	"Answer the Collection of Game"
	
	 ^self subclassResponsibility
]

{ #category : 'API' }
TournamentType >> getCollectionOfGamesWithTeams: aCollectionOfTeams [

	"<aCollectionOfTeams hOf Collection of: iOf Team ^self>"
	"Answer the Collection of Game"
	
	 ^self subclassResponsibility
]
