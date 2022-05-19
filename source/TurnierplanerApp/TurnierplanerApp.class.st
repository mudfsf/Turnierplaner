Class {
	#name : 'TurnierplanerApp',
	#superclass : 'Application',
	#category : 'TurnierplanerApp'
}

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> startUp [

	| theHttpServer theStartUp|
	
	theStartUp := StartUp new.
	theHttpServer := Me5SstHttpServer startUpHttpServerOnPort: '9003' serverApplicationClass: self.
	theHttpServer addViewClass: TournamentPlannerView 
]
