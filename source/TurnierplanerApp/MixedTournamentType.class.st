Class {
	#name : 'MixedTournamentType',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
MixedTournamentType >> getCollectionOfGamesWithPlayers: aCollectionOfPlayers [
	
	"<aCollectionOfPlayers hOf Collection of: iOf Player ^self>"
	"Answer the Collection of Game"
	
	|theLaps theKO theCollectionOfPlayers theCollectionOfGames|

	theCollectionOfPlayers := OrderedCollection withAll: aCollectionOfPlayers.
	theCollectionOfGames := OrderedCollection new.
	theLaps := LapsTournamentType new.
	theKO := KOTournamentType new.
	aCollectionOfPlayers size > 4
		ifTrue: [
			theCollectionOfGames addAll: (theLaps getCollectionOfGamesWithTeams: aCollectionOfPlayers).
			theCollectionOfPlayers := (OrderedCollection new
				add: (Team new
					teamName: 'first';
					players: OrderedCollection new;
					yourself);
				add: (Team new
					teamName: 'second';
					players: OrderedCollection new;
					yourself);
				add: (Team new
					teamName: 'third';
					players: OrderedCollection new;
					yourself);
				add: (Team new
					teamName: 'fourtht';
					players: OrderedCollection new;
					yourself);
				yourself).
		].
	theCollectionOfGames addAll: (theKO getCollectionOfGamesWithTeams: theCollectionOfPlayers).
	
	^theCollectionOfGames
]

{ #category : 'API' }
MixedTournamentType >> getCollectionOfGamesWithTeams: aCollectionOfTeams [
	
	"<aCollectionOfTeams hOf Collection of: iOf Team ^self>"
	"Answer the Collection of Game"
	
	|theLaps theKO theCollectionOfTeams theCollectionOfGames|

	theCollectionOfTeams := OrderedCollection withAll: aCollectionOfTeams.
	theCollectionOfGames := OrderedCollection new.
	theLaps := LapsTournamentType new.
	theKO := KOTournamentType new.
	aCollectionOfTeams size > 4
		ifTrue: [
			theCollectionOfGames addAll: (theLaps getCollectionOfGamesWithTeams: aCollectionOfTeams).
			theCollectionOfTeams := (OrderedCollection new
				add: (Team new
					teamName: 'first';
					players: OrderedCollection new;
					yourself);
				add: (Team new
					teamName: 'second';
					players: OrderedCollection new;
					yourself);
				add: (Team new
					teamName: 'third';
					players: OrderedCollection new;
					yourself);
				add: (Team new
					teamName: 'fourtht';
					players: OrderedCollection new;
					yourself);
				yourself).
		].

	theCollectionOfGames addAll: (theKO getCollectionOfGamesWithTeams: theCollectionOfTeams).
	^theCollectionOfGames
]
