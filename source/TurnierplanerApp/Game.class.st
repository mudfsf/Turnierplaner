Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'maximumTeamSize',
		'teams'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Accessing' }
Game >> maximumTeamSize [

	^maximumTeamSize
]

{ #category : 'Accessing' }
Game >> maximumTeamSize: anObject [

	maximumTeamSize := anObject
]

{ #category : 'Accessing' }
Game >> teams [

	^teams
]

{ #category : 'Accessing' }
Game >> teams: anObject [

	teams := anObject
]
