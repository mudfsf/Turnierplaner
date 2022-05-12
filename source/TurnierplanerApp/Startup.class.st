Class {
	#name : 'Startup',
	#superclass : 'Object',
	#category : 'TurnierplanerApp'
}

{ #category : 'Accessing' }
Startup >> loadObject: anObject fromPath: aPath [
	
	| stream loader return |

	stream := CfsReadFileStream open: aPath.
		
	stream isBytes: true.
	loader := ObjectLoader new.
	return := loader loadFromStream: stream.
	stream close.
	
	loader hasErrorOccurred
		ifTrue: [self error: loader currentErrorString].
	^return
]

{ #category : 'Accessing' }
Startup >> saveObject: anObject onPath: aPath [
	
	| stream dumper |

	stream := CfsWriteFileStream open: aPath.
		
	stream isBytes: true.
	dumper := ObjectDumper new.
	 dumper unload: anObject intoStream: stream.
	 stream close.
	
	dumper hasErrorOccurred
		ifTrue: [self error: dumper currentErrorString].
]
