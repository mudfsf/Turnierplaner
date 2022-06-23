Class {
	#name : 'MemoryData',
	#superclass : 'Object',
	#instVars : [
		'data',
		'observerCollection'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Accessing' }
MemoryData >> data [

	"<^hOf Collection of: {hOf Object}>"
	"Answer the data of the receiver"

	^data
]

{ #category : 'Accessing' }
MemoryData >> data: aCollection [

	"<aCollection: hOf Collection of: {hOf Object}, ^self>"
	"Set the data of the receiver"

	data := aCollection
]

{ #category : 'Accessing' }
MemoryData >> observerCollection [

	"<^hOf Collection of: {iOf Me5BaseView}>"
	"Answer the observerCollection of the receiver"

	^observerCollection
]

{ #category : 'Accessing' }
MemoryData >> observerCollection: aMe5BaseViewCollection [

	"<aMe5BaseViewCollection: hOf Collection of: {iOf Me5BaseView}, ^self>"
	"Set the observerCollection of the receiver"

	observerCollection := aMe5BaseViewCollection
]
