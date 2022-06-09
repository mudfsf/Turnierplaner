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

	| theCollectionSize theRecursiveParamListCollectionOfGames thePlayer theGame hasToContinue|

	self layer: self layer + 1.
	theRecursiveParamListCollectionOfGames := OrderedCollection new.
	theCollectionSize := aCollectionOfPlayers size.
	theCollectionSize > 2
	ifFalse: [
		hasToContinue := false
	]
	ifTrue: [ 		
		hasToContinue := true
	].

	theCollectionSize even
	ifFalse: [
		thePlayer := aCollectionOfPlayers last.
		theRecursiveParamListCollectionOfGames add: thePlayer.
		aCollectionOfPlayers remove: thePlayer
		ifAbsent: [].
		theCollectionSize := theCollectionSize - 1
	].
	
	1 to: (theCollectionSize / 2) do: [
		:eachIndex |
		theGame := (Game new
			layer: self layer;
			teams: OrderedCollection new;
			name: '';
			yourself).
		thePlayer := aCollectionOfPlayers at: eachIndex.
		theGame teams add: thePlayer.
		theGame name: theGame name, thePlayer firstName, thePlayer lastName .
		thePlayer :=aCollectionOfPlayers at: (theCollectionSize - eachIndex +1).
		theGame teams add: thePlayer.
		theGame name: theGame name, ' vs ', thePlayer firstName, thePlayer lastName.
		self gameCollection add: theGame.
		theRecursiveParamListCollectionOfGames add: (Team new
			teamName: 'Winner of game ', theGame name; 
			yourself). 
	].
	
	hasToContinue 
	ifTrue: [ ^self getCollectionOfGamesWithTeams: theRecursiveParamListCollectionOfGames ]
	ifFalse: [ ^self gameCollection ]

	
]

{ #category : 'API',
  #vaVisibility : 'private' }
KO >> recGetCollectionOfGamesWithTeams: aCollectionOfTeams [

	| theCollectionSize theRecursiveParamListCollectionOfGames theTeam theGame hasToContinue|

	self layer: self layer + 1.
	theRecursiveParamListCollectionOfGames := OrderedCollection new.
	theCollectionSize := aCollectionOfTeams size.
	theCollectionSize > 2
	ifFalse: [
		hasToContinue := false
	]
	ifTrue: [ 		
		hasToContinue := true
	].

	theCollectionSize even
	ifFalse: [
		theTeam := aCollectionOfTeams last.
		theRecursiveParamListCollectionOfGames add: theTeam.
		aCollectionOfTeams remove: theTeam
		ifAbsent: [].
		theCollectionSize := theCollectionSize - 1
	].
	
	1 to: (theCollectionSize / 2) do: [
		:eachIndex |
		theGame := (Game new
			layer: self layer;
			teams: OrderedCollection new;
			name: '';
			yourself).
		theTeam := aCollectionOfTeams at: eachIndex.
		theGame teams add: theTeam.
		theGame name: theGame name, theTeam teamName.
		theTeam :=aCollectionOfTeams at: (theCollectionSize - eachIndex +1).
		theGame teams add: theTeam.
		theGame name: theGame name, ' vs ', theTeam teamName.
		self gameCollection add: theGame.
		theRecursiveParamListCollectionOfGames add: (Team new
			teamName: 'Winner of game ', theGame name; 
			yourself). 
	].
	
	hasToContinue 
	ifTrue: [ ^self getCollectionOfGamesWithTeams: theRecursiveParamListCollectionOfGames ]
	ifFalse: [ ^self gameCollection ]

	
]
