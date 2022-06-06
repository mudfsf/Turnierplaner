Class {
	#name : 'Mixed',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'Not categorized' }
Mixed >> getCollectionOfGamesWithTeams: aCollectionOfTeams [
	
	|theLaps theKO theCollectionOfTeams|
	theCollectionOfTeams := (OrderedCollection new
		add: (Team new
			teamName: 'first';
			yourself);
		add: (Team new
			teamName: 'second';
			yourself);
		add: (Team new
			teamName: 'third';
			yourself);
		add: (Team new
			teamName: 'fourtht';
			yourself);
	yourself).
	theLaps := Laps new.
	theKO := KO new.
	theKO initialize.
	^ (OrderedCollection new
		addAll: (theLaps getCollectionOfGamesWithTeams: aCollectionOfTeams);
		addAll: (theKO getCollectionOfGamesWithTeams: theCollectionOfTeams);
		yourself).

]

{ #category : 'API' }
Mixed >> getNumberOfLaps: aNumber [

	|theNumberofLaps theLaps theKO|
	
	theLaps := Laps new.
	theKO := KO new.
	
	theNumberofLaps := theLaps getNumberOfLaps: aNumber asNumber.
	theNumberofLaps := theNumberofLaps + (theKO getNumberOfLaps: aNumber asNumber / 2).
	
	^theNumberofLaps
]
