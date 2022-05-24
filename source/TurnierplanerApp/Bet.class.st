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

{ #category : 'Accessing' }
Bet >> guess [

	^guess
]

{ #category : 'Accessing' }
Bet >> guess: aMetaResult [

	guess := aMetaResult
]

{ #category : 'Accessing' }
Bet >> player [

	^player
]

{ #category : 'Accessing' }
Bet >> player: aPlayer [

	player := aPlayer
]

{ #category : 'Accessing' }
Bet >> stake [

	^stake
]

{ #category : 'Accessing' }
Bet >> stake: anObject [

	stake := anObject
]
