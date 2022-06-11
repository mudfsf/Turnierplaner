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

	"<^self>"
	"Answer a new initialized instance of the receiver."

	^super new initialize
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
KOTournamentType >> getCollectionOfGamesWithMembers: aCollectionOfMembers [

	"<aCollectionOfMembers hOf Collection of: iOf Member, ^self>"
	"Answer the Collection of Game"

	| theCollectionSize theNumberOfBuys theRecursiveParamListCollectionOfGames theHasToContinueBoolean thePowerOf2Number |

	theRecursiveParamListCollectionOfGames := OrderedCollection new.
	theCollectionSize := aCollectionOfMembers size.
	theNumberOfBuys := theCollectionSize / 2.
	
	self layer = 0
		ifTrue: [
			thePowerOf2Number := (theCollectionSize log: 2) asInteger power: 2.
			theNumberOfBuys := (theCollectionSize - thePowerOf2Number) abs.
			theRecursiveParamListCollectionOfGames addAll: (aCollectionOfMembers first: theNumberOfBuys).
			aCollectionOfMembers removeAll: theRecursiveParamListCollectionOfGames ifAbsent: [].].

	self layer: self layer + 1.
	theHasToContinueBoolean := theCollectionSize > 2.
	
	1 to: aCollectionOfMembers size / 2 do: [ :eachIndex |
		| theCurrentMember theCurrentGame |
		theCurrentGame := Game new
			layer: self layer;
			members: OrderedCollection new;
			name: '';
			yourself.	
		theCurrentMember := aCollectionOfMembers at: eachIndex.
		theCurrentGame members add: theCurrentMember.
		theCurrentGame name: ('%1' bindWith: theCurrentMember asString).
		
		theCurrentMember := aCollectionOfMembers at: aCollectionOfMembers size +1 - eachIndex.
		theCurrentGame members add: theCurrentMember.
		theCurrentGame	name: ('%1 vs %2' bindWith: theCurrentGame name with: theCurrentMember asString).
			
		self gameCollection add: theCurrentGame.
		theRecursiveParamListCollectionOfGames add: (theCurrentMember class 
			newWithName: 'Winner of game ', theCurrentGame name).].
	
	theHasToContinueBoolean 
		ifTrue: [^self getCollectionOfGamesWithMembers: theRecursiveParamListCollectionOfGames]
		ifFalse: [^self gameCollection]
]

{ #category : 'API',
  #vaVisibility : 'private' }
KOTournamentType >> initialize [

	"Initialize the operation"

	self layer: 0.
	self gameCollection: OrderedCollection new
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
