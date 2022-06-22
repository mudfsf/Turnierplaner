Class {
	#name : 'Team',
	#superclass : 'Member',
	#instVars : [
		'teamName',
		'players'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
Team class >> newWithName: aString [

	"<aString : iOF String, ^self>"
	"Create instance of game with teamName @aString"

	^self new teamName: aString
]

{ #category : 'API' }
Team class >> newWithTeamName: aName players: aPlayerCollection [

	"<aName iOf String,  aPlayer hOf Collection: {iOf Player}, ^self>"
	"Create new Instance with all attributes"

	^self new
		teamName: aName;
		members: aPlayerCollection;
		yourself
]

{ #category : 'API' }
Team >> = anObject [

	"<anObject : iOf any, ^self>"
	"Answer if @anObject is equal to the receiver."

	^self members = anObject members and: [self teamName = anObject teamName]
]

{ #category : 'API' }
Team >> asString [

	"<^iOf String>"
	"Answer the receiver as a string"

	^self teamName
]

{ #category : 'Accessing' }
Team >> members [

	"<^hOf Collection of: {iOf Player}>"
	"Answer the players of the receiver"

	^players
]

{ #category : 'Accessing' }
Team >> members: aPlayerCollection [

	"<aPlayerCollection: hOf Collection of: {iOf Player}, ^self>"
	"Set the players of the receiver"

	players := aPlayerCollection
]

{ #category : 'Accessing' }
Team >> teamName [

	"<^iOf String>"
	"Answer the teamName of the receiver"

	^teamName
]

{ #category : 'Accessing' }
Team >> teamName: aString [

	"<aString: iOf String, ^self>"
	"Set the teamName of the receiver"

	teamName := aString
]
