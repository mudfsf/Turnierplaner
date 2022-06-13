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
		'radioGroupTournamentType'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Events' }
TournamentPlannerView >> buttonNewTeam [

	| theSingleTeamDiv theTeamMembers theTeam theExistingTeam|
	
	theTeamMembers := OrderedCollection new.
	theSingleTeamDiv := Me5Div new.
	
	self modalTextFieldTeamName value = ''
		ifTrue: [
			self showErrorNotificationWithMessage: 'Team hat keinen Namen'.
			^self].
	
	theExistingTeam := TournamentPlannerApp collectionOfTeams data detect: [ :eachTeam |
		eachTeam teamName = self modalTextFieldTeamName value
	] ifNone: [nil].
	
	theExistingTeam
		ifNil: [
			self modalMultiComboBoxTeamMembers value size>0
			ifTrue: [
				self modalMultiComboBoxTeamMembers value do: [ :eachValue | 	
					theTeamMembers add: eachValue.
					theSingleTeamDiv addChild: (Me5Div new
					addChild: (Me5P new 
							text: eachValue;
							fontSize: 'large';
							yourself)).].
				self teamsRow addChild: (Me5Div new
					addChild: (Me5Portlet newPrimary
						title: (self modalTextFieldTeamName value);
						addChildToHeadTools: (Me5A newIconOnlyPrimary
								icon: Me5I newFasTrash;
								addClickEventSelector: #yesNoModalRemoveTeam: eventReceiver: self;
								yourself);
						addChildToBody: theSingleTeamDiv;
						yourself);
					padding: 15;
					addCssClassColSm12;
					addCssClassColMd6;
					addCssClassColXl4;
				yourself).
				
				theTeam := Team newWithTeamName: (self modalTextFieldTeamName value ) players: theTeamMembers.
				TournamentPlannerApp collectionOfTeams data add: theTeam.
					
				TournamentPlannerApp saveCollectionOfTeams: (TournamentPlannerApp collectionOfTeams data)
			]
			ifFalse: [
				self showErrorNotificationWithMessage: 'Team hat zu wenig Mitglieder']]
		ifNotNil: [
			self showErrorNotificationWithMessage: ('Das Team mit dem Namen %1 exisistiert bereits'
				bindWith: theExistingTeam teamName)]
	
	
]

{ #category : 'Initial-Events' }
TournamentPlannerView >> createComponents [

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

	super createModules.
	
	self addModuleByModuleClass: Me5ComboBoxModuleBundle.
	self addModuleByModuleClass: Me5DataGridModuleBundle.
	self addModuleByModuleClass: Bs4TooltipsterTooltipModuleBundle.
	self addModuleByModuleClass: Me5Select2SelectBoxModuleBundle.
]

{ #category : 'Internal' }
TournamentPlannerView >> dashboardTab [

 | theDashboard theTextNextGame theTextActualTournament theTextActualMatch theTextDateForNextMatch 
 theTextRunningTournaments theTextBestTeamNowInTheTournament theTextTeamMatchesInTheTournament 
 theTextBestPlayerNowInTheTournament theTextPlayerMatchesInTheTournament theTextForBets 
 theTextWithWageredMoney theTextForRunningBets theTextWithWageredMoneyForTheBets theTextWithOutcome |
 
 theTextNextGame := Me5H3 new text: 'N&auml;chstes Spiel f&uuml;r dich'.
 theTextActualTournament := Me5H5 new text: 'Turnier: Bestes Team'.
 theTextActualMatch := Me5H5 new text: 'Team Yeah VS Team Nope'.
 theTextDateForNextMatch := Me5H5 new text: 'In 3 Tagen um 15:30'.
 theTextRunningTournaments := Me5H3 new text: 'Laufende Turniere'.
 theTextBestTeamNowInTheTournament := Me5H5 new text: 'Turnier: Bestes Team'.
 theTextTeamMatchesInTheTournament := Me5H6 new text: '5 &Uuml;brige Spiele'.
 theTextBestPlayerNowInTheTournament := Me5H5 new text: 'Bester Spieler'.
 theTextPlayerMatchesInTheTournament := Me5H6 new text: '12 &Uuml;brige Spiele'.
 theTextForBets := Me5H3 new text: 'Wetten'.
 theTextWithWageredMoney := Me5H5 new text: '35&euro;'.
 theTextForRunningBets := Me5H5 new text: 'Laufende Wetten'.
 theTextWithWageredMoneyForTheBets := Me5H5 new text: '5&euro;'.
 theTextWithOutcome := Me5H6 new text: 'Team Yeah - 14.6.2022'.
 
theDashboard := Me5Div new.
theDashboard 
addChild:  (Me5H2 new
	text: 'HR-Works Turnierplaner';
	addChild: (Me5Portlet new
				addChildToBody: (Me5Div new
					addChild: (theTextNextGame);
					addChild: 
						(Me5Hr new);
					addChild: 
						(theTextActualTournament);
					addChild: 
						(theTextActualMatch);
					addChild: 
						(Me5Hr new);
					addChild: 
						(theTextDateForNextMatch);
						yourself);
					yourself);
				yourself);
	addChild: (Me5Portlet new
				addChildToBody: (Me5Div new
				addChild: 
				(theTextRunningTournaments);
				addChild: 
						(Me5Hr new);
				addChild: 
						(theTextBestTeamNowInTheTournament);
				addChild: 
						(theTextTeamMatchesInTheTournament);
				addChild: 
					(Me5ProgressBar newPrimary
										addCssClassMProgressLg;
										value: 50;
										yourself);
				addChild: 
						(Me5Hr new);									
				addChild: 
						(theTextBestPlayerNowInTheTournament);
				addChild: 
						(theTextPlayerMatchesInTheTournament);
				addChild: 
					(Me5ProgressBar newPrimary
										addCssClassMProgressLg;
										value: 50;
										yourself);
						yourself);
					yourself);
	addChild: (Me5Portlet new
				addChildToBody: (Me5Div new
				addChild: 
				(theTextForBets);
				addChild: 
						(Me5Hr new);
				addChild: 
						(theTextWithWageredMoney);
				addChild: 
						(Me5Hr new);									
				addChild: 
						(theTextForRunningBets);
				addChild: 
						(theTextWithWageredMoneyForTheBets);
				addChild: 
						(theTextWithOutcome);
						yourself);
					yourself);	
yourself.
			

^(Me5Div new
	addChild: (Me5H1 new 
		text: 'Dashboard';
		addCssClassTextCenter;
		yourself);
	addChild: Me5Hr new;
	addChild: theDashboard;
	yourself
	).
]

{ #category : 'Accessing' }
TournamentPlannerView >> modalMultiComboBoxTeamMembers [

	"<^iOf Object>"
	"Answer the modalMultiComboBoxRivals of the receiver"

	^modalMultiComboBoxTeamMembers
]

{ #category : 'Accessing' }
TournamentPlannerView >> modalMultiComboBoxTeamMembers: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the modalMultiComboBoxRivals of the receiver"

	modalMultiComboBoxTeamMembers := anObject
]

{ #category : 'Accessing' }
TournamentPlannerView >> modalTextFieldTeamName [

	"<^iOf Object>"
	"Answer the modalTextFieldTournamentName of the receiver"

	^modalTextFieldTeamName
]

{ #category : 'Accessing' }
TournamentPlannerView >> modalTextFieldTeamName: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the modalTextFieldTournamentName of the receiver"

	modalTextFieldTeamName := anObject
]

{ #category : 'Accessing' }
TournamentPlannerView >> multiComboBoxRivals [

	^multiComboBoxRivals
]

{ #category : 'Accessing' }
TournamentPlannerView >> multiComboBoxRivals: anObject [

	multiComboBoxRivals := anObject
]

{ #category : 'Accessing' }
TournamentPlannerView >> radioGroupGameMode [

	"<^iOf Object>"
	"Answer the createTournamentRadioGroupGameMode of the receiver"

	^radioGroupGameMode
]

{ #category : 'Accessing' }
TournamentPlannerView >> radioGroupGameMode: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the createTournamentRadioGroupGameMode of the receiver"

	radioGroupGameMode := anObject
]

{ #category : 'Accessing' }
TournamentPlannerView >> radioGroupTournamentType [

	"<^iOf Object>"
	"Answer the createTournamentRadioGroupTournamentType of the receiver"

	^radioGroupTournamentType
]

{ #category : 'Accessing' }
TournamentPlannerView >> radioGroupTournamentType: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the createTournamentRadioGroupTournamentType of the receiver"

	radioGroupTournamentType := anObject
]

{ #category : 'Events' }
TournamentPlannerView >> removeTeam: aMe5DialogEvent [

	| theDivTeam theTeam|
	theDivTeam := self removeTeamEvent component parent parent parent parent parent parent.
	theDivTeam parent removeChild: theDivTeam ifAbsent: [].
		
	theTeam := TournamentPlannerApp collectionOfTeams data detect: [ :eachTeam |
		eachTeam teamName = theDivTeam children first title.
	] ifNone: [].
	 TournamentPlannerApp collectionOfTeams data remove: theTeam ifAbsent: [].
	
	TournamentPlannerApp saveCollectionOfTeams: TournamentPlannerApp collectionOfTeams data.

	self showSuccessNotificationWithMessage: ('Team %1 gel&ouml;scht' bindWith: theTeam teamName)
]

{ #category : 'Accessing' }
TournamentPlannerView >> removeTeamEvent [

	"<^hOf Me5Event>"
	"Answer the removeTeamEvent of the receiver"

	^removeTeamEvent
]

{ #category : 'Accessing' }
TournamentPlannerView >> removeTeamEvent: aMe5Event [

	"<aMe5Event: hOf Me5Event, ^self>"
	"Set the removeTeamEvent of the receiver"

	removeTeamEvent := aMe5Event
]

{ #category : 'Accessing' }
TournamentPlannerView >> startUp [

	"<^iOf Object>"
	"Answer the startUp of the receiver"

	^startUp
]

{ #category : 'Accessing' }
TournamentPlannerView >> startUp: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the startUp of the receiver"

	startUp := anObject
]

{ #category : 'Internal' }
TournamentPlannerView >> tabsCollection [
	
	self tournamentTab: ManageTournamentsView new.
	
	^OrderedCollection new
		add: (Me5Tab new
			text: 'Dashboard';
			icon: Me5I newFasHome;
			addChildToTabPane: self dashboardTab;
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
			addChildToTabPane: self teamsTab;
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
TournamentPlannerView >> teamsRow [

	"<^iOf Me5Row>"
	"Answer the tournamentRow of the receiver"

	^teamsRow
]

{ #category : 'Accessing' }
TournamentPlannerView >> teamsRow: aRowOfTeams [

	"<aRowOfTeams: iOf Me5Row, ^self>"
	"Set the tournamentRow of the receiver"

	teamsRow := aRowOfTeams
]

{ #category : 'Internal' }
TournamentPlannerView >> teamsTab [

	"<^hOf Me5Div>"
	"Create the teamsTab where we can see and manage all teams"

	| theTeamMemberDiv theResultDiv theTeamList theCollectionOfTeamMemberCollections thePersons textFieldTeamName multiComboBoxTeamMembers |

	thePersons := OrderedCollection new.
	TournamentPlannerApp collectionOfPlayers data do: [ :eachPerson |
		thePersons add: ('%1 %2' bindWith: eachPerson firstName with: eachPerson lastName)].
	theTeamList := OrderedCollection new.
	theCollectionOfTeamMemberCollections := OrderedCollection new.
	TournamentPlannerApp collectionOfTeams data do: [ :eachTeam |
		| eachPlayerList |
		theTeamList add: eachTeam teamName.
		eachPlayerList := OrderedCollection new.
		eachTeam members do: [ :eachPlayer |
			eachPlayerList add: eachPlayer].
		theCollectionOfTeamMemberCollections add: eachPlayerList].
	teamsRow := Me5Row new.
	TournamentPlannerApp collectionOfTeams data do: [ :eachTeam | 
		theTeamMemberDiv := Me5Div new.
		eachTeam members do: [ :eachPlayer |
			theTeamMemberDiv addChild: (Me5Div new
			addChild: (Me5P new
			text: eachPlayer asString;
			fontSize: 'large';
			yourself))].

		teamsRow addChild: (Me5Div new
			padding: 15;
			addCssClassColSm12;
			addCssClassColMd6;
			addCssClassColXl4;
			addChild: (Me5Portlet newPrimary
				title: (eachTeam teamName);
				addChildToHeadTools: (Me5A newIconOnlyPrimary
					icon: Me5I newFasTrash;
					addClickEventSelector: #yesNoModalRemoveTeam: eventReceiver: self;
					yourself);
				addChildToBody: theTeamMemberDiv;
				yourself);
			yourself)].
	theResultDiv := Me5Div new 
		addChild: (Me5H1 new 
			text: 'Teams';
			addCssClassTextCenter;
			yourself);
		addChild: Me5Hr new;
		addChild: (Me5Accordion new
			addChild: (Me5AccordionItem new
				icon: Me5I newFasEdit;
				title: 'Team erstellen';
				addChildToContent: (Me5Form new
					addChildToBody: (textFieldTeamName := Me5TextField new
						text: 'Neues Team';
						placeholder: 'Teamname';
						yourself);
					addChildToBody: (multiComboBoxTeamMembers := Me5Select2MultiSelectBox new
						text: 'Teammitglieder';
						objects: thePersons;
						placeholder: 'Personen';
						yourself);
					addChildToActions: (Me5Button newSuccess
						text: 'Speichern';
						icon: Me5I newFasSave;
						addClickEventSelector: #buttonNewTeam;
						yourself);
					yourself);
				yourself);
			yourself);
		addChild: teamsRow;
		yourself.

		self modalTextFieldTeamName: textFieldTeamName.
		self modalMultiComboBoxTeamMembers: multiComboBoxTeamMembers.

	^theResultDiv
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentRow [

	"<^iOf Object>"
	"Answer the tournamentRow of the receiver"

	^tournamentRow
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentRow: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the tournamentRow of the receiver"

	tournamentRow := anObject
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentTab [

	^tournamentTab
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentTab: anObject [

	tournamentTab := anObject
]

{ #category : 'Accessing' }
TournamentPlannerView >> user [

	"<^iOf Object>"
	"Answer the user of the receiver"

	^user
]

{ #category : 'Accessing' }
TournamentPlannerView >> user: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the user of the receiver"

	user := anObject
]

{ #category : 'Internal' }
TournamentPlannerView >> userSettingsTab [

	"<^hOf Me5Div>"
	"Sends the userSettings Tab to the receiver"

	| thePlayer |

	(self user isNil)
		ifTrue: [
			thePlayer := Player newWithFirstName: 'Max' lastName: 'Muster'  email: 'max.muster@gmail.com'.
			self user:thePlayer].

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
					yourself);
				addChildToRow: (Me5Button newPrimary
					text: 'Speichern';
					icon: Me5I newFasSave;
					yourself);
				yourself);
			yourself
]

{ #category : 'Events' }
TournamentPlannerView >> yesNoModalRemoveTeam: aMe5Event [

	self removeTeamEvent: aMe5Event.
	self showYesNoDialogWithTitle: 'Team l&ouml;schen?' message: '' yesSelector: #removeTeam:
]
