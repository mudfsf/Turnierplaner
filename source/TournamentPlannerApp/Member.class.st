Class {
	#name : 'Member',
	#superclass : 'Object',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
Member class >> newWithName: aString [

	"<aFirstNameString : iOF String, aLastNameString : iOF String, anEmailString : iOf String ^self>"
	"Create instance of game with attributes"
	
	^self subclassResponsibility
]

{ #category : 'API' }
Member >> asString [

	"<^iOf String>"
	"Answer the receiver as a string"
	
	^self subclassResponsibility
]
