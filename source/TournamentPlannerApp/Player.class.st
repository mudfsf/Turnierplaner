Class {
	#name : 'Player',
	#superclass : 'Member',
	#instVars : [
		'firstName',
		'lastName',
		'email',
		'symbol',
		'money'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
Player class >> newWithFirstName: aFirstNameString lastName: aLastNameString email: anEmailString [

	"<aFirstNameString : iOF String, aLastNameString : iOF String, anEmailString : iOf String ^self>"
	"Create instance of game with attributes"
	
	^self new
		firstName: aFirstNameString;
		lastName: aLastNameString;
		email: anEmailString;
		yourself
]

{ #category : 'API' }
Player class >> newWithName: aString [

	"<aString : iOF String, ^self>"
	"Create instance of game with firstName @aString"

	^self new 
		firstName: aString;
		lastName: '';
		yourself
]

{ #category : 'API' }
Player >> = anObject [

	"<anObject: iOf any, ^self>"
	"Answer if @anObject is equal to the receiver."

	(anObject isMemberOf: Player)
		ifTrue:[^(((self firstName = anObject firstName and: [self lastName = anObject lastName]) and: [self email = anObject email]) and: [self money = anObject money]) and: [self symbol = anObject symbol]]
		ifFalse:[^false].
]

{ #category : 'API' }
Player >> asString [

	"<^iOf String>"
	"Answer the receiver as a string"

	^'%1 %2' bindWith: self firstName with: self lastName
]

{ #category : 'Accessing' }
Player >> email [

	"<^iOf String>"
	"Answer the email of the receiver"
	
	^email
]

{ #category : 'Accessing' }
Player >> email: anEmail [

	"<anEmail: iOf String, ^self>"
	"Set the email of the receiver"

	email := anEmail
]

{ #category : 'Accessing' }
Player >> firstName [

	"<^iOf String>"
	"Answer the firstName of the receiver"
	
	^firstName
]

{ #category : 'Accessing' }
Player >> firstName: aFirstName [

	"<aFirstName: iOf String, ^self>"
	"Set the firstName of the receiver"

	firstName := aFirstName
]

{ #category : 'API' }
Player >> isValid [

	"<^iOf Boolean>"
	"Answer the receiver as a string"

	((((self firstName isEmpty or: [self lastName isEmpty]) or: [self email isEmpty]) or: [self symbol isEmpty]) or: [self money isNil])
		ifTrue:[^false]
		ifFalse:[^true].
]

{ #category : 'Accessing' }
Player >> lastName [

	"<^iOf String>"
	"Answer the lastName of the receiver"

	^lastName
]

{ #category : 'Accessing' }
Player >> lastName: aLastName [

	"<aLastName: iOf String, ^self>"
	"Set the lastName of the receiver"
	
	lastName := aLastName
]

{ #category : 'Accessing' }
Player >> money [

	"<^hOf Number>"
	"Answer the money of the receiver"

	^money
]

{ #category : 'Accessing' }
Player >> money: anInteger [

	"<anInteger: hOf Number, ^self>"
	"Set the money of the receiver"

	money := anInteger
]

{ #category : 'Accessing' }
Player >> symbol [

	"<^iOf Symbol>"
	"Answer the symbol of the receiver"

	^symbol
]

{ #category : 'Accessing' }
Player >> symbol: aSymbolOrString [

	"<aSymbolOrString: iOf Symbol | iOf String, ^self>"
	"Set the symbol of the receiver"
	
	symbol := aSymbolOrString asSymbol
]
