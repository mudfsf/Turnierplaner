Class {
	#name : 'Laps',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'Not categorized' }
Laps >> getNumberOfLaps: aNumber [

	|theSum theCurrentIteration|

	theSum := 0.
	theCurrentIteration := 1.
	
	[ theCurrentIteration < aNumber asNumber ] whileTrue: [
		theSum := theSum + theCurrentIteration.
		theCurrentIteration := theCurrentIteration + 1
	]. 
	^theSum
]
