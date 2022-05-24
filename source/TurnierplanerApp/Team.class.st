Class {
	#name : 'Team',
	#superclass : 'Object',
	#instVars : [
		'teamName',
		'players'
	],
	#category : 'TurnierplanerApp'
}

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
