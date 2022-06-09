Class {
	#name : 'Mixed',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
Mixed >> getCollectionOfGamesWithPlayers: aCollectionOfPlayers [
	
	|theLaps theKO theCollectionOfPlayers theCollectionOfGames|

	theCollectionOfPlayers := OrderedCollection new.
	theCollectionOfPlayers addAll: aCollectionOfPlayers.
	theCollectionOfGames := OrderedCollection new.
	theLaps := Laps new.
	theKO := KO new.
	aCollectionOfPlayers size > 4
	ifTrue: [
		theCollectionOfGames addAll: (theLaps getCollectionOfGamesWithTeams: aCollectionOfPlayers).
		theCollectionOfPlayers := (OrderedCollection new
			add: (Team new
				teamName: 'first';
				players: OrderedCollection new;
				yourself);
			add: (Team new
				teamName: 'second';
				players: OrderedCollection new;
				yourself);
			add: (Team new
				teamName: 'third';
				players: OrderedCollection new;
				yourself);
			add: (Team new
				teamName: 'fourtht';
				players: OrderedCollection new;
				yourself);
			yourself).
	].

	theCollectionOfGames addAll: (theKO getCollectionOfGamesWithTeams: theCollectionOfPlayers).
	^theCollectionOfGames
]

{ #category : 'Not categorized' }
Mixed >> getCollectionOfGamesWithTeams: aCollectionOfTeams [
	
	|theLaps theKO theCollectionOfTeams theCollectionOfGames|

	theCollectionOfTeams := OrderedCollection new.
	theCollectionOfTeams addAll: aCollectionOfTeams.
	theCollectionOfGames := OrderedCollection new.
	theLaps := Laps new.
	theKO := KO new.
	aCollectionOfTeams size > 4
	ifTrue: [
		theCollectionOfGames addAll: (theLaps getCollectionOfGamesWithTeams: aCollectionOfTeams).
		theCollectionOfTeams := (OrderedCollection new
			add: (Team new
				teamName: 'first';
				players: OrderedCollection new;
				yourself);
			add: (Team new
				teamName: 'second';
				players: OrderedCollection new;
				yourself);
			add: (Team new
				teamName: 'third';
				players: OrderedCollection new;
				yourself);
			add: (Team new
				teamName: 'fourtht';
				players: OrderedCollection new;
				yourself);
			yourself).
	].

	theCollectionOfGames addAll: (theKO getCollectionOfGamesWithTeams: theCollectionOfTeams).
	^theCollectionOfGames
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
