Class {
	#name : 'Memory',
	#superclass : 'Object',
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
Memory class >> loadAnObjectFromPath: aPath [
	
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
	
	| theStream theDumper |

	theStream := CfsWriteFileStream open: aPath.
		
	theStream isBytes: true.
	theDumper := ObjectDumper new.
	 theDumper unload: anObject intoStream: theStream.
	 theStream close.
	
	theDumper hasErrorOccurred
		ifTrue: [self error: theDumper currentErrorString].
]

{ #category : 'Accessing' }
Memory >> loadAnObjectFromPath: aPath [
	
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

{ #category : 'Accessing' }
Memory >> saveObject: anObject onPath: aPath [
	
	| theStream theDumper |

	theStream := CfsWriteFileStream open: aPath.
		
	theStream isBytes: true.
	theDumper := ObjectDumper new.
	 theDumper unload: anObject intoStream: theStream.
	 theStream close.
	
	theDumper hasErrorOccurred
		ifTrue: [self error: theDumper currentErrorString].
]
