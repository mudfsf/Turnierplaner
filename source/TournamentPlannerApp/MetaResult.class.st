Class {
	#name : 'MetaResult',
	#superclass : 'Object',
	#instVars : [
		'context',
		'results'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
MetaResult class >> newWithContext: aResultable results: aCollectionOfResults [

	"<aResultable: iOf Resultable, aCollectionOfResults: hOf Collection of: {iOf Result}, ^self>"
	"Create instance of MetaResult with all attributes"

	^self new
		context: aResultable;
		results: aCollectionOfResults;
		yourself
]

{ #category : 'Accessing' }
MetaResult >> context [

	"<^iOf Resultable>"
	"Answer the context of the receiver"

	^context
]

{ #category : 'Accessing' }
MetaResult >> context: aResultable [

	"<aResultable: iOf Resultable, ^self>"
	"Set the context of the receiver"

	context := aResultable
]

{ #category : 'Accessing' }
MetaResult >> results [

	"<^hOf Collection of: {iOf Result}>"
	"Answer the results of the receiver"

	^results
]

{ #category : 'Accessing' }
MetaResult >> results: aCollection [

	"<aCollection: hOf Collection of: {iOf Result}, ^self>"
	"Set the results of the receiver"

	results := aCollection
]
