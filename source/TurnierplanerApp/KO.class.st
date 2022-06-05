Class {
	#name : 'KO',
	#superclass : 'TournamentType',
	#category : 'TurnierplanerApp'
}

{ #category : 'API' }
KO >> getCollectionOfGames: aNumberOfGames [
|startUp thePlayerCollection theGameCollection theTeamCollection theTeamIndex thePlayerIndex theLayerNumber|
	"Load players"
	startUp := StartUp new. 
	thePlayerCollection :=startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\players.dat'.
	thePlayerIndex := 1.
	
	"Create teams"
	theTeamCollection := OrderedCollection new.
	theTeamIndex := 1.
	2 timesRepeat: [
		|theTemporaryTeam theTemporaryPlayers|
		theTemporaryTeam := Team new.
		theTemporaryTeam teamName: ('Team %1' bindWith: theTeamIndex).
		theTeamIndex := theTeamIndex + 1.
		
		"add Player to team"
		theTemporaryPlayers := OrderedCollection new.
		2 timesRepeat: [
			theTemporaryPlayers add: (thePlayerCollection at: thePlayerIndex).
			thePlayerIndex := thePlayerIndex + 1.
		].
		
		theTemporaryTeam players: theTemporaryPlayers.
		
		theTeamCollection add: theTemporaryTeam.
	].
	
	"Create games"
	theLayerNumber := 1.
	aNumberOfGames timesRepeat: [
		|theTemporaryGame|
		theTemporaryGame := Game new.
		theTemporaryGame layer: theLayerNumber.
	].
	
	
	
	
 ^self error: 'Method not implemented'
]

{ #category : 'API' }
KO >> getNumberOfLaps: aNumber [

 ^aNumber asNumber - 1
]
