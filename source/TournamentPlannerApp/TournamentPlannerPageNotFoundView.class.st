Class {
	#name : 'TournamentPlannerPageNotFoundView',
	#superclass : 'Me5BaseView',
	#category : 'TournamentPlannerApp'
}

{ #category : 'API' }
TournamentPlannerPageNotFoundView class >> layoutClass [

	"<^hOf BsBaseLayout class>"
	"Answer the receiver's layoutClass."

	^Me5PageNotFoundViewLayout
]

{ #category : 'Initial-Events' }
TournamentPlannerPageNotFoundView >> createLayout [

	^super createLayout
		pageNotFoundRedirectUrl: '/TournamentPlannerView';
		pageNotFoundHeadingText: 'Hier gibt es nichts zu sehen';
		pageNotFoundDescriptionText: ('Hier gibt es nichts zu sehen, geh einfach wieder! %1 existiert nicht!' bindWith: self currentHttpTransaction path);
		pageNotFoundButtonText: 'Zur&uuml;ck zur Startseite';
		yourself
]
