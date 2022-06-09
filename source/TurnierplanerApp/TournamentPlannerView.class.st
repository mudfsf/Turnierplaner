Class {
	#name : 'TournamentPlannerView',
	#superclass : 'Me5BaseView',
	#instVars : [
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
		'collapsiblePortlet'
	],
	#category : 'TurnierplanerApp'
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

	self startUp: StartUp new.	

	"theBlob := OrderedCollection new.
		
	theMemory saveObject: theBlob onPath: 'C:\TournamentPlanner\Memory\tournaments.dat'.

		theBlob add: (Player new
		firstName: 'TestAdmin';
		lastName:  '';
		email: 'TestAdmin@Test.com';
		yourself).
		
	theMemory saveObject: theBlob onPath: 'C:\TournamentPlanner\Memory\players.dat'."
	
	self collectionOfTournaments: (self startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\tournaments.dat').
	self collectionOfPlayers:  (self startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\players.dat').
	self collectionOfTeams:  (self startUp loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\teams.dat').

	

]

{ #category : 'Not categorized' }
TournamentPlannerView >> buttonNewTournament [

	| rivalsString currentTournament |
	rivalsString := ''.
	
	1 to: (self createTournamentMultiComboBoxRivals value size) do: [:index |
		rivalsString := rivalsString,  (((self createTournamentMultiComboBoxRivals value) at: index) asString), '     '.
	].
	
	currentTournament := (Tournament new
		name: self createTournamentTextFieldTournamentName value;
		tournamentType: self createTournamentRadioGroupTournamentType value;
		gameMode: self createTournamentRadioGroupGameMode value;
		numberOfGames: (self createTournamentMultiComboBoxRivals value size);
		numberOfPlayedGames: 2;
		yourself).
	
	
	self tournamentRow addChild: (Me5Div new
			addChild: (Me5Portlet newPrimary
				addChildToHeadTools: (Me5A newPortletNavLinkIcon
					icon: Me5I newFasTrash;
					"addClickEventSelector: #removeTournament:;"
					yourself);
				title: currentTournament name;
				addChildToBody: (Me5P new
					text: ((currentTournament tournamentType) asString, ' / ', (currentTournament gameMode) asString );
					fontSize: 'medium';
					yourself);
				addChildToBody: (Me5P new 
					text: ('Rivalen: ', '-' );
					fontSize: 'large';
					yourself);
				addChildToBody: (Me5A newPrimary
					setTargetBlank;
					"showForMdAndBiggerDevices;"
					rightIcon: Me5I newFasAngleRight;
					text: 'Zum Turnier';
					href: ('TurnierplanerView/specificTournament?tournamentName=dasErsteTurnier %1&team=true' bindWith: (currentTournament name));
					yourself);
				addChildToFoot:  (Me5ProgressBar newPrimary
					value: ((currentTournament numberOfPlayedGames asInteger) / (currentTournament numberOfGames asInteger) * 100) asInteger;
					height: 20;
					setPrimaryStyle;
					yourself);
				addChildToFoot: (Me5P new
					text: (currentTournament numberOfPlayedGames asString), ' von ', (currentTournament numberOfGames asString);
					textAlign: 'center';
					fontSize: 'larger';
					yourself);
				setTargetBlank;

				yourself);
				
				padding: 15;
				addCssClassColSm12;
				addCssClassColMd6;
				addCssClassColXl4;
			yourself).
				
				
		self collectionOfTournaments add: currentTournament.
		
		self startUp saveObject: (self collectionOfTournaments) onPath:  'C:\TournamentPlanner\Memory\tournaments.dat'.
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
 theTextWithWageredMoney theTextForRunningBets theTextWithWageredMoneyForTheBets theTextWithOutcome|
 
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
TournamentPlannerView >> removeAllTournaments [

	self collectionOfTournaments removeAll.
	
	self startUp saveObject: self collectionOfTournaments onPath: 'C:\TournamentPlanner\Memory\tournaments.dat'.
]

{ #category : 'Not categorized' }
TournamentPlannerView >> removeTournament: aMe5Event [

	aMe5Event formGroup removeComponent.
]

{ #category : 'Not categorized' }
TournamentPlannerView >> removeTournament: symbol tournamentIndex: index [

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

	| theUserSettings theManagedPlayerView theCreateTournamentModal |
	
	"theCreateTournamentModal := (CreateTournamentModal  new
	yourself).
	theCreateTournamentModal createView."
	
	theManagedPlayerView := (ManagePlayers new
	data: self collectionOfPlayers;
	parent: self;
	yourself).	
	theManagedPlayerView createView.
	theUserSettings := UserSettings new.

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
			addChildToTabPane: self tournamentTab;
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
			addChildToTabPane: theManagedPlayerView view"self adminToolsTab";
			yourself);
		yourself

]

{ #category : 'Not categorized' }
TournamentPlannerView >> teamsTab [

	| theCurrentPlayerNameDiv theResultDiv theRow theTeamList thePlayerLists thePersonen |
		
		theTeamList := #('Team Ameise' 'Team Baum' 'Team Cello' 'Team Durian').
		thePlayerLists := #(
			#('Anika' 'Arnold' 'Ali' 'Andreas')
			#('Bernd' 'Bianca' 'Bob' 'Bettina')
			#('Cevin' 'Cynthia' 'Cem' 'Charles')
			#('Dorotea' 'Daniel' 'Dalia' 'Debora')
		).
		thePersonen := #('Anika' 'Arnold' 'Ali' 'Andreas' 'Bernd' 'Bianca' 'Bob' 'Bettina' 'Cevin' 'Cynthia' 'Cem' 'Charles' 'Dorotea' 'Daniel' 'Dalia' 'Debora').

		theRow := Me5Row new.
		1 to: (theTeamList size) do: [:index | 
			theCurrentPlayerNameDiv := Me5Div new.
			1 to: ((thePlayerLists at: index) size) do: [:innerIndex | 	
				theCurrentPlayerNameDiv addChild: (Me5Div new
				addChild: (Me5P new 
						text: ((thePlayerLists at: index) at: innerIndex);
						fontSize: 'large';
						yourself)).
			].
			theRow addChild: (Me5Div new
				addChild: (Me5Portlet newPrimary
					title: (theTeamList at: index);
					addChildToBody: theCurrentPlayerNameDiv;
					addChildToFoot: (Me5Button newDanger
						text: 'L&ouml;schen';
						icon: Me5Flaticon newDelete1;
						"addClickEventSelector: #deleteTeam;"
						yourself);
					yourself);
				padding: 15;
				addCssClassColSm12;
				addCssClassColMd6;
				addCssClassColXl4;
			yourself).
		].
		theRow addChild: (Me5Div new
				addChild: (Me5FormPortlet newSuccess
					title: 'Neues Team erstellen';
					addChildToBody: (Me5TextField new
						text: 'Teamname:';
						"value: teamName;"
						placeholder: 'Teamname';
						addCssClassCol12;
						addCssClassColLg6;
					yourself);
					addChildToBody: (Me5MultiComboBox new
						text: 'Teammitglieder';
						helpText: 'Im Team:';
						objects: thePersonen;
						placeholder: 'Personen';
						yourself);
					addChildToFoot: (Me5Button newSuccess
						text: 'Speichern';
						icon: Me5I newFasSave;
						"addClickEventSelector: #saveTeam;"
						yourself);
					yourself);
				padding: 15;
				addCssClassColSm12;
				addCssClassColMd6;
				addCssClassColXl4;
			yourself).


	theResultDiv := (Me5Div new).
	theResultDiv addChild: (Me5H1 new text: 'Teams').
	theResultDiv addChild: Me5Hr new.
	theResultDiv addChild: theRow.


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

{ #category : 'Not categorized' }
TournamentPlannerView >> tournamentTab [

	| theResultDiv theRow textFieldTournamentName radioGroupTournamentType radioGroupGameMode multiComboBoxRivals createTournamentDiv collapsibleAccordion |

		"theTournamentList := #('Tournament 1' 'Tournament 2' 'Tournament 3' 'Tournament 4')."
			
		createTournamentDiv := (Me5Div new
			addChild: (Me5Form new
				addChildToBody: (textFieldTournamentName := Me5TextField new
					text: 'Tournier Name';
					yourself);
				addChildToBody: (radioGroupTournamentType := Me5RadioGroup new
					text: 'Turnierart';
					addObjects: #('KO' 'Runden' 'Mixed');
					yourself);
				addChildToBody: (radioGroupGameMode := Me5RadioGroup new
					text: 'Spielmodus';
					addObjects: #('Einzel' 'Team');
					yourself);
				addChildToBody: (multiComboBoxRivals := Me5Select2MultiSelectBox new
					text: 'Rivalen (muss noch dynamisch werden dass teams oder spieler angezeigt werden k&ouml;nnen)';
					addObjects: #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20);
					yourself);
				addChildToBody: (Me5Button newPrimary
						text: 'Turnier Erstellen';
						addClickEventSelector: #buttonNewTournament;
						yourself);
				addCssClassCol6;
				yourself)
			).
			
		collapsibleAccordion := (Me5Accordion new
				addChild: (Me5AccordionItem new
					icon: Me5I newFasEdit;
					title: 'Turnier erstellen';
					addChildToContent: createTournamentDiv;
					yourself);
				yourself).
			
		theResultDiv := Me5Div new. 
		theResultDiv addChild: (Me5H1 new text: 'Turniere').
		theResultDiv addChild: (Me5Hr new).
		"theResultDiv addChild: (self collapsiblePortlet)."
		theResultDiv addChild: collapsibleAccordion.
		theResultDiv addChild: (theRow := Me5Row new).
		self tournamentRow: theRow.
		
		"self tournamentRow addChild: (Me5Div new
			addChild: (Me5Button newSuccess 
				text: 'Turnier hinzuf&uuml;gen';
				icon: Me5I newFasPlus;
				addClickEventSelector: #buttonNewTournament;
				addCssClassCol2;
				yourself);
			addCssClassCol12;
			yourself)."
		
		"load Tournaments"
		1 to: (self collectionOfTournaments size) do: [:index | 
			| currentTournament |
			currentTournament := (self collectionOfTournaments at: index).
			self tournamentRow addChild: (Me5Div new
				addChild: (Me5Portlet newPrimary
					title: currentTournament name;
					addChildToHeadTools: (Me5A newPortletNavLinkIcon
						icon: Me5I newFasTrash;
						"addClickEventSelector: #removeTournament tournamentIndex: index;"
						yourself);
					addChildToBody: (Me5P new
						text: ((currentTournament tournamentType) asString, ' / ', (currentTournament gameMode) asString );
						fontSize: 'medium';
						yourself);
					addChildToBody: (Me5P new 
						text: ('Rivalen: ', '-' );
						fontSize: 'large';
						yourself);
					addChildToBody: (Me5A newPrimary
						setTargetBlank;
						"showForMdAndBiggerDevices;"
						rightIcon: Me5I newFasAngleRight;
						text: 'Zum Turnier';
						href: ('TurnierplanerView/specificTournament?tournamentName=dasErsteTurnier %1&team=true' bindWith: (currentTournament name));
						yourself);
					addChildToFoot:  (Me5ProgressBar newPrimary
						value: ((currentTournament numberOfPlayedGames asInteger) / (currentTournament numberOfGames asInteger) * 100) asInteger;
						height: 20;
						setPrimaryStyle;
						yourself);
					addChildToFoot: (Me5P new
						text: (currentTournament numberOfPlayedGames asString), ' von ', (currentTournament numberOfGames asString);
						textAlign: 'center';
						fontSize: 'larger';
						yourself);
					setTargetBlank;

					yourself);
				padding: 15;
				addCssClassColSm12;
				addCssClassColMd6;
				addCssClassColXl4;
			yourself).
		].






	self createTournamentTextFieldTournamentName: textFieldTournamentName.
	self createTournamentRadioGroupTournamentType: radioGroupTournamentType.
	self createTournamentRadioGroupGameMode: radioGroupGameMode.
	self createTournamentMultiComboBoxRivals: multiComboBoxRivals.
	

	^theResultDiv.

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
	(self user = nil)
		ifTrue: [
			thePlayer:=Player firstName: 'Max' lastName: 'Muster'  email: 'max.muster@gmail.com'.
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
