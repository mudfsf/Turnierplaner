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
KO >> getCollectionOfGamesWithTeams: aCollectionOfTeams [

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

{ #category : 'API' }
KO >> getNumberOfLaps: aNumber [

 ^aNumber asNumber - 1
]

{ #category : 'API' }
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
