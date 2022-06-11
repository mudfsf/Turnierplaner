Class {
	#name : 'LapsTournamentType',
	#superclass : 'TournamentType',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
LapsTournamentType >> getCollectionOfGamesWithPlayers: aCollectionOfPlayers [

	"<aCollectionOfPlayers hOf Collection of: iOf Player, ^self>"
	"Answer the Collection of Game"
	"Creates Games where every Player plays against every other Player"
	
	| theCollectionOfGames |
	
	theCollectionOfGames := OrderedCollection new.

	1 to: aCollectionOfPlayers size - 1 do: [ :eachIndexForFirstPlayer |
		1 to:  (aCollectionOfPlayers size - eachIndexForFirstPlayer) do: [ :eachIndexForSecondPlayer |
				| theCurrentPlayer theCurrentGame |
			theCurrentGame := Game new
				layer: 0;
				members: OrderedCollection new;
				name: '';
				yourself.
				
			theCurrentPlayer := aCollectionOfPlayers at: eachIndexForFirstPlayer.
			theCurrentGame	name: theCurrentGame name, theCurrentPlayer asString.
			theCurrentGame	members add: theCurrentPlayer.
				
			theCurrentPlayer := aCollectionOfPlayers at: (eachIndexForFirstPlayer + eachIndexForSecondPlayer).
			theCurrentGame name: theCurrentGame name, ' vs ', theCurrentPlayer asString.
			theCurrentGame members add: theCurrentPlayer.
				
			theCollectionOfGames add: theCurrentGame.].].
	
	^theCollectionOfGames
]

{ #category : 'API' }
LapsTournamentType >> getCollectionOfGamesWithTeams: aCollectionOfTeams [

	"<aCollectionOfTeams hOf Collection of: iOf Team, ^self>"
	"Answer the Collection of Game"
	"Creates Games where every Team plays against every other Team"
	
	| theCollectionOfGames |
	
	theCollectionOfGames := OrderedCollection new.
	
	1 to: aCollectionOfTeams size - 1 do: [ :eachIndexForFirstTeam |
		1 to: aCollectionOfTeams size - eachIndexForFirstTeam do: [	:eachIndexForSecondTeam |
			| theCurrentTeam theCurrentGame |
			theCurrentGame := Game new
				layer: 0;
				members: OrderedCollection new;
				name: '';
				yourself.
				
			theCurrentTeam := aCollectionOfTeams at: eachIndexForFirstTeam.
			theCurrentGame members add: theCurrentTeam.
			theCurrentGame	name: theCurrentGame name, theCurrentTeam asString.
			
			theCurrentTeam := aCollectionOfTeams at: (eachIndexForFirstTeam + eachIndexForSecondTeam).
			theCurrentGame members add: theCurrentTeam.
			theCurrentGame name: theCurrentGame name, ' vs ', theCurrentTeam asString.
				
			theCollectionOfGames add: theCurrentGame.].].
	
	^theCollectionOfGames
]
