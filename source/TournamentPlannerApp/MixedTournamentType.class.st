Class {
	#name : 'MixedTournamentType',
	#superclass : 'TournamentType',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
MixedTournamentType >> getCollectionOfGamesWithMembers: aCollectionOfMembers [
	
	"<aCollectionOfPlayers hOf Collection of: iOf Member, ^self>"
	"Answer the Collection of Game"
	"Combines Games of KOTournamenttype and LapsTournamentType"
	
	|theLaps theKO theMemberType theCollectionOfPlayers theCollectionOfGames|

	theCollectionOfPlayers := OrderedCollection withAll: aCollectionOfMembers.
	theCollectionOfGames := OrderedCollection new.
	theLaps := LapsTournamentType new.
	theKO := KOTournamentType new.
	aCollectionOfMembers size > 4
		ifTrue: [
			theMemberType := aCollectionOfMembers first class.
			theCollectionOfGames addAll: (theLaps getCollectionOfGamesWithMembers: aCollectionOfMembers).
			theCollectionOfPlayers := OrderedCollection new
				add: (theMemberType newWithName: 'Erster');
				add: (theMemberType newWithName: 'Zweiter');
				add: (theMemberType newWithName: 'Dritter');
				add: (theMemberType newWithName: 'Vierter');
				yourself.].
	theCollectionOfGames addAll: (theKO getCollectionOfGamesWithMembers: theCollectionOfPlayers).
	
	^theCollectionOfGames
]
