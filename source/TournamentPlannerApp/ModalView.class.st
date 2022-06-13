Class {
	#name : 'ModalView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'body',
		'title',
		'foot'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Not categorized' }
ModalView class >> layoutClass [

	^Me5ModalViewLayout
]

{ #category : 'Accessing' }
ModalView >> body [

	"<^hOf Me5BaseComponent>"
	"Answer the body of the receiver"

	^body
]

{ #category : 'Accessing' }
ModalView >> body: aMe5BaseComponent [

	"<aMe5BaseComponent: hOf Me5BaseComponent, ^self>"
	"Set the body of the receiver"

	body := aMe5BaseComponent
]

{ #category : 'Events' }
ModalView >> closeEvent [

	"<^self>"
	"closes Modal"
	
	self closeModal
]

{ #category : 'Initial-Events' }
ModalView >> createComponents [

	self modal 
		title: self title;
		addChildToHead: (Me5A newButtonIconOnly
			icon: Me5I newFasArrowCircleUp;
			addClickEventSelector: #closeEvent eventReceiver: self;
			yourself);
		yourself.
		
	self body notNil
		ifTrue: [self modal addChildToBody: self body].
	self foot notNil
		ifTrue: [self modal addChildToFoot: self foot]
]

{ #category : 'Accessing' }
ModalView >> foot [

	"<^hOf Me5BaseComponent>"
	"Answer the foot of the receiver"

	^foot
]

{ #category : 'Accessing' }
ModalView >> foot: aMe5BaseComponent [

	"<aMe5BaseComponent: hOf Me5BaseComponent, ^self>"
	"Set the foot of the receiver"

	foot := aMe5BaseComponent
]

{ #category : 'Accessing' }
ModalView >> title [

	"<^iOf String>"
	"Answer the title of the receiver"

	^title
]

{ #category : 'Accessing' }
ModalView >> title: aString [

	"<aString: iOf String, ^self>"
	"Set the title of the receiver"

	title := aString
]
