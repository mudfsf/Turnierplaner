Class {
	#name : 'TournamentPlannerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'viewHolder'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Internal' }
TournamentPlannerView >> buttonDiv [
	
	"<^iOf Me5Div>"
	"Answer the Div with all buttons"
	
	^Me5Div new	
		addChild: (Me5ButtonGroup newJustified
			addChild: (Me5A newSecondary
				text: 'Dashboard';
				icon: Me5I newFasHome;
				addClickEventSelector: #navButtonClicked:;
				yourself);
			addChild: (Me5A newSecondary
				text: 'Turniere';
				icon: Me5I newFasUser;
				addClickEventSelector: #navButtonClicked:;
				yourself);
			addChild: (Me5A newSecondary
				text: 'Teams';
				icon: Me5FontAwesomeIconSolid newSmile;
				addClickEventSelector: #navButtonClicked:;
				yourself);
			addChild: (Me5A newSecondary
				text: 'Einstellungen';
				icon: Me5FontAwesomeIconSolid newCog;	
				addClickEventSelector: #navButtonClicked:;				
				yourself);
			addChild: (Me5A newSecondary
				text: 'Admin-Tools';
				icon: Me5I newFasUser;
				addClickEventSelector: #navButtonClicked:;
				yourself);
			yourself)
]

{ #category : 'Initial-Events' }
TournamentPlannerView >> createComponents [

	"<^self>"

	self viewHolder: (Me5ViewHolder new
		holdingView: DashboardView new).

	self addChild: (Me5H1 new
			addCssClassTextCenter;
			text: 'Turnierplaner';
			yourself);
		addChild: (Me5Portlet new	
			addChildToBody:  self buttonDiv;
			addBreak15ToBody;
			addChildToBody: self viewHolder;
			yourself);
		yourself.
]

{ #category : 'Initial-Events' }
TournamentPlannerView >> createModules [

	"<^self>"

	super createModules.
	
	self addModuleByModuleClass: Me5ComboBoxModuleBundle.
	self addModuleByModuleClass: Me5DataGridModuleBundle.
	self addModuleByModuleClass: Bs4TooltipsterTooltipModuleBundle.
	self addModuleByModuleClass: Me5Select2SelectBoxModuleBundle.
]

{ #category : 'Internal' }
TournamentPlannerView >> navButtonClicked: aEvent [

	"<aEvent: iOf Me5Event, ^self>"
	"Set the viewHolder holdingview"
	
	| theClickedButton theNewView|
	
	theClickedButton := aEvent component text.
	
	theClickedButton = 'Dashboard'
		ifTrue: [theNewView := DashboardView new].
		
	theClickedButton = 'Turniere'
		ifTrue: [theNewView := ManageTournamentsView new].
		
	theClickedButton = 'Teams'
		ifTrue: [theNewView := ManageTeamsView new].
		
	theClickedButton = 'Einstellungen'
		ifTrue: [theNewView := UserSettingsView new].
		
	theClickedButton = 'Admin-Tools'
		ifTrue: [theNewView := ManagePlayersView new].
	
	self viewHolder holdingView: theNewView.
]

{ #category : 'Accessing' }
TournamentPlannerView >> viewHolder [

	"<^iOf Me5ViewHolder>"
	"Answer the viewHolder of the receiver"

	^viewHolder
]

{ #category : 'Accessing' }
TournamentPlannerView >> viewHolder: aMe5ViewHolder [

	"<aMe5ViewHolder: iOf Me5ViewHolder, ^self>"
	"Set the viewHolder of the receiver"

	viewHolder := aMe5ViewHolder
]
