Class {
	#name : 'MetaResult',
	#superclass : 'Object',
	#instVars : [
		'context',
		'results'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'instance creation' }
MetaResult class >> context: aResultable results: aListOfResults [
	^(self new)
	context: aResultable;
	results:aListOfResults;
	yourself.
	
]

{ #category : 'Accessing' }
MetaResult >> context [

	^context
]

{ #category : 'Accessing' }
MetaResult >> context: aResultable [

	context := aResultable
]

{ #category : 'Accessing' }
MetaResult >> results [

	^results
]

{ #category : 'Accessing' }
MetaResult >> results: aListOfResults [

	results := aListOfResults
]
