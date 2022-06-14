Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'layer',
		'name',
		'memberCollection',
		'resultCollection',
		'isBuyBoolean'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
Game class >> newWithName: aString layer: aNumber members: aCollection [

	"<aString : hOf String, aNumber: hOf Number, aCollection: hOf Collection of: {iOf Team/Players}, ^self>"
	"Create instance of game with attributes"
	
	^self new
		name: aString;
		layer: aNumber;
		members: aCollection;	
		yourself
]

{ #category : 'Accessing' }
Game >> isBuyBoolean [

	"<^(true | false)>"
	"Answer the isBuy of the receiver"

	^isBuyBoolean
]

{ #category : 'Accessing' }
Game >> isBuyBoolean: aBoolean [

	"<aBoolean: (true | false), ^self>"
	"Set the isBuy of the receiver"

	isBuyBoolean := aBoolean
]

{ #category : 'Accessing' }
Game >> layer [

	"<^hOf Number>"
	"Answer the layer of the receiver"

	^layer
]

{ #category : 'Accessing' }
Game >> layer: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the layer of the receiver"

	layer := aNumber
]

{ #category : 'Accessing' }
Game >> memberCollection [

	"<^hOf Collection of: {iOf Member}>"
	"Answer the memberCollection of the receiver"

	^memberCollection
]

{ #category : 'Accessing' }
Game >> memberCollection: aCollectionOfMembers [

	"<aCollectionOfMembers: hOf Collection of: {iOf Member}, ^self>"
	"Set the memberCollection of the receiver"

	memberCollection := aCollectionOfMembers
]

{ #category : 'Accessing' }
Game >> name [

	"<^iOf String>"
	"Answer the name of the receiver"

	^name
]

{ #category : 'Accessing' }
Game >> name: aString [

	"<aString: iOf String, ^self>"
	"Set the name of the receiver"

	name := aString
]

{ #category : 'Accessing' }
Game >> resultCollection [

	"<^hOf Collection of: {iOf Result}>"
	"Answer the result of the receiver"

	^resultCollection
]

{ #category : 'Accessing' }
Game >> resultCollection: aResultCollection [

	"<aResultCollection: hOf Collection of: {iOf Result}, ^self>"
	"Set the result of the receiver"

	resultCollection := aResultCollection
]
