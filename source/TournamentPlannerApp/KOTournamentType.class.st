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

	"<aCollectionOfMembers hOf Collection of: iOf Member>"
	"Answer the Collection of Game"

	| theCollectionSize theRecursiveParamListCollectionOfGames theHasToContinueBoolean theLog2Number |

	theRecursiveParamListCollectionOfGames := OrderedCollection new.
	theCollectionSize := aCollectionOfMembers size.
	
	self layer = 0
		ifTrue: [
			theLog2Number := (theCollectionSize log: 2).
			(theLog2Number modulo: 1) = 0.0 ifFalse: [
				theLog2Number := theLog2Number + 1.].
			theLog2Number := (theLog2Number - (theLog2Number modulo: 1)) asInteger .
			1 to: ((theLog2Number power: 2) - theCollectionSize) do: [ :eachIndex |
				aCollectionOfMembers add: nil.].
			].
			
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
		
		theCurrentMember := aCollectionOfMembers at: aCollectionOfMembers size +1 - eachIndex.
		theCurrentGame members add: theCurrentMember.
			
		self gameCollection add: theCurrentGame.
		theRecursiveParamListCollectionOfGames add: nil.].
	
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
