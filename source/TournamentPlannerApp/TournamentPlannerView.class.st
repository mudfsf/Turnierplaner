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
	
	"<^self>"
	"creates new Team"
	
	| theSingleTeamDiv theTeamMembers theTeam theExistingTeam|
	
	theTeamMembers := OrderedCollection new.
	theSingleTeamDiv := Me5Div new.
	self modalTextFieldTeamName value = ''
		ifTrue: [
			self showErrorNotificationWithMessage: 'Team hat keinen Namen'.
			^self].
	theExistingTeam := TournamentPlannerApp collectionOfTeams data detect: [ :eachTeam |
		eachTeam teamName = self modalTextFieldTeamName value] ifNone: [nil].
	theExistingTeam
		ifNil: [
			self modalMultiComboBoxTeamMembers value size>0
				ifTrue: [
					self modalMultiComboBoxTeamMembers value do: [ :eachValue | 	
						theTeamMembers add: eachValue.
						theSingleTeamDiv addChild: (Me5P new 
							text: eachValue;
							fontSize: 'large';
							yourself)].
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
					TournamentPlannerApp saveCollectionOfTeams: (TournamentPlannerApp collectionOfTeams data)]
				ifFalse: [self showErrorNotificationWithMessage: 'Team hat zu wenig Mitglieder']]
		ifNotNil: [self showErrorNotificationWithMessage: ('Das Team mit dem Namen %1 exisistiert bereits'
			bindWith: theExistingTeam teamName)]
]

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

{ #category : 'Internal' }
TournamentPlannerView >> dashboardTab [

	| theDashboard theTextNextGame theTextActualTournament theTextActualMatch 
	theTextRunningTournaments theTextBestTeamNowInTheTournament theTextTeamMatchesInTheTournament 
	theTextBestPlayerNowInTheTournament theTextPlayerMatchesInTheTournament theTextForBets 
	theTextWithWageredMoney theTextForRunningBets theTextWithWageredMoneyForTheBets theNeededTournament theNeededPlayer theListofGamesfromNeededPlayer theListofGamesfromNeededPlayerPlayed |

	theNeededTournament := TournamentPlannerApp collectionOfTournaments data last.	"ToDo: find not completed Tournaments."
	theNeededPlayer := theNeededTournament membercollection last.	"ToDo: load logged User. Temporaly not availabe."
	theTextNextGame := Me5H3 new text: 'N&auml;chstes Spiel f&uuml;r dich'.
	theTextActualTournament := Me5H5 new text: ('Turnier: %1' bindWith: theNeededTournament name).
	theTextActualMatch := Me5H5 new text: ('Spiel: %1' bindWith: theNeededTournament games last name).
	theTextRunningTournaments := Me5H3 new text: 'Laufende Turniere'.
	theTextBestTeamNowInTheTournament := Me5H5 new text: ('Turnier: %1' bindWith: theNeededTournament name).
	theTextTeamMatchesInTheTournament := Me5H6 new text: ('%1 &uuml;brige Spiele' bindWith: (theNeededTournament games size - theNeededTournament playedGames size) ).
	theTextBestPlayerNowInTheTournament := Me5H5 new text: ('Spieler: %1' bindWith: theNeededPlayer asString).
	theListofGamesfromNeededPlayer := theNeededTournament games select: [ :eachGame | 
		(eachGame memberCollection first asString = theNeededPlayer asString ) or: [ eachGame memberCollection last asString = theNeededPlayer asString ] ].
	theListofGamesfromNeededPlayerPlayed := theNeededTournament playedGames select: [ :eachGame | 
		(eachGame memberCollection first asString = theNeededPlayer asString ) or: [ eachGame memberCollection last asString = theNeededPlayer asString ] ].

	theTextPlayerMatchesInTheTournament := Me5H6 new text: ('%1 &uuml;brige Spiele' bindWith: theListofGamesfromNeededPlayer size - theListofGamesfromNeededPlayerPlayed size ) .
	theTextForBets := Me5H3 new text: 'Wetten'.		"ToDo: implement Bets."
	theTextWithWageredMoney := Me5H5 new text: '35&euro;'.
	theTextForRunningBets := Me5H5 new text: 'Laufende Wetten'.
	theTextWithWageredMoneyForTheBets := Me5H5 new text: '5&euro;'.

	
	theDashboard := (Me5Div new
		addChild: (Me5H2 newWithText: 'HR-Works Turnierplaner');
		addChild: (Me5Portlet new
			addChildToBody: theTextNextGame;
			addChildToBody: Me5Hr new;
			addChildToBody: theTextActualTournament;
			addChildToBody: theTextActualMatch;
			yourself);		
		addChild: (Me5Portlet new
			addChildToBody: theTextRunningTournaments;
			addChildToBody: Me5Hr new;
			addChildToBody: theTextBestTeamNowInTheTournament;
			addChildToBody: theTextTeamMatchesInTheTournament;
			addChildToBody: (Me5ProgressBar newPrimary
				addCssClassMProgressLg;
				value: 100 * theNeededTournament playedGames size / theNeededTournament games size;
				yourself);
			addChildToBody: Me5Hr new;									
			addChildToBody: theTextBestPlayerNowInTheTournament;
			addChildToBody: theTextPlayerMatchesInTheTournament;
			addChildToBody: (Me5ProgressBar newPrimary
				addCssClassMProgressLg;
				value: 100 * theListofGamesfromNeededPlayerPlayed size / theListofGamesfromNeededPlayer size;
				yourself);
			yourself);
		addChild: (Me5Portlet new
			addChildToBody: theTextForBets;
			addChildToBody: Me5Hr new;
			addChildToBody: theTextWithWageredMoney;
			addChildToBody: Me5Hr new;									
			addChildToBody: theTextForRunningBets;
			addChildToBody: theTextWithWageredMoneyForTheBets;
			yourself);
		yourself).
	
	^Me5Div new
		addChild: (Me5H1 new 
			text: 'Dashboard';
			addCssClassTextCenter;
			yourself);
		addChild: Me5Hr new;
		addChild: theDashboard;
		yourself
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

	"<^hOf Me5TextField>"
	"Answer the modalTextFieldTournamentName of the receiver"

	^modalTextFieldTeamName
]

{ #category : 'Accessing' }
TournamentPlannerView >> modalTextFieldTeamName: aTextfield [

	"<aTextfield: hOf Me5TextField, ^self>"
	"Set the modalTextFieldTournamentName of the receiver"

	modalTextFieldTeamName := aTextfield
]

{ #category : 'Accessing' }
TournamentPlannerView >> radioGroupGameMode [

	"<^hOf Me5RadioGroup>"
	"Answer the createTournamentRadioGroupGameMode of the receiver"

	^radioGroupGameMode
]

{ #category : 'Accessing' }
TournamentPlannerView >> radioGroupGameMode: aRadioGroup [

	"<aRadioGroup: hOf Me5RadioGroup, ^self>"
	"Set the createTournamentRadioGroupGameMode of the receiver"

	radioGroupGameMode := aRadioGroup
]

{ #category : 'Events' }
TournamentPlannerView >> removeTeam: aMe5DialogEvent [

	"<^self>"
	"removes Team"

	| theDivTeam theTeam |
	
	theDivTeam := aMe5DialogEvent originalEvent component parent parent parent parent parent parent.
	theDivTeam parent removeChild: theDivTeam ifAbsent: [].	
	theTeam := TournamentPlannerApp collectionOfTeams data detect: [ :eachTeam |
		eachTeam teamName = theDivTeam children first title] ifNone: [].
	TournamentPlannerApp collectionOfTeams data remove: theTeam ifAbsent: [].
	TournamentPlannerApp saveCollectionOfTeams: TournamentPlannerApp collectionOfTeams data.
	self showSuccessNotificationWithMessage: ('Team %1 gel&ouml;scht' bindWith: theTeam asString)
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

	"<^hOf Me5Row>"
	"Answer the tournamentRow of the receiver"

	^teamsRow
]

{ #category : 'Accessing' }
TournamentPlannerView >> teamsRow: aRowOfTeams [

	"<aRowOfTeams: hOf Me5Row, ^self>"
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
	self teamsRow: Me5Row new.
	TournamentPlannerApp collectionOfTeams data do: [ :eachTeam | 
		theTeamMemberDiv := Me5Div new.
		eachTeam members do: [ :eachPlayer |
			theTeamMemberDiv addChild: (Me5Div new
			addChild: (Me5P new
			text: eachPlayer asString;
			fontSize: 'large';
			yourself))].
		self teamsRow addChild: (Me5Div new
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

	"<^hOf Me5Row>"
	"Answer the tournamentRow of the receiver"

	^tournamentRow
]

{ #category : 'Accessing' }
TournamentPlannerView >> tournamentRow: aTournamentRow [

	"<aTournamentRow: hOf Me5Row, ^self>"
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

	"<^self>"

	self showYesNoDialogWithTitle: 'Team l&ouml;schen?' message: '' yesSelector: #removeTeam:
]
