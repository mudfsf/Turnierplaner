Class {
	#name : 'TournamentPlannerApp',
	#superclass : 'Application',
	#classVars : [
		'CollectionOfTournaments',
		'LoggedInUser',
		'CollectionOfTeams',
		'CollectionOfPlayers',
		'HttpServer'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initials' }
TournamentPlannerApp class >> addRouteToHttpServer [

	"<^self>"

	| theRootPathDefinition |

	theRootPathDefinition := ClwGroupRouteDefinition forPath: ''.
	theRootPathDefinition addRouteDefinitionForPath: 'SpecificTournament' name: '/specificTournament' viewClass: SpecificTournamentView.
	self httpServer
		addRoutesForDefinition: theRootPathDefinition configuration: (ClwRouteCalculatorConfiguration new
			viewUrlHandlerClass: Bs4ViewUrlHandler;
			redirectUrlHandlerClass: Bs4RedirectUrlHandler;
			yourself);
		yourself
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> collectionOfPlayers [

	"<^hOf Collection of: {iOf MemoryData}>"
	"Answer the CollectionOfPlayers of the receiver"

	^CollectionOfPlayers
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> collectionOfPlayers: aCollectionOfPlayers [

	"<aCollectionOfPlayers: hOf Collection of: {iOf MemoryData}, ^self>"
	"Set the CollectionOfPlayers of the receiver"

	CollectionOfPlayers := aCollectionOfPlayers.
	
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> collectionOfTeams [

	"<^hOf Collection of: {iOf MemoryData}>"
	"Answer the CollectionOfTeams of the receiver"

	^CollectionOfTeams
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> collectionOfTeams: aCollectionOfTeams [

	"<aCollectionOfTeams: hOf Collection of: {iOf MemoryData}, ^self>"
	"Set the CollectionOfTeams of the receiver"

	CollectionOfTeams := aCollectionOfTeams
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> collectionOfTournaments [

	"<^hOf Collection of: {iOf MemoryData}>"
	"Answer the CollectionOfTournaments of the receiver"

	^CollectionOfTournaments
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> collectionOfTournaments: aCollectionOfTournaments [

	"<aCollection: hOf Collection of: {iOf MemoryData}, ^self>"
	"Set the CollectionOfTournaments of the receiver"

	CollectionOfTournaments := aCollectionOfTournaments
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> httpServer [

	"<^hOf HttpServer>"
	"Answer the httpServer of the receiver"

	^HttpServer
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> httpServer: aHttpServer [

	"<aHttpServer: hOf httpServer, ^self>"
	"Set the HttpServer of the receiver"

	HttpServer := aHttpServer
]

{ #category : 'Initials',
  #vaVisibility : 'private' }
TournamentPlannerApp class >> loadAll [

	"^self"
	"Sets collectionOfPlayers, collectionOfTeams, collectionOfTournaments"
	
	self collectionOfPlayers: (MemoryData new
		data: (Memory loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\players.dat');
		observerCollection: OrderedCollection new;
		yourself).
	self collectionOfTeams: (MemoryData new
		data: (Memory loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\teams.dat');
		observerCollection: OrderedCollection new;
		yourself).
	self collectionOfTournaments: (MemoryData new
		data: (Memory loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\tournaments.dat');
		observerCollection: OrderedCollection new;
		yourself)
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> loggedInUser [

	"<^iOf Player>"
	"Answer the LoggedInUser of the receiver"

	^LoggedInUser
]

{ #category : 'Accessing' }
TournamentPlannerApp class >> loggedInUser: aPlayer [

	"<aPlayer: iOf Player, ^self>"
	"Set the LoggedInUser of the receiver"

	LoggedInUser := aPlayer
]

{ #category : 'API' }
TournamentPlannerApp class >> saveCollectionOfPlayers: aCollectionOfPlayers [

	"<aCollectionOfTeams: hOf Collection of: {iOf Player}, ^self>"
	"Saves the collectionOfPlayers of the receiver"

	TournamentPlannerApp collectionOfPlayers data: aCollectionOfPlayers.
	Memory saveObject: aCollectionOfPlayers onPath: 'C:\TournamentPlanner\Memory\players.dat'.
	TournamentPlannerApp collectionOfPlayers observerCollection do: [ :eachObserver |
		eachObserver resetData]
]

{ #category : 'API' }
TournamentPlannerApp class >> saveCollectionOfTeams: aCollectionOfTeams [

	"<aCollectionOfTeams: hOf Collection of: {iOf Team}, ^self>"
	"Saves the collectionOfTeams of the receiver"

	TournamentPlannerApp collectionOfTeams data: aCollectionOfTeams.
	Memory saveObject: aCollectionOfTeams onPath: 'C:\TournamentPlanner\Memory\teams.dat'.
	TournamentPlannerApp collectionOfTeams observerCollection do: [ :eachObserver |
		eachObserver resetData]
]

{ #category : 'API' }
TournamentPlannerApp class >> saveCollectionOfTournaments: aCollectionOfTournaments [

	"<aCollectionOfTournaments: hOf Collection of: {iOf Tournament}, ^self>"
	"Saves the collectionOfTournaments of the receiver"
	
	TournamentPlannerApp collectionOfTournaments data: aCollectionOfTournaments.
	Memory saveObject: aCollectionOfTournaments onPath: 'C:\TournamentPlanner\Memory\tournaments.dat'.
	TournamentPlannerApp collectionOfTournaments observerCollection do: [ :eachObserver |
		eachObserver resetData]
]

{ #category : 'Initials' }
TournamentPlannerApp class >> startUp [
	
	"<^self>"
	"Starts server, loads data and adds views."
	
	self loadAll.
	self httpServer: (Me5SstHttpServer startUpHttpServerOnPort: '9004' serverApplicationClass: self).
	self httpServer addViewClass: TournamentPlannerView.
	self addRouteToHttpServer
]
