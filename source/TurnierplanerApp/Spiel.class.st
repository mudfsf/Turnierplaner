Class {
	#name : 'Spiel',
	#superclass : 'Object',
	#instVars : [
		'teamSize',
		'teams',
		'modus'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Not categorized' }
Spiel >> teams [

	^teams
]

{ #category : 'Not categorized' }
Spiel >> teams: anObject [

	teams := anObject
]

{ #category : 'Not categorized' }
Spiel >> teamSize [

	^teamSize
]

{ #category : 'Not categorized' }
Spiel >> teamSize: anObject [

	teamSize := anObject
]
