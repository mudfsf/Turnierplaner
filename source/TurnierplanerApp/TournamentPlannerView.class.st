Class {
	#name : 'TournamentPlannerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'user',
		'collectionOfPlayers',
		'collectionOfTournaments'
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

	| theMemory theBlob|

	theMemory := StartUp new.	

	"theBlob := OrderedCollection new.
		
	theMemory saveObject: theBlob onPath: 'C:\TournamentPlanner\Memory\tournaments.dat'.

		theBlob add: (Player new
		firstName: 'TestAdmin';
		lastName:  '';
		email: 'TestAdmin@Test.com';
		yourself).
		
	theMemory saveObject: theBlob onPath: 'C:\TournamentPlanner\Memory\players.dat'."
	
	self collectionOfTournaments: (theMemory loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\tournaments.dat').
	self collectionOfPlayers:  (theMemory loadAnObjectFromPath: 'C:\TournamentPlanner\Memory\players.dat').


	

]

{ #category : 'Not categorized' }
TournamentPlannerView >> buttonNewTournament [

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
		addChild: (Me5Form new
			addChildToBody: (Me5Portlet new
				addChildToBody: (Me5Tabbable newFilled
					addTabs: self tabsCollection;
					yourself);
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
]

{ #category : 'Not categorized' }
TournamentPlannerView >> dashboardTab [

 | theDashboard |

theDashboard := Me5Div new.
theDashboard 
addChild:  (Me5H2 new
	text: 'HR-Works Turnierplaner';
	addChild: (Me5Portlet new
				addChildToBody: (Me5Div new
					addChild: (Me5H3 new
						text: 'Nächstes Spiel für dich');
					addChild: 
						(Me5Hr new);
					addChild: 
						(Me5H5 new text: 'Turnier: Best Team Now');
					addChild: 
						(Me5H5 new text: 'Team Yeah VS Team Nope');
					addChild: 
						(Me5Hr new);
					addChild: 
						(Me5H5 new text: 'In 3 Tagen um 15:30');
						yourself);
					yourself);
				yourself);
	addChild: (Me5Portlet new
				addChildToBody: (Me5Div new
				addChild: 
				(Me5H3 new
						text: 'Laufende Turniere');
				addChild: 
						(Me5Hr new);
				addChild: 
						(Me5H5 new text: 'Turnier: Best Team Now');
				addChild: 
						(Me5H6 new text: '5 übrige Spiele');
				addChild: 
					(Me5ProgressBar newPrimary
										addCssClassMProgressLg;
										value: 50;
										yourself);
				addChild: 
						(Me5Hr new);									
				addChild: 
						(Me5H5 new text: 'Best Player Now');
				addChild: 
						(Me5H6 new text: '12 übrige Spiele');
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
				(Me5H3 new
						text: 'Wetten');
				addChild: 
						(Me5Hr new);
				addChild: 
						(Me5H5 new text: '35€');
				addChild: 
						(Me5Hr new);									
				addChild: 
						(Me5H5 new text: 'Laufende Wetten');
				addChild: 
						(Me5H5 new text: '5€');
				addChild: 
						(Me5H6 new text: 'Team Yeah - 14.6.2022');
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
TournamentPlannerView >> tabsCollection [

	| theUserSettings theManagedPlayerView|
	
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
			addChildToTabPane: (Me5P new
				text: 'You see the Profile tab right now.';
				addCssClassMFontPrimary; "Only for presentation mode. Different text color to distinguish between different tabs in the example."
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
			addChildToTabPane: theManagedPlayerView view"self adminToolsTab";
			yourself);
		yourself

]

{ #category : 'Not categorized' }
TournamentPlannerView >> tournamentTab [

	| theResultDiv theTournamentList |

		theTournamentList := #('Tournament 1' 'Tournament 2' 'Tournament 3' 'Tournament 4').

		theResultDiv := ((Me5Div new) addChild: Me5Row new).
		
		theResultDiv addChild: (Me5Div new
			addChild: (Me5Button newSuccess 
				text: 'Turnier hinzufÃ¼gen';
				icon: Me5I newFasPlus;
				addClickEventSelector: #buttonNewTournament;
				addCssClassCol1;
				yourself);
			addChild: (Me5P new
				"text: (self collectionOfTournaments games asString)"
			);
			addCssClassCol12;
			yourself).

		1 to: (theTournamentList size) do: [:index | 
			theResultDiv addChild: (Me5Div new
				addChild: (Me5Portlet newPrimary
					title: (theTournamentList at: index);
					addChildToBody: (Me5P new 
						text: 'Gegner 1 VS Gegner 2';
						fontSize: 'large';
						yourself);
					addChildToBody: (Me5A newButtonIconOnly
						setTargetBlank;
						icon: Me5I newFalCheck;
						text: 'Mein Text Test';
						backgroundColor: 'grey';
						href: ('TurnierplanerView/specificTournament?tournamentName=dasErsteTurnier %1&team=true' bindWith: index);
						yourself);
					addChildToFoot:  (Me5ProgressBar newPrimary
						value: 65;
						height: 20;
						setPrimaryStyle;
						yourself);
					addChildToFoot: (Me5P new
						text: '5 von 9';
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



	^(Me5Portlet newPrimary
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
				
			yourself).
]
