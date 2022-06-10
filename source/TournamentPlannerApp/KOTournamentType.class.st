Class {
	#name : 'KOTournamentType',
	#superclass : 'TournamentType',
	#instVars : [
		'layer',
		'gameCollection'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
KOTournamentType class >> new [

	super new initialize
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
KOTournamentType >> gameCollection [
	
	"<^hOf Collection of: Game>"
	"Answer the gameCollection of the receiver"
	
	^gameCollection
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
KOTournamentType >> gameCollection: aGameCollection [

	"<aGameCollection: hOf Collection of: iOf Game, ^self>"
	"Set the gameCollection of the receiver"

	gameCollection := aGameCollection
]

{ #category : 'API' }
KOTournamentType >> getCollectionOfGamesWithPlayers: aCollectionOfPlayers [

	"<aCollectionOfPlayers hOf Collection of: iOf Player, ^self>"
	"Answer the Collection of Game"
	
	| theCollectionSize theRecursiveParamListCollectionOfGames theNumberOfGames theHasToContinueBoolean thePowerOf2Number |

	theRecursiveParamListCollectionOfGames := OrderedCollection new.
	theCollectionSize := aCollectionOfPlayers size.
	theNumberOfGames := theCollectionSize / 2.
	
	self layer = 0
		ifTrue: [
			thePowerOf2Number := (theCollectionSize log: 2) asInteger.
			theNumberOfGames := theCollectionSize - (thePowerOf2Number power: 2).
			1 to: (thePowerOf2Number power: 2) - 1 do: [ :eachIndex |
				theRecursiveParamListCollectionOfGames add: (aCollectionOfPlayers at: theCollectionSize - eachIndex +1).
			].
			aCollectionOfPlayers removeAll: theRecursiveParamListCollectionOfGames ifAbsent: [].
		].
	
	self layer: self layer + 1.
	theHasToContinueBoolean := theCollectionSize > 2.
	
	1 to: theNumberOfGames do: [ :eachIndex |
		| theCurrentGame theCurrentPlayer |
		theCurrentGame := (Game new
			layer: self layer;
			members: OrderedCollection new;
			name: '';
			yourself).
		theCurrentPlayer := aCollectionOfPlayers at: eachIndex.
		theCurrentGame members add: theCurrentPlayer;
			name: theCurrentGame name, theCurrentPlayer firstName, theCurrentPlayer lastName
			yourself.
		
		theCurrentPlayer :=aCollectionOfPlayers at: (aCollectionOfPlayers size - eachIndex +1).
		theCurrentGame members add: theCurrentPlayer;
			name: theCurrentGame name, ' vs ', theCurrentPlayer firstName, theCurrentPlayer lastName
			yourself.
			
		self gameCollection add: theCurrentGame.
		theRecursiveParamListCollectionOfGames add: (Player new
			firstName: 'Winner of game ', theCurrentGame name; 
			yourself). 
	].
	
	theHasToContinueBoolean 
		ifTrue: [^self getCollectionOfGamesWithPlayers: theRecursiveParamListCollectionOfGames]
		ifFalse: [^self gameCollection]
]

{ #category : 'API' }
KOTournamentType >> getCollectionOfGamesWithTeams: aCollectionOfTeams [

	"<aCollectionOfTeams hOf Collection of: iOf Team, ^self>"
	"Answer the Collection of Game"

	| theCollectionSize theNumberOfGames theRecursiveParamListCollectionOfGames theHasToContinueBoolean thePowerOf2Number |

	theRecursiveParamListCollectionOfGames := OrderedCollection new.
	theCollectionSize := aCollectionOfTeams size.
	theNumberOfGames := theCollectionSize / 2.
	
	self layer = 0
		ifTrue: [
			thePowerOf2Number := (theCollectionSize log: 2) asInteger.
			theNumberOfGames := theCollectionSize - (thePowerOf2Number power: 2).
			1 to: (thePowerOf2Number power: 2) - 1 do: [ :eachIndex |
				| theCurrentTeam |
				theCurrentTeam := aCollectionOfTeams at: theCollectionSize - eachIndex +1.
				theRecursiveParamListCollectionOfGames add: theCurrentTeam.
			].
			aCollectionOfTeams removeAll: theRecursiveParamListCollectionOfGames ifAbsent: [].
		].

	self layer: self layer + 1.
	theHasToContinueBoolean := theCollectionSize > 2.
	
	1 to: theNumberOfGames do: [ :eachIndex |
		| theCurrentTeam theCurrentGame |
		theCurrentGame := Game new
			layer: self layer;
			members: OrderedCollection new;
			name: '';
			yourself.
			
		theCurrentTeam := aCollectionOfTeams at: eachIndex.
		theCurrentGame members add: theCurrentTeam;
			name: theCurrentGame name, theCurrentTeam teamName
			yourself.
			
		theCurrentTeam :=aCollectionOfTeams at: (aCollectionOfTeams size - eachIndex +1).
		theCurrentGame members add: theCurrentTeam;
			name: theCurrentGame name, ' vs ', theCurrentTeam teamName
			yourself.
			
		self gameCollection add: theCurrentGame.
		theRecursiveParamListCollectionOfGames add: (Team new
			teamName: 'Winner of game ', theCurrentGame name; 
			yourself). 
	].
	
	theHasToContinueBoolean 
		ifTrue: [^self getCollectionOfGamesWithTeams: theRecursiveParamListCollectionOfGames]
		ifFalse: [^self gameCollection]
]

{ #category : 'API',
  #vaVisibility : 'private' }
KOTournamentType >> initialize [

	"Initialize the operation"

	self layer: 0.
	self gameCollection: OrderedCollection new.
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
KOTournamentType >> layer [

	"<^hOf Number>"
	"Answer the layer of the receiver"
	
	^layer
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
KOTournamentType >> layer: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the layer of the receiver"

	layer := aNumber
]
