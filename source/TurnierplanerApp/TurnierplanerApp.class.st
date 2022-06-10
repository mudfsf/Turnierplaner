Class {
	#name : 'TurnierplanerApp',
	#superclass : 'Application',
	#classVars : [
		'CollectionOfTournaments',
		'CollectionOfTeams',
		'CollectionOfPlayers',
		'HttpServer'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> addRouteToHttpServer [

	| theRootPathDefinition |

	theRootPathDefinition := ClwGroupRouteDefinition forPath: ''.

	theRootPathDefinition addRouteDefinitionForPath: 'SpecificTournament' name: '/specificTournament' viewClass: SpecificTournamentView.

	self httpServer
		addRoutesForDefinition: theRootPathDefinition configuration: (ClwRouteCalculatorConfiguration new
			viewUrlHandlerClass: Bs4ViewUrlHandler;
			redirectUrlHandlerClass: Bs4RedirectUrlHandler;
			yourself);
		yourself.
]

{ #category : 'Accessing' }
TurnierplanerApp class >> collectionOfPlayers [

	"<^hOf Collection of: {iOf Player}>"
	"Answer the CollectionOfPlayers of the receiver"

	^CollectionOfPlayers
]

{ #category : 'Accessing' }
TurnierplanerApp class >> collectionOfPlayers: aCollectionOfPlayers [

	"<aCollection: hOf Collection of: {iOf Player}, ^self>"
	"Set the CollectionOfPlayers of the receiver"

	CollectionOfPlayers := aCollectionOfPlayers.
	
]

{ #category : 'Accessing' }
TurnierplanerApp class >> collectionOfTeams [

	"<^hOf Collection of: {iOf Team}>"
	"Answer the CollectionOfTeams of the receiver"

	^CollectionOfTeams
]

{ #category : 'Accessing' }
TurnierplanerApp class >> collectionOfTeams: aCollectionOfTeams [

	"<aCollection: hOf Collection of: {iOf Team}, ^self>"
	"Set the CollectionOfTeams of the receiver"

	CollectionOfTeams := aCollectionOfTeams
]

{ #category : 'Accessing' }
TurnierplanerApp class >> collectionOfTournaments [

	"<^hOf Collection of: {iOf Tournament}>"
	"Answer the CollectionOfTournaments of the receiver"

	^CollectionOfTournaments
]

{ #category : 'Accessing' }
TurnierplanerApp class >> collectionOfTournaments: aCollectionOfTournaments [

	"<aCollection: hOf Collection of: {iOf Tournament}, ^self>"
	"Set the CollectionOfTournaments of the receiver"

	CollectionOfTournaments := aCollectionOfTournaments
]

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> httpServer [

	^HttpServer
]

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> httpServer: anObject [

	HttpServer := anObject
]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
TurnierplanerApp class >> loadAll [

self collectionOfPlayers: (Memory loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\players.dat').
self collectionOfTeams: (Memory loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\teams.dat').
self collectionOfTournaments: (Memory loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\tournaments.dat').
]

{ #category : 'API' }
TurnierplanerApp class >> saveCollectionOfPlayers: aCollectionOfPlayers [

	TurnierplanerApp collectionOfPlayers: aCollectionOfPlayers.
	Memory saveObject: aCollectionOfPlayers onPath: 'C:\TournamentPlanner\Memory\players.dat'
	
]

{ #category : 'API' }
TurnierplanerApp class >> saveCollectionOfTeams: aCollectionOfTeams [

	TurnierplanerApp collectionOfPlayers: aCollectionOfTeams.
	Memory saveObject: aCollectionOfTeams onPath: 'C:\TournamentPlanner\Memory\teams.dat'
	
]

{ #category : 'API' }
TurnierplanerApp class >> saveCollectionOfTournaments: aCollectionOfTournaments [

	TurnierplanerApp collectionOfPlayers: aCollectionOfTournaments.
	Memory saveObject: aCollectionOfTournaments onPath: 'C:\TournamentPlanner\Memory\tournaments.dat'
	
]

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> startUp [
	"comment"
	self loadAll.
	
	self httpServer: (Me5SstHttpServer startUpHttpServerOnPort: '9003' serverApplicationClass: self).
	self httpServer addViewClass: TournamentPlannerView.
	self httpServer addViewClass: ManagePlayersView.
	self addRouteToHttpServer.
]
