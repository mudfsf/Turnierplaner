Class {
	#name : 'KO',
	#superclass : 'TournamentType',
	#instVars : [
		'layer',
		'gameCollection'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'API',
  #vaVisibility : 'private' }
KO >> gameCollection [

	^gameCollection
]

{ #category : 'API',
  #vaVisibility : 'private' }
KO >> gameCollection: aGameCollection [

	gameCollection := aGameCollection
]

{ #category : 'API' }
KO >> getCollectionOfGamesWithPlayers: aCollectionOfPlayers [

	self initialize.
	^self recGetCollectionOfGamesWithPlayers: aCollectionOfPlayers
]

{ #category : 'API' }
KO >> getCollectionOfGamesWithTeams: aCollectionOfTeams [

	self  initialize.
	^self recGetCollectionOfGamesWithTeams: aCollectionOfTeams
]

{ #category : 'API' }
KO >> getNumberOfLaps: aNumber [

 ^aNumber asNumber - 1
]

{ #category : 'API',
  #vaVisibility : 'private' }
KO >> initialize [

	self layer: 0.
	self gameCollection: OrderedCollection new.
]

{ #category : 'API',
  #vaVisibility : 'private' }
KO >> layer [

	^layer
]

{ #category : 'API',
  #vaVisibility : 'private' }
KO >> layer: anObject [

	layer := anObject
]

{ #category : 'API',
  #vaVisibility : 'private' }
KO >> recGetCollectionOfGamesWithPlayers: aCollectionOfPlayers [

	| theCollectionSize theRecursiveParamListCollectionOfGames theNumberOfGames thePlayer theGame hasToContinue thePowerOf2|

	theRecursiveParamListCollectionOfGames := OrderedCollection new.
	theCollectionSize := aCollectionOfPlayers size.
	self layer = 0
	ifTrue: [
		thePowerOf2 := (theCollectionSize log: 2) asInteger.
		theNumberOfGames := theCollectionSize - (thePowerOf2 power: 2).
		1 to: (thePowerOf2 power: 2) - 1 do: [
			:eachIndex |
			thePlayer := aCollectionOfPlayers at: (theCollectionSize - eachIndex +1).
			theRecursiveParamListCollectionOfGames add: (thePlayer).
		].
		aCollectionOfPlayers removeAll: theRecursiveParamListCollectionOfGames
		ifAbsent: [].
	]
	ifFalse: [
		theNumberOfGames := theCollectionSize / 2.
	].
	
	self layer: self layer + 1.
	theCollectionSize > 2
	ifFalse: [
		hasToContinue := false
	]
	ifTrue: [ 		
		hasToContinue := true
	].
	
	1 to: theNumberOfGames do: [
		:eachIndex |
		theGame := (Game new
			layer: self layer;
			members: OrderedCollection new;
			name: '';
			yourself).
		thePlayer := aCollectionOfPlayers at: eachIndex.
		theGame members add: thePlayer.
		theGame name: theGame name, thePlayer firstName, thePlayer lastName .
		thePlayer :=aCollectionOfPlayers at: (aCollectionOfPlayers size - eachIndex +1).
		theGame members add: thePlayer.
		theGame name: theGame name, ' vs ', thePlayer firstName, thePlayer lastName.
		self gameCollection add: theGame.
		theRecursiveParamListCollectionOfGames add: (Player new
			firstName: 'Winner of game ', theGame name; 
			yourself). 
	].
	
	hasToContinue 
	ifTrue: [ ^self recGetCollectionOfGamesWithPlayers: theRecursiveParamListCollectionOfGames ]
	ifFalse: [ ^self gameCollection ]

	
]

{ #category : 'API',
  #vaVisibility : 'private' }
KO >> recGetCollectionOfGamesWithTeams: aCollectionOfTeams [

	| theCollectionSize theNumberOfGames theRecursiveParamListCollectionOfGames theTeam theGame hasToContinue thePowerOf2 theCurrentTeam|

	theRecursiveParamListCollectionOfGames := OrderedCollection new.
	theCollectionSize := aCollectionOfTeams size.
	
	self layer = 0
	ifTrue: [
		thePowerOf2 := (theCollectionSize log: 2) asInteger.
		theNumberOfGames := theCollectionSize - (thePowerOf2 power: 2).
		1 to: (thePowerOf2 power: 2) - 1 do: [
			:eachIndex |
			theCurrentTeam := aCollectionOfTeams at: (theCollectionSize - eachIndex +1).
			theRecursiveParamListCollectionOfGames add: (theCurrentTeam).
		].
		aCollectionOfTeams removeAll: theRecursiveParamListCollectionOfGames
		ifAbsent: [].
	] 
	ifFalse: [
		theNumberOfGames := theCollectionSize / 2.
	].
	self layer: self layer + 1.
	theCollectionSize > 2
	ifFalse: [
		hasToContinue := false
	]
	ifTrue: [ 		
		hasToContinue := true
	].

	"theCollectionSize even
	ifFalse: [
		theTeam := aCollectionOfTeams last.
		theRecursiveParamListCollectionOfGames add: theTeam.
		aCollectionOfTeams remove: theTeam
		ifAbsent: [].
		theCollectionSize := theCollectionSize - 1
	]."
	
	1 to: theNumberOfGames do: [
		:eachIndex |
		theGame := (Game new
			layer: self layer;
			members: OrderedCollection new;
			name: '';
			yourself).
		theTeam := aCollectionOfTeams at: eachIndex.
		theGame members add: theTeam.
		theGame name: theGame name, theTeam teamName.
		theTeam :=aCollectionOfTeams at: (aCollectionOfTeams size - eachIndex +1).
		theGame members add: theTeam.
		theGame name: theGame name, ' vs ', theTeam teamName.
		self gameCollection add: theGame.
		theRecursiveParamListCollectionOfGames add: (Team new
			teamName: 'Winner of game ', theGame name; 
			yourself). 
	].
	
	hasToContinue 
	ifTrue: [ ^self recGetCollectionOfGamesWithTeams: theRecursiveParamListCollectionOfGames ]
	ifFalse: [ ^self gameCollection ]

	
]
