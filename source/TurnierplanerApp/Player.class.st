Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'firstName',
		'lastName',
		'email'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Accessing' }
Player >> email [

	^email
]

{ #category : 'Accessing' }
Player >> email: anEmail [

	email := anEmail
]

{ #category : 'Accessing' }
Player >> firstName [

	^firstName
]

{ #category : 'Accessing' }
Player >> firstName: aFirstName [

	firstName := aFirstName
]

{ #category : 'Accessing' }
Player >> lastName [

	^lastName
]

{ #category : 'Accessing' }
Player >> lastName: aLastName [

	lastName := aLastName
]
