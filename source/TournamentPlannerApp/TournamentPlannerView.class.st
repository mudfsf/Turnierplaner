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
		'modalMultiComboBoxTeamMembers'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Not categorized' }
TournamentPlannerView >> adminToolsTab [

^(Me5A newButtonIconOnly
						setTargetBlank;
						text: 'Gehe zu ManagePlayerView';
						href: ('TurnierplanerView/managePlayer');
						yourself).
]

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

	| theSingleTeamDiv |
	
	theSingleTeamDiv := Me5Div new.
			1 to: (self modalMultiComboBoxTeamMembers value size) do: [:index | 	
				theSingleTeamDiv addChild: (Me5Div new
				addChild: (Me5P new 
						text: (self modalMultiComboBoxTeamMembers value at: index);
						fontSize: 'large';
						yourself)).
			].
			self teamsRow addChild: (Me5Div new
				addChild: (Me5Portlet newPrimary
					title: (self modalTextFieldTeamName value);
					addChildToBody: theSingleTeamDiv;
					addChildToFoot: (Me5Button newDanger
						text: 'L&ouml;schen';
						icon: Me5Flaticon newDelete1;
						"addClickEventSelector: #buttonDeleteTeam;"
						yourself);
					yourself);
				padding: 15;
				addCssClassColSm12;
				addCssClassColMd6;
				addCssClassColXl4;
			yourself).
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

	self 
		addChild: (Me5H1 new
			text: 'Turnierplaner';
			yourself
		);
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
	addChild: (Me5H1 new text: 'Dashboard');
	addChild: Me5Hr new;
	addChild: theDashboard;
	addChild: Me5Hr new;
	addChild: (Me5H4 new text: 'Shortcuts zu den Seiten');
	addChild: self adminToolsTab;
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

{ #category : 'Not categorized' }
TournamentPlannerView >> removeTournament [

	self tournamentTab removeTournament.
]

{ #category : 'Not categorized' }
TournamentPlannerView >> resetTournamentTabWithPlayers: aCollectionOfPlayers [

	self tournamentTab resetPlayers: aCollectionOfPlayers

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
	
	theUserSettings := UserSettingsView new.

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

	| theSingleTeamDiv theResultDiv theTeamList thePlayerLists thePersonen textFieldTeamName multiComboBoxTeamMembers |
		
		thePersonen := OrderedCollection new.
		1 to: collectionOfPlayers size do: [:eachIndex |
			| eachPlayer |
			eachPlayer := collectionOfPlayers at: eachIndex.
			thePersonen add: eachPlayer firstName, ' ', eachPlayer lastName.
		].
		
		theTeamList := OrderedCollection new.
		1 to: collectionOfTeams size do: [:eachIndex |
			| eachTeam |
			eachTeam := collectionOfTeams at: eachIndex.
			theTeamList add: eachTeam teamName.
		].
		
		thePlayerLists := OrderedCollection new.
		1 to: collectionOfTeams size do: [:eachIndex |
			| eachTeamPlayers eachPlayerList |
			eachTeamPlayers := (collectionOfTeams at: eachIndex) players.
			eachPlayerList := OrderedCollection new.
			1 to: eachTeamPlayers size do: [:innerIndex |
				eachPlayerList add: (eachTeamPlayers at: innerIndex).
			].
			thePlayerLists add: eachPlayerList.
		].

		teamsRow := ((Me5Div new) addChild: Me5Row new).
		1 to: (theTeamList size) do: [:index | 
			theSingleTeamDiv := Me5Div new.
			1 to: ((thePlayerLists at: index) size) do: [:innerIndex | 	
				theSingleTeamDiv addChild: (Me5Div new
				addChild: (Me5P new 
						text: ((thePlayerLists at: index) at: innerIndex);
						fontSize: 'large';
						yourself)).
			].
			teamsRow addChild: (Me5Div new
				addChild: (Me5Portlet newPrimary
					title: (theTeamList at: index);
					addChildToBody: theSingleTeamDiv;
					addChildToFoot: (Me5Button newDanger
						text: 'L&ouml;schen';
						icon: Me5Flaticon newDelete1;
						"addClickEventSelector: #buttonDeleteTeam;"
						yourself);
					yourself);
				padding: 15;
				addCssClassColSm12;
				addCssClassColMd6;
				addCssClassColXl4;
			yourself).
		].
		theResultDiv := Me5Div new.
		theResultDiv addChild: teamsRow;
			addChild: (Me5Div new
				addChild: (Me5Portlet newSuccess
					title: 'Neues Team erstellen';
					addChildToFoot: (Me5Form new
						addChildToBody: (textFieldTeamName := Me5TextField new
							text: 'Neues Team';
							"value: teamName;"
							placeholder: 'Teamname';
							addCssClassCol12;
							addCssClassColLg6;
						yourself);
						addChildToBody: (multiComboBoxTeamMembers := Me5MultiComboBox new
							text: 'Teammitglieder';
							helpText: 'Im Team:';
							objects: thePersonen;
							placeholder: 'Personen';
							yourself);
						addChildToBody: (Me5Button newSuccess
							text: 'Speichern';
							icon: Me5I newFasSave;
							addClickEventSelector: #buttonNewTeam;
							yourself);
					yourself));
				padding: 15;
				addCssClassColSm12;
				addCssClassColMd6;
				addCssClassColXl4;
			yourself).
			
		self modalTextFieldTeamName: textFieldTeamName.
		self modalMultiComboBoxTeamMembers: multiComboBoxTeamMembers.

	^theResultDiv.

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

	| thePlayer |
	"User muss noch ermittelt werden"
	(self user isNil)
		ifTrue: [
			thePlayer:=Player newWithFirstName: 'Max' lastName: 'Muster'  email: 'max.muster@gmail.com'.
			self user:thePlayer.] .



	^(Me5Div new
		addChild:	(Me5H1 new text: 'Einstellungen');
		addChild: Me5Hr new;
		addChild: (Me5FormPortlet newPrimary
			title:'Einstellungen';
		
				addChildToBody: (Me5Row  new
					addChild: (Me5TextField new
						text:'Vorname';
						value: user firstName;
						placeholder:'Vorname';
						addCssClassCol12;
						addCssClassColLg6;
					yourself);
					addChild: (Me5TextField new
						text:'Nachname';
						value: user lastName;
						placeholder: 'Nachname';
						addCssClassColLg6;
						addCssClassCol12;
					yourself);	
					addChild: (Me5TextField new
						text:'E-Mail';
						value: user email;
						placeholder: 'E-Mail';
						addCssClassColLg6;
						addCssClassCol12;
					yourself);	
				yourself);
				addChildToBody: (Me5Row new
					addChild: (Me5PasswordField new
							text:'Passwort';
							placeholder: 'Passwort';
							addCssClassColLg6;
							addCssClassCol12;
						yourself);	
					yourself);
			
				
				addChildToFoot: (Me5Button newPrimary
					text:'Speichern';
					icon: Me5I newFasSave;
					"addClickEventSelector: #savePlayer;"
					yourself);
				yourself);
			yourself).
]
