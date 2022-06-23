Class {
	#name : 'Result',
	#superclass : 'Object',
	#instVars : [
		'player',
		'ranking',
		'points'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
Result class >> newWithPlayer: aPlayer ranking: aRank points: aNumber [

	"<aPlayer: iOf Player, aRank: hOf Number, aNumber: hOf Number, ^self>"
	"Create instance of Result with all attributes"

	^self new
		player: aPlayer;
		ranking: aRank;
		points: aNumber;
		yourself
]

{ #category : 'Accessing' }
Result >> = anObject [

	"<anObject: iOf any, ^self>"
	"Answer if @anObject is equal to the receiver."
	
	^(self player = anObject player and: [self ranking = anObject ranking]) and: [self points = anObject points]
]

{ #category : 'Accessing' }
Result >> player [

	"<^iOf Player>"
	"Answer the player of the receiver"

	^player
]

{ #category : 'Accessing' }
Result >> player: aPlayer [

	"<aPlayer: iOf Player, ^self>"
	"Set the player of the receiver"

	player := aPlayer
]

{ #category : 'Accessing' }
Result >> points [

	"<^hOf Number>"
	"Answer the points of the receiver"

	^points
]

{ #category : 'Accessing' }
Result >> points: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the points of the receiver"

	points := aNumber
]

{ #category : 'Accessing' }
Result >> ranking [

	"<^hOf Number>"
	"Answer the ranking of the receiver"

	^ranking
]

{ #category : 'Accessing' }
Result >> ranking: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the ranking of the receiver"

	ranking := aNumber
]
