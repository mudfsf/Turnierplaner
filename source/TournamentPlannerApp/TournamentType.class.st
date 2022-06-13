Class {
	#name : 'TournamentType',
	#superclass : 'Object',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
TournamentType >> getCollectionOfGamesWithMembers: aCollectionOfMembers [

	"<aCollectionOfMembers: hOf Collection of: {iOf Member}, ^self>"
	"Answer the Collection of Game"
	
	^self subclassResponsibility
]
