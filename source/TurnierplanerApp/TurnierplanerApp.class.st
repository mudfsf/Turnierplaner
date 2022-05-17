Class {
	#name : 'TurnierplanerApp',
	#superclass : 'Application',
	#category : 'TurnierplanerApp'
}

{ #category : 'Tonel-Metadata' }
TurnierplanerApp class >> startUp [
	"comment"
	| theHttpServer |
	theHttpServer := Me5SstHttpServer startUpHttpServerOnPort: '9003' serverApplicationClass: self.
	theHttpServer addViewClass: TurnierplanerView
]
