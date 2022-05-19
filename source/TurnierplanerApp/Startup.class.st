Class {
	#name : 'StartUp',
	#superclass : 'Object',
	#category : 'TurnierplanerApp'
}

{ #category : 'Accessing' }
StartUp >> loadAnObjectFromPath: aPath [
	
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
StartUp >> saveObject: anObject onPath: aPath [
	
	| theStream theDumper |

	theStream := CfsWriteFileStream open: aPath.
		
	theStream isBytes: true.
	theDumper := ObjectDumper new.
	 theDumper unload: anObject intoStream: theStream.
	 theStream close.
	
	theDumper hasErrorOccurred
		ifTrue: [self error: theDumper currentErrorString].
]
