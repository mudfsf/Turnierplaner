Class {
	#name : 'Bet',
	#superclass : 'Object',
	#instVars : [
		'player',
		'guess',
		'stake'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
Bet class >> newWithPlayer: aPlayer guess: aMetaResult stake: aDecimal [

	"<aPlayer: iOf Player, aMetaResult: iOf MetaResult, aDecimal: iOf Decimal, ^self>"
	"Create instance of Bet with attributes"

	^self new
		player: aPlayer;
		guess: aMetaResult;
		stake: aDecimal;
		yourself.
]

{ #category : 'Accessing' }
Bet >> guess [

	"<^iOf MetaResult>"
	"Answer the guess of the receiver"

	^guess
]

{ #category : 'Accessing' }
Bet >> guess: aMetaResult [

	"<aMetaResult: iOf MetaResult, ^self>"
	"Set the guess of the receiver"

	guess := aMetaResult
]

{ #category : 'Accessing' }
Bet >> player [

	"<^iOf Player>"
	"Answer the player of the receiver"

	^player
]

{ #category : 'Accessing' }
Bet >> player: aPlayer [

	"<aPlayer: iOf Player, ^self>"
	"Set the player of the receiver"

	player := aPlayer
]

{ #category : 'Accessing' }
Bet >> stake [

	"<^hOf Decimal>"
	"Answer the stake of the receiver"

	^stake
]

{ #category : 'Accessing' }
Bet >> stake: aDecimal [

	"<aDecimal: hOf Decimal, ^self>"
	"Set the stake of the receiver"
	
	stake := aDecimal
]
