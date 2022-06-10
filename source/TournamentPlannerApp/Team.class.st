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

{ #category : 'Accessing' }
Team >> players [

	^players
]

{ #category : 'Accessing' }
Team >> players: anObject [

	players := anObject
]

{ #category : 'Accessing' }
Team >> teamName [

	^teamName
]

{ #category : 'Accessing' }
Team >> teamName: aTeamName [

	teamName := aTeamName
]
