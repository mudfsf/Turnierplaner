Class {
	#name : 'Result',
	#superclass : 'Object',
	#instVars : [
		'player',
		'ranking',
		'points'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'instance creation' }
Result class >> player: aPlayer ranking: aRank points: aNumber [
	^(self new)
	player:aPlayer;
	ranking:aRank;
	points: aNumber;
	yourself.
	
]

{ #category : 'Accessing' }
Result >> player [

	^player
]

{ #category : 'Accessing' }
Result >> player: aPlayer [

	player := aPlayer
]

{ #category : 'Accessing' }
Result >> points [

	^points
]

{ #category : 'Accessing' }
Result >> points: aNumber [

	points := aNumber
]

{ #category : 'Accessing' }
Result >> ranking [

	^ranking
]

{ #category : 'Accessing' }
Result >> ranking: aNumber [

	ranking := aNumber
]
