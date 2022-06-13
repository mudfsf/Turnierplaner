Class {
	#name : 'Memory',
	#superclass : 'Object',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
Memory class >> loadAnObjectFromPath: aPath [
	
	"<aPath: hOf String, ^self>"
	"Loads an Object from path @aPath"
	
	| theStream theLoader theReturn |

	theStream := CfsReadFileStream open: aPath.
	theStream isBytes: true.
	theLoader := ObjectLoader new.
	theReturn := theLoader loadFromStream: theStream.
	theStream close.
	theLoader hasErrorOccurred
		ifTrue: [self error: theLoader currentErrorString].
	^theReturn
]

{ #category : 'API' }
Memory class >> saveObject: anObject onPath: aPath [
	
	"<anObject: hOf Object, aPath hOf String, ^self>"
	"Saves @anObject on @aPath as Binary"
	
	| theStream theDumper |

	theStream := CfsWriteFileStream open: aPath.
	theStream isBytes: true.
	theDumper := ObjectDumper new.
	theDumper unload: anObject intoStream: theStream.
	theStream close.
	theDumper hasErrorOccurred
		ifTrue: [self error: theDumper currentErrorString]
]
