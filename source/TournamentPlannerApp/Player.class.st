Class {
	#name : 'Player',
	#superclass : 'Member',
	#instVars : [
		'firstName',
		'lastName',
		'email',
		'symbol'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
Player class >> newWithFirstName: aFirstNameString lastName: aLastNameString email: anEmailString [

	"<aFirstNameString : hOF String, aLastNameString : hOF String, anEmailString : hOf String ^self>"
	"Create instance of game with attributes"
	
	^self new
		firstName: aFirstNameString;
		lastName: aLastNameString;
		email: anEmailString;
		yourself
]

{ #category : 'API' }
Player class >> newWithName: aString [

	"<aString : hOF String, ^self>"
	"Create instance of game with firstName @aString"

	^self new firstName: aString
]

{ #category : 'API' }
Player >> = anObject [

	"<anObject: hOf Object, ^self>"
	"Answer if @anObject is equal to the receiver."

	^(((self firstName = anObject firstName and: [self lastName = anObject lastName]) and: [self email = anObject email]) and: [self symbol = anObject symbol])
]

{ #category : 'API' }
Player >> asString [

	"Answer the receiver as a string"

	^'%1 %2' bindWith: self firstName with: self lastName
]

{ #category : 'Accessing' }
Player >> email [

	"<^hOf String>"
	"Answer the email of the receiver"
	
	^email
]

{ #category : 'Accessing' }
Player >> email: anEmail [

	"<anEmail: hOf String, ^self>"
	"Set the email of the receiver"

	email := anEmail
]

{ #category : 'Accessing' }
Player >> firstName [

	"<^hOf String>"
	"Answer the firstName of the receiver"
	
	^firstName
]

{ #category : 'Accessing' }
Player >> firstName: aFirstName [

	"<aFirstName: hOf String, ^self>"
	"Set the firstName of the receiver"

	firstName := aFirstName
]

{ #category : 'Accessing' }
Player >> lastName [

	"<^hOf String>"
	"Answer the lastName of the receiver"

	^lastName
]

{ #category : 'Accessing' }
Player >> lastName: aLastName [

	"<aLastName: hOf String, ^self>"
	"Set the lastName of the receiver"
	
	lastName := aLastName
]

{ #category : 'Accessing' }
Player >> symbol [

	"<^hOf Symbol>"
	"Answer the symbol of the receiver"

	^symbol
]

{ #category : 'Accessing' }
Player >> symbol: aSymbol [

	"<aSymbol: hOf Symbol, ^self>"
	"Set the symbol of the receiver"
	
	symbol := aSymbol
]
