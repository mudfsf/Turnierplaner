Class {
	#name : 'Team',
	#superclass : 'Object',
	#instVars : [
		'teamName',
		'players'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'instance creation' }
Team class >> teamName: aName players: anObject [

	^(self new)
	teamName: aName;
	players: anObject;
	yourself.
]

{ #category : 'API' }
Team >> = anObject [

	"<anObject : hOf Object, ^self>"
	"Answer if @anObject is equal to the receiver."

	^self players = anObject players and: [self teamName = anObject teamName]
]

{ #category : 'API' }
Team >> asString [

	"Answer the receiver as a string"

	^self teamName 
]

{ #category : 'Accessing' }
Team >> players [

	"<^hOf Collection of: iOf Player>"
	"Answer the players of the receiver"

	^players
]

{ #category : 'Accessing' }
Team >> players: aPlayerCollection [

	"<aPlayerCollection: hOf Collection of: iOf Player, ^self>"
	"Set the players of the receiver"

	players := aPlayerCollection
]

{ #category : 'Accessing' }
Team >> teamName [

	"<^hOf String>"
	"Answer the teamName of the receiver"

	^teamName
]

{ #category : 'Accessing' }
Team >> teamName: aTeamName [

	"<aTeamName: hOf String, ^self>"
	"Set the teamName of the receiver"

	teamName := aTeamName
]
