Class {
	#name : 'TournamentPlannerView',
	#superclass : 'Me5BaseView',
	#category : 'TurnierplanerApp'
}

{ #category : 'Not categorized' }
TournamentPlannerView >> createComponents [

	super createModules.
	self addModuleByModuleClass: Me5ComboBoxModuleBundle.

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

{ #category : 'Not categorized' }
TournamentPlannerView >> dashboardTab [

^(Me5P new text: 'Dashboard').
]

{ #category : 'Not categorized' }
TournamentPlannerView >> tabsCollection [

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
			addChildToTabPane: (Me5P new
				text: 'You see the Profile tab right now.';
				addCssClassMFontPrimary; "Only for presentation mode. Different text color to distinguish between different tabs in the example."
				yourself);
			yourself);
		add: (Me5Tab new
			text: 'Admin-Tools';
			icon: Me5I newFasUser;
			addChildToTabPane: (Me5P new
				text: 'You see the Profile tab right now.';
				addCssClassMFontPrimary; "Only for presentation mode. Different text color to distinguish between different tabs in the example."
				yourself);
			yourself);
		yourself

]

{ #category : 'Not categorized' }
TournamentPlannerView >> tournamentTab [

	| theResultDiv theTournamentList |

		theTournamentList := #('Tournament 1' 'Tournament 2' 'Tournament 3' 'Tournament 4').

		theResultDiv := ((Me5Div new) addChild: Me5Row new).


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
						icon: Me5I newFalAdjust;
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
