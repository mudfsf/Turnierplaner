Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'firstName',
		'lastName',
		'email',
		'symbol'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'instance creation' }
Player class >> firstName: aFirstName lastName: aLastName email: anEmail [

	^(self new)
	firstName:aFirstName;
	lastName:aLastName;
	email:anEmail;
	yourself.
]

{ #category : 'Accessing' }
Player >> = anObject [

	^ (((self firstName = anObject firstName and: [self lastName = anObject lastName]) and: [self email = anObject email]) and: [ self symbol = anObject symbol ])
]

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

{ #category : 'Accessing' }
Player >> symbol [

	^symbol
]

{ #category : 'Accessing' }
Player >> symbol: anObject [

	symbol := anObject
]
