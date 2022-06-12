Class {
	#name : 'LapsTournamentType',
	#superclass : 'TournamentType',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
LapsTournamentType >> getCollectionOfGamesWithMembers: aCollectionOfMembers [

	"<aCollectionOfMembers hOf Collection of: iOf Member, ^self>"
	"Answer the Collection of Game"
	"Creates Games where every Member plays against every other Member"
	
	| theCollectionOfGames |
	
	theCollectionOfGames := OrderedCollection new.

	1 to: aCollectionOfMembers size - 1 do: [ :eachIndexForFirstPlayer |
		1 to:  (aCollectionOfMembers size - eachIndexForFirstPlayer) do: [ :eachIndexForSecondPlayer |
			| theCurrentPlayer theCurrentGame |
			theCurrentGame := Game new
				layer: 0;
				members: OrderedCollection new;
				name: '';
				yourself.
				
			theCurrentPlayer := aCollectionOfMembers at: eachIndexForFirstPlayer.
			theCurrentGame	name: ('%1' bindWith: theCurrentPlayer asString).
			theCurrentGame	members add: theCurrentPlayer.
				
			theCurrentPlayer := aCollectionOfMembers at: (eachIndexForFirstPlayer + eachIndexForSecondPlayer).
			theCurrentGame name: ('%1 VS %2' bindWith: theCurrentGame name with: theCurrentPlayer asString).
			theCurrentGame members add: theCurrentPlayer.
				
			theCollectionOfGames add: theCurrentGame]].
	
	^theCollectionOfGames
]
