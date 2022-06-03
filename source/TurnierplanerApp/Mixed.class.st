Class {
	#name : 'Mixed',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'Events' }
Mixed >> getNumberOfLaps: aNumber [

	|theNumberofLaps theLaps theKO|
	
	theLaps := Laps new.
	theKO := KO new.
	
	theNumberofLaps := theLaps getNumberOfLaps: aNumber asNumber.
	theNumberofLaps := theNumberofLaps + (theKO getNumberOfLaps: aNumber asNumber / 2).
	
	^theNumberofLaps
]
