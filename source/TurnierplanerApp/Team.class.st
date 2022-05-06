Class {
	#name : 'Team',
	#superclass : 'Object',
	#instVars : [
		'teamName',
		'players'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Not categorized' }
Team >> players [

	^players
]

{ #category : 'Not categorized' }
Team >> players: aPlayers [

	players := aPlayers
]

{ #category : 'Not categorized' }
Team >> teamName [

	^teamName
]

{ #category : 'Not categorized' }
Team >> teamName: aTeamName [

	teamName := aTeamName
]
