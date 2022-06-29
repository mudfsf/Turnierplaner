Class {
	#name : 'LapsTournamentType',
	#superclass : 'TournamentType',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
LapsTournamentType >> asString [

	"<^iOf String>"
	"Answer the receiver as a string"

	^'Runden'
]

{ #category : 'API' }
LapsTournamentType >> getCollectionOfGamesWithMembers: aCollectionOfMembers [

	"<aCollectionOfMembers hOf Collection of: iOf Member, ^self>"
	"Answer the Collection of Game"
	"Creates Games where every Member plays against every other Member"
	
	| theCollectionOfGames |

	theCollectionOfGames := OrderedCollection new.
	aCollectionOfMembers doWithIndex: [ :eachPlayer :eachIndex |
		aCollectionOfMembers doWithIndex: [ :eachSecondPlayer :eachIndexSecond |
			eachIndex>=eachIndexSecond
				ifFalse: [ | theCurrentGame |
					theCurrentGame := Game new
						layer: 0;
						memberCollection: OrderedCollection new;
						isBuyBoolean: false;
						resultCollection: OrderedCollection new;
						yourself.
					theCurrentGame memberCollection
						add: eachPlayer;
						add: eachSecondPlayer;
						yourself.
					theCurrentGame name: ('%1 VS %2' bindWith: eachPlayer asString with: eachSecondPlayer asString).
					theCollectionOfGames add: theCurrentGame]]].	
	^theCollectionOfGames
]
