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

{ #category : 'Not categorized' }
Player >> email [

	^email
]

{ #category : 'Not categorized' }
Player >> email: anEmail [

	email := anEmail
]

{ #category : 'Not categorized' }
Player >> firstName [

	^firstName
]

{ #category : 'Not categorized' }
Player >> firstName: aFirstName [

	firstName := aFirstName
]

{ #category : 'Not categorized' }
Player >> lastName [

	^lastName
]

{ #category : 'Not categorized' }
Player >> lastName: aLastName [

	lastName := aLastName
]
