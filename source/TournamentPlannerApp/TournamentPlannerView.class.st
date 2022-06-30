Class {
	#name : 'TournamentPlannerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'viewHolder',
		'dashboardButton',
		'tournamentButton',
		'teamsButton',
		'userSettingsButton',
		'managePlayerButton'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Internal' }
TournamentPlannerView >> buttonDiv [
	
	"<^iOf Me5Div>"
	"Answer the Div with all buttons"
	
	self dashboardButton: (Me5A newSecondary
		text: 'Dashboard';
		addCssClassActive;
		icon: Me5I newFasHome;
		addClickEventSelector: #navButtonClicked:;
		yourself).	
	self tournamentButton: (Me5A newSecondary
		text: 'Turniere';
		icon: Me5I newFasUser;
		addClickEventSelector: #navButtonClicked:;
		yourself).
	self teamsButton: (Me5A newSecondary
		text: 'Teams';
		icon: Me5FontAwesomeIconSolid newSmile;
		addClickEventSelector: #navButtonClicked:;
		yourself).
	self userSettingsButton: (Me5A newSecondary
		text: 'Einstellungen';
		icon: Me5FontAwesomeIconSolid newCog;	
		addClickEventSelector: #navButtonClicked:;				
		yourself).
	self managePlayerButton: (Me5A newSecondary
		text: 'Admin-Tools';
		icon: Me5I newFasUser;
		addClickEventSelector: #navButtonClicked:;
		yourself).		
	^Me5Div new	
		addChild: (Me5ButtonGroup newJustified
			addChild: self dashboardButton;
			addChild: self tournamentButton;
			addChild: self teamsButton;
			addChild: self userSettingsButton;
			addChild: self managePlayerButton;
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

{ #category : 'Accessing' }
TournamentPlannerView >> dashboardButton [

	"<^iOf Me5A>"
	"Answer the dashboardButton of the receiver"

	^dashboardButton
]

{ #category : 'Accessing' }
TournamentPlannerView >> dashboardButton: aMe5A [

	"<aMe5A: iOf Me5A, ^self>"
	"Set the dashboardButton of the receiver"

	dashboardButton := aMe5A
]

{ #category : 'Accessing' }
TournamentPlannerView >> managePlayerButton [

	"<^iOf Me5A>"
	"Answer the managePlayerButton of the receiver"

	^managePlayerButton
]

{ #category : 'Accessing' }
TournamentPlannerView >> managePlayerButton: aMe5A [

	"<aMe5A: iOf Me5A, ^self>"
	"Set the managePlayerButton of the receiver"

	managePlayerButton := aMe5A
]

{ #category : 'Events' }
TournamentPlannerView >> navButtonClicked: aEvent [

	"<aEvent: iOf Me5Event, ^self>"
	"Set the viewHolder holdingview"
	
	| theClickedButton theNewView|
	
	self resetButtonsActiveState.
	theClickedButton := aEvent component.
	
	theClickedButton = self dashboardButton
		ifTrue: [
			self dashboardButton addCssClassActive.
			theNewView := DashboardView new].
		
	theClickedButton = self tournamentButton
		ifTrue: [
			self tournamentButton addCssClassActive.
			theNewView := ManageTournamentsView new].
		
	theClickedButton = self teamsButton
		ifTrue: [
			self teamsButton addCssClassActive.
			theNewView := ManageTeamsView new].
		
	theClickedButton = self userSettingsButton
		ifTrue: [
			self userSettingsButton addCssClassActive.
			theNewView := UserSettingsView new].
		
	theClickedButton = self managePlayerButton
		ifTrue: [
			self managePlayerButton addCssClassActive.
			theNewView := ManagePlayersView new].
	
	self viewHolder holdingView: theNewView.
]

{ #category : 'Internal' }
TournamentPlannerView >> resetButtonsActiveState [

	"<^self>"
	"removes the cssClass active of all buttons"

	self dashboardButton removeCssClassActive.
	self tournamentButton removeCssClassActive.
	self teamsButton removeCssClassActive.
	self userSettingsButton removeCssClassActive.
	self managePlayerButton removeCssClassActive
]

{ #category : 'Accessing' }
TournamentPlannerView >> teamsButton [

	"<^iOf Me5A>"
	"Answer the teamsButton of the receiver"

	^teamsButton
]

{ #category : 'Accessing' }
TournamentPlannerView >> teamsButton: aMe5A [

	"<aMe5A: iOf Me5A, ^self>"
	"Set the teamsButton of the receiver"

	teamsButton := aMe5A
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentButton [

	"<^iOf Me5A>"
	"Answer the tournamentButton of the receiver"

	^tournamentButton
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentButton: aMe5A [

	"<aMe5A: iOf Me5A, ^self>"
	"Set the tournamentButton of the receiver"

	tournamentButton := aMe5A
]

{ #category : 'Accessing' }
TournamentPlannerView >> userSettingsButton [

	"<^iOf Me5A>"
	"Answer the userSettingsButton of the receiver"

	^userSettingsButton
]

{ #category : 'Accessing' }
TournamentPlannerView >> userSettingsButton: aMe5A [

	"<aMe5A: iOf Me5A, ^self>"
	"Set the userSettingsButton of the receiver"

	userSettingsButton := aMe5A
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
