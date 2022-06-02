Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'maximumTeamSize',
		'teams'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'instance creation' }
Game class >> maximumTeamSize: aNumber teams: anObject [

	^(self new)
	maximumTeamSize: aNumber;
	teams: anObject;	
	yourself.
]

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
