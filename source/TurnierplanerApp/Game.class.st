Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'maximumTeamSize',
		'teams',
		'layer',
		'name'
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
Game >> layer [

	^layer
]

{ #category : 'Accessing' }
Game >> layer: aNumber [

	layer := aNumber
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
Game >> name [

	^name
]

{ #category : 'Accessing' }
Game >> name: anObject [

	name := anObject
]

{ #category : 'Accessing' }
Game >> teams [

	^teams
]

{ #category : 'Accessing' }
Game >> teams: anObject [

	teams := anObject
]
