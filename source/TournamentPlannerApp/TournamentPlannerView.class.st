Class {
	#name : 'TournamentPlannerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'tournamentTab',
		'multiComboBoxRivals',
		'startUp',
		'user',
		'tournamentRow',
		'createTournamentTextFieldTournamentName',
		'collapsiblePortlet',
		'teamsRow',
		'modalTextFieldTeamName',
		'modalMultiComboBoxTeamMembers',
		'removeTeamEvent',
		'radioGroupGameMode',
		'radioGroupTournamentType',
		'playerCombobox'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
TournamentPlannerView >> createComponents [

	"<^self>"

	self addChild: (Me5H1 new
			addCssClassTextCenter;
			text: 'Turnierplaner';
			yourself);
		addChild: (Me5Portlet new	
			addChildToBody: (Me5Tabbable newFilled
				addTabs: self tabsCollection;
				yourself);				
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
TournamentPlannerView >> modalMultiComboBoxTeamMembers [

	"<^hOf Me5MultiComboBox>"
	"Answer the modalMultiComboBoxRivals of the receiver"

	^modalMultiComboBoxTeamMembers
]

{ #category : 'Accessing' }
TournamentPlannerView >> modalMultiComboBoxTeamMembers: aMultiComboBox [

	"<aMultiComboBox: hOf Me5MultiComboBox, ^self>"
	"Set the modalMultiComboBoxRivals of the receiver"

	modalMultiComboBoxTeamMembers := aMultiComboBox
]

{ #category : 'Accessing' }
TournamentPlannerView >> modalTextFieldTeamName [

	"<^iOf Me5TextField>"
	"Answer the modalTextFieldTournamentName of the receiver"

	^modalTextFieldTeamName
]

{ #category : 'Accessing' }
TournamentPlannerView >> modalTextFieldTeamName: aTextfield [

	"<aTextfield: iOf Me5TextField, ^self>"
	"Set the modalTextFieldTournamentName of the receiver"

	modalTextFieldTeamName := aTextfield
]

{ #category : 'Accessing' }
TournamentPlannerView >> playerCombobox [

	"<^iOf Me5Combobox>"
	"Answer the playerCombobox of the receiver"

	^playerCombobox
]

{ #category : 'Accessing' }
TournamentPlannerView >> playerCombobox: aMe5Combobox [

	"<aMe5Combobox: iOf Me5Combobox, ^self>"
	"Set the playerCombobox of the receiver"

	playerCombobox := aMe5Combobox
]

{ #category : 'Accessing' }
TournamentPlannerView >> radioGroupGameMode [

	"<^iOf Me5RadioGroup>"
	"Answer the createTournamentRadioGroupGameMode of the receiver"

	^radioGroupGameMode
]

{ #category : 'Accessing' }
TournamentPlannerView >> radioGroupGameMode: aRadioGroup [

	"<aRadioGroup: iOf Me5RadioGroup, ^self>"
	"Set the createTournamentRadioGroupGameMode of the receiver"

	radioGroupGameMode := aRadioGroup
]

{ #category : 'Internal' }
TournamentPlannerView >> tabsCollection [
	
	"<^hOf Collection of: {hOf Me5Tab}>"
	"Answer the Collection of all tabs"
	
	self tournamentTab: ManageTournamentsView new.
	^OrderedCollection new
		add: (Me5Tab new
			text: 'Dashboard';
			icon: Me5I newFasHome;
			addChildToTabPane: (Me5ViewHolder new
				holdingView: DashboardView new;
				yourself);
			activateTab;
			yourself);
		add: (Me5Tab new
			text: 'Turniere';
			icon: Me5I newFasUser;
			addChildToTabPane: (Me5ViewHolder new
				holdingView: self tournamentTab;
				yourself);
			yourself);
		add: (Me5Tab new
			text: 'Teams';
			icon: Me5FontAwesomeIconSolid newSmile;
			addChildToTabPane: (Me5ViewHolder new
				holdingView: ManageTeamsView new
				yourself);
			yourself);
		add: (Me5Tab new
			text: 'Einstellungen';
			icon: Me5FontAwesomeIconSolid newCog;
			addChildToTabPane: self userSettingsTab;
			yourself);
		add: (Me5Tab new
			text: 'Admin-Tools';
			icon: Me5I newFasUser;
			addChildToTabPane: (Me5ViewHolder new
				holdingView: ManagePlayersView new
				yourself);
			yourself);
		yourself
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentRow [

	"<^iOf Me5Row>"
	"Answer the tournamentRow of the receiver"

	^tournamentRow
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentRow: aTournamentRow [

	"<aTournamentRow: iOf Me5Row, ^self>"
	"Set the tournamentRow of the receiver"

	tournamentRow := aTournamentRow
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentTab [

	"<^iOf ManageTournamentsView>"
	"Answer the tournamentTab of the receiver"

	^tournamentTab
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentTab: aManageTournamentsView [

	"<aManageTournamentsView: iOf ManageTournamentsView, ^self>"
	"Set the tournamentTab of the receiver"

	tournamentTab := aManageTournamentsView
]

{ #category : 'Accessing' }
TournamentPlannerView >> user [

	"<^iOf Player>"
	"Answer the user of the receiver"

	^user
]

{ #category : 'Accessing' }
TournamentPlannerView >> user: aPlayer [

	"<aPlayer: iOf Player, ^self>"
	"Set the user of the receiver"

	user := aPlayer
]

{ #category : 'Events' }
TournamentPlannerView >> userSelectedEvent [

	"^self"
	"Saves the selected player into the logged-in User. This is only used before the log-in is implemented"
	
	| theUsername thePlayer|
	
	theUsername := self playerCombobox selectedObject.
	
	thePlayer := TournamentPlannerApp collectionOfPlayers data at: (TournamentPlannerApp collectionOfPlayers data findFirst: [ :eachPlayer |
		eachPlayer asString = theUsername]) ifAbsent: [ self showErrorNotificationWithMessage: 'Ein Fehler ist aufgetreten, bitte die Seite neuladen'. ^self].

	

	self user: thePlayer.
	TournamentPlannerApp loggedInUser: thePlayer.
	
	self showSuccessNotificationWithMessage: ('Eingeloggter user: %1' bindWith: thePlayer asString).
	self reloadViewBySourceView: self
]

{ #category : 'Internal' }
TournamentPlannerView >> userSettingsTab [

	"<^iOf Me5Div>"
	"Sends the userSettings Tab to the receiver"

	(TournamentPlannerApp loggedInUser isNil)
		ifTrue: [self user: TournamentPlannerApp collectionOfPlayers data first]
		ifFalse: [self user: TournamentPlannerApp loggedInUser].
			
	self playerCombobox: (Me5ComboBox new
					text: 'Benutzer ausw&auml;len';			
					objects: (TournamentPlannerApp collectionOfPlayers data collect: [ :eachPlayer |
						eachPlayer asString]);
					selectedObject: self user asString;
					addChangeEventSelector: #userSelectedEvent eventReceiver: self;
					addCssClassColLg6;
					addCssClassCol12;
					yourself).
			
	^Me5Div new
		addChild: (Me5H1 new 
			text: 'Einstellungen';
			addCssClassTextCenter;
			yourself);
		addChild: Me5Hr new;
			addChild: (Me5Form new
				addChildToBody: (Me5Row  new
					addChild: (Me5TextField new
						text: 'Vorname';
						value: user firstName;
						placeholder: 'Vorname';
						addCssClassCol12;
						addCssClassColLg6;
						yourself);
					addChild: (Me5TextField new
						text: 'Nachname';
						value: user lastName;
						placeholder: 'Nachname';
						addCssClassColLg6;
						addCssClassCol12;
						yourself);
					addChild: (Me5TextField new
						text: 'E-Mail';
						value: user email;
						placeholder: 'E-Mail';
						addCssClassColLg6;
						addCssClassCol12;
						yourself);
					addChild: (Me5PasswordField new
						text: 'Passwort';
						placeholder: 'Passwort';
						addCssClassColLg6;
						addCssClassCol12;
						yourself);
					addChild: self playerCombobox;
					yourself);
				addChildToRow: (Me5Button newPrimary
					text: 'Speichern';
					icon: Me5I newFasSave;
					yourself);
				yourself);
			yourself
]
