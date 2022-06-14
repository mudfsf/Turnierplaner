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
	
	"<^hOf Collection of: {iOf Game}>"
	"Answer the gameCollection of the receiver"
	
	^gameCollection
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
KOTournamentType >> gameCollection: aGameCollection [

	"<aGameCollection: hOf Collection of: {iOf Game}, ^self>"
	"Set the gameCollection of the receiver"

	gameCollection := aGameCollection
]

{ #category : 'API' }
KOTournamentType >> getCollectionOfGamesWithMembers: aCollectionOfMembers [

	"<aCollectionOfMembers hOf Collection of: {iOf Member}, ^self>"
	"Answer the Collection of Game"

	| theCollectionSize theBuys theNumberOfBuys theRecursiveParamListCollectionOfGames theHasToContinueBoolean thePowerOf2Number |

	theRecursiveParamListCollectionOfGames := OrderedCollection new.
	theCollectionSize := aCollectionOfMembers size.
	theNumberOfBuys := theCollectionSize / 2.
	
	self layer = 0
		ifTrue: [
			thePowerOf2Number := (theCollectionSize log: 2) asInteger power: 2.
			thePowerOf2Number < theCollectionSize
				ifTrue: [thePowerOf2Number := thePowerOf2Number * 2].
			theNumberOfBuys := (thePowerOf2Number - theCollectionSize).
			theBuys := (aCollectionOfMembers first: (theNumberOfBuys)).
			theRecursiveParamListCollectionOfGames addAll: (theBuys).
			theBuys do: [ :eachMember |
				self gameCollection add: (Game new
					layer: 1;
					isBuy: true;
					members: (OrderedCollection new
						add: eachMember;
						yourself);
					name: ('Freilos %1' bindWith: eachMember asString))].
			aCollectionOfMembers removeAll: theBuys ifAbsent: []].

	self layer: self layer + 1.
	theHasToContinueBoolean := theCollectionSize > 2.
	
	1 to: aCollectionOfMembers size / 2 do: [ :eachIndex |
		| theCurrentMember theCurrentGame |
		theCurrentGame := Game new
			layer: self layer;
			isBuy: false;
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
			newWithName: ('Spiel %1' bindWith:  theCurrentGame name))].
	
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
