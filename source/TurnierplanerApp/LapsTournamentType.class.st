Class {
	#name : 'LapsTournamentType',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
LapsTournamentType >> getCollectionOfGamesWithPlayers: aCollectionOfPlayers [

	"<aCollectionOfPlayers hOf Collection of: iOf Player ^self>"
	"Answer the Collection of Game"
	
	| theCollectionOfGames |
	
	theCollectionOfGames := OrderedCollection new.

	1 to: aCollectionOfPlayers size - 1 do: [ :eachIndexForFirstPlayer |
		1 to:  (aCollectionOfPlayers size - eachIndexForFirstPlayer) do: [ :eachIndexForSecondPlayer |
				theCollectionOfGames add: (Game new
					layer: 0;
					members: (OrderedCollection new
						add: (aCollectionOfPlayers at: eachIndexForFirstPlayer);
						add: (aCollectionOfPlayers at: eachIndexForFirstPlayer + eachIndexForSecondPlayer);
						yourself);
					yourself).
		].
	].
	
	^theCollectionOfGames
]

{ #category : 'API' }
LapsTournamentType >> getCollectionOfGamesWithTeams: aCollectionOfTeams [

	"<aCollectionOfTeams hOf Collection of: iOf Team ^self>"
	"Answer the Collection of Game"
	
	| theCollectionOfGames |
	
	theCollectionOfGames := OrderedCollection new.
	
	1 to: aCollectionOfTeams size - 1 do: [ :eachIndexForFirstTeam |
		1 to: aCollectionOfTeams size - eachIndexForFirstTeam do: [	:eachIndexForSecondTeam |
				theCollectionOfGames add: (Game new
					layer: 0;
					members: (OrderedCollection new
						add: (aCollectionOfTeams at: eachIndexForFirstTeam);
						add: (aCollectionOfTeams at: (eachIndexForFirstTeam + eachIndexForSecondTeam));
						yourself);
					yourself).
		].
	].
	
	^theCollectionOfGames
]
