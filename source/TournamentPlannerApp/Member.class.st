Class {
	#name : 'Member',
	#superclass : 'Object',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
Member class >> newWithName: aString [

	"<aFirstNameString : hOF String, aLastNameString : hOF String, anEmailString : hOf String ^self>"
	"Create instance of game with attributes"
	
	^self subclassResponsibility
]

{ #category : 'API' }
Member >> asString [

	"<^hOf String>"
	"Answer the receiver as a string"
	
	^self subclassResponsibility
]
