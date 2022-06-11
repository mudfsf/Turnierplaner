Class {
	#name : 'TournamentType',
	#superclass : 'Object',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
TournamentType >> getCollectionOfGamesWithMembers: aCollectionOfMembers [

	"<aCollectionOfTeams hOf Collection of: iOf Member>"
	"Answer the Collection of Game"
	
	^self subclassResponsibility
]
