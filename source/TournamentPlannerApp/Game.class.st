Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'layer',
		'name',
		'members',
		'isBuy'
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
Game >> isBuy [

	"<^(true | false)>"
	"Answer the isBuy of the receiver"

	^isBuy
]

{ #category : 'Accessing' }
Game >> isBuy: aBoolean [

	"<aBoolean: (true | false), ^self>"
	"Set the isBuy of the receiver"

	isBuy := aBoolean
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
Game >> members [

	"<^hOf Collection of: {iOf Member}>"
	"Answer the members of the receiver"

	^members
]

{ #category : 'Accessing' }
Game >> members: aCollection [

	"<aCollection: hOf Collection of: {iOf Member}, ^self>"
	"Set the members of the receiver"

	members := aCollection
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
