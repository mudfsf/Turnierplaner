Class {
	#name : 'TournamentPlannerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'tournamentTab',
		'multiComboBoxRivals',
		'startUp',
		'user',
		'collectionOfPlayers',
		'collectionOfTournaments',
		'collectionOfTeams',
		'tournamentRow',
		'createTournamentRadioGroupGameMode',
		'createTournamentRadioGroupTournamentType',
		'createTournamentMultiComboBoxRivals',
		'createTournamentTextFieldTournamentName',
		'collapsiblePortlet',
		'teamsRow',
		'modalTextFieldTeamName',
		'modalMultiComboBoxTeamMembers',
		'removeTeamEvent'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initials' }
TournamentPlannerView >> beforeCreateComponents [

	self startUp: Memory new.	

	"theBlob := OrderedCollection new.
		
	theMemory saveObject: theBlob onPath: 'C:\TournamentPlanner\Memory\tournaments.dat'.

		theBlob add: (Player new
		firstName: 'TestAdmin';
		lastName:  '';
		email: 'TestAdmin@Test.com';
		yourself).
		
	theMemory saveObject: theBlob onPath: 'C:\TournamentPlanner\Memory\players.dat'."
	
	"self collectionOfTournaments: (self startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\tournaments.dat').
	self collectionOfPlayers:  (self startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\players.dat').
	self collectionOfTeams:  (self startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\teams.dat')."

	

]

{ #category : 'Not categorized' }
TournamentPlannerView >> buttonNewTeam [

	| theSingleTeamDiv theTeamMembers theTeam|
	
	theTeamMembers := OrderedCollection new.
	theSingleTeamDiv := Me5Div new.
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
			addChildToBody: theSingleTeamDiv;
			addChildToFoot: (Me5Button newDanger
				text: 'L&ouml;schen';
				icon: Me5Flaticon newDelete1;
				addClickEventSelector: #yesNoModalRemoveTeam: eventReceiver: self;
				yourself);
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

{ #category : 'Accessing' }
TournamentPlannerView >> collectionOfPlayers [

	^collectionOfPlayers
]

{ #category : 'Accessing' }
TournamentPlannerView >> collectionOfPlayers: aCollectionOfPlayer [

	collectionOfPlayers := aCollectionOfPlayer
]

{ #category : 'Accessing' }
TournamentPlannerView >> collectionOfTeams [

	"<^hOf Collection of: {iOf Object}>"
	"Answer the collectionOfTeams of the receiver"

	^collectionOfTeams
]

{ #category : 'Accessing' }
TournamentPlannerView >> collectionOfTeams: aCollectionOfTeams [

	"<aCollection: hOf Collection of: {iOf Object}, ^self>"
	"Set the collectionOfTeams of the receiver"

	collectionOfTeams := aCollectionOfTeams
]

{ #category : 'Accessing' }
TournamentPlannerView >> collectionOfTournaments [

	^collectionOfTournaments
]

{ #category : 'Accessing' }
TournamentPlannerView >> collectionOfTournaments: aCollectionOfTournament [

	collectionOfTournaments := aCollectionOfTournament
]

{ #category : 'Initials' }
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

{ #category : 'Initials' }
TournamentPlannerView >> createModules [

	super createModules.
	
	self addModuleByModuleClass: Me5ComboBoxModuleBundle.
	self addModuleByModuleClass: Me5DataGridModuleBundle.
	self addModuleByModuleClass: Bs4TooltipsterTooltipModuleBundle.
	self addModuleByModuleClass: Me5Select2SelectBoxModuleBundle.
]

{ #category : 'Accessing' }
TournamentPlannerView >> createTournamentMultiComboBoxRivals [

	"<^iOf Object>"
	"Answer the createTournamentMultiComboBoxRivals of the receiver"

	^createTournamentMultiComboBoxRivals
]

{ #category : 'Accessing' }
TournamentPlannerView >> createTournamentMultiComboBoxRivals: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the createTournamentMultiComboBoxRivals of the receiver"

	createTournamentMultiComboBoxRivals := anObject
]

{ #category : 'Accessing' }
TournamentPlannerView >> createTournamentRadioGroupGameMode [

	"<^iOf Object>"
	"Answer the createTournamentRadioGroupGameMode of the receiver"

	^createTournamentRadioGroupGameMode
]

{ #category : 'Accessing' }
TournamentPlannerView >> createTournamentRadioGroupGameMode: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the createTournamentRadioGroupGameMode of the receiver"

	createTournamentRadioGroupGameMode := anObject
]

{ #category : 'Accessing' }
TournamentPlannerView >> createTournamentRadioGroupTournamentType [

	"<^iOf Object>"
	"Answer the createTournamentRadioGroupTournamentType of the receiver"

	^createTournamentRadioGroupTournamentType
]

{ #category : 'Accessing' }
TournamentPlannerView >> createTournamentRadioGroupTournamentType: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the createTournamentRadioGroupTournamentType of the receiver"

	createTournamentRadioGroupTournamentType := anObject
]

{ #category : 'Accessing' }
TournamentPlannerView >> createTournamentTextFieldTournamentName [

	"<^iOf Object>"
	"Answer the createTournamentTextFieldTournamentName of the receiver"

	^createTournamentTextFieldTournamentName
]

{ #category : 'Accessing' }
TournamentPlannerView >> createTournamentTextFieldTournamentName: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the createTournamentTextFieldTournamentName of the receiver"

	createTournamentTextFieldTournamentName := anObject
]

{ #category : 'Not categorized' }
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

{ #category : 'Not categorized' }
TournamentPlannerView >> modalMultiComboBoxTeamMembers [

	"<^iOf Object>"
	"Answer the modalMultiComboBoxRivals of the receiver"

	^modalMultiComboBoxTeamMembers
]

{ #category : 'Not categorized' }
TournamentPlannerView >> modalMultiComboBoxTeamMembers: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the modalMultiComboBoxRivals of the receiver"

	modalMultiComboBoxTeamMembers := anObject
]

{ #category : 'Not categorized' }
TournamentPlannerView >> modalTextFieldTeamName [

	"<^iOf Object>"
	"Answer the modalTextFieldTournamentName of the receiver"

	^modalTextFieldTeamName
]

{ #category : 'Not categorized' }
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

{ #category : 'Not categorized' }
TournamentPlannerView >> removeAllTournaments [

	self collectionOfTournaments removeAll.
	
	self startUp saveObject: self collectionOfTournaments onPath: 'C:\TournamentPlanner\Memory\tournaments.dat'.
]

{ #category : 'Events' }
TournamentPlannerView >> removeTeam: aMe5DialogEvent [

	| theDivTeam theTeam|
	theDivTeam := self removeTeamEvent component parent parent parent.
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

{ #category : 'Not categorized' }
TournamentPlannerView >> removeTournament [

	self tournamentTab removeTournament.
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

{ #category : 'Not categorized' }
TournamentPlannerView >> tabsCollection [

	| theUserSettings theCreateTournamentModal |
	
	self tournamentTab: ManageTournamentsView new.

	"theCreateTournamentModal := (CreateTournamentModal  new
	yourself).
	theCreateTournamentModal createView."
	
	^OrderedCollection new
		add: (Me5Tab new
			text: 'Dashboard';
			icon: Me5I newFasHome;
			addChildToTabPane: self dashboardTab;
			activateTab; "Make sure that 'activateTab' is called after you added a child to tabPane."
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
			addChildToTabPane: self userSettingsTab "theCreateTournamentModal view";
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

{ #category : 'Not categorized' }
TournamentPlannerView >> teamsRow [

	"<^iOf Object>"
	"Answer the tournamentRow of the receiver"

	^teamsRow
]

{ #category : 'Not categorized' }
TournamentPlannerView >> teamsRow: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the tournamentRow of the receiver"

	teamsRow := anObject
]

{ #category : 'Not categorized' }
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
						addChildToBody: theTeamMemberDiv;
						addChildToFoot: (Me5Button newDanger
							text: 'L&ouml;schen';
							icon: Me5Flaticon newDelete1;
							addClickEventSelector: #yesNoModalRemoveTeam: eventReceiver: self;
							yourself);
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
		addChild: (Me5Div new
			padding: 15;
			addCssClassColSm12;
			addCssClassColMd6;
			addCssClassColXl4;
				yourself);
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

{ #category : 'Not categorized' }
TournamentPlannerView >> userSettingsTab [

	"<^hOf Me5Div>"
	"Sends the userSettings Tab to the receiver"

	| thePlayer |

	(self user isNil)
		ifTrue: [
			thePlayer:=Player newWithFirstName: 'Max' lastName: 'Muster'  email: 'max.muster@gmail.com'.
			self user:thePlayer] .

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
				addChildToRow:  (Me5Button newPrimary
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
