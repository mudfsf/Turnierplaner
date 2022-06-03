Class {
	#name : 'TurnierplanerApp',
	#superclass : 'Application',
	#classVars : [
		'HttpServer'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> addRouteToHttpServer [

	| theRootPathDefinition |

	theRootPathDefinition := ClwGroupRouteDefinition forPath: ''.

	theRootPathDefinition addRouteDefinitionForPath: 'SpecificTournament' name: '/specificTournament' viewClass: SpecificTournamentView.
	theRootPathDefinition addRouteDefinitionForPath: 'ManagePlayer' name: '/managePlayer' viewClass: ManagePlayerView.

	self httpServer
		addRoutesForDefinition: theRootPathDefinition configuration: (ClwRouteCalculatorConfiguration new
			viewUrlHandlerClass: Bs4ViewUrlHandler;
			redirectUrlHandlerClass: Bs4RedirectUrlHandler;
			yourself);
		yourself.
]

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> httpServer [

	^HttpServer
]

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> httpServer: anObject [

	HttpServer := anObject
]

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> startUp [
	"comment"
	self httpServer: (Me5SstHttpServer startUpHttpServerOnPort: '9003' serverApplicationClass: self).
	self httpServer addViewClass: TournamentPlannerView.
	self addRouteToHttpServer.
]
