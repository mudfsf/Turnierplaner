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
					addTabs: self theTabs;
					yourself);
				yourself);
			yourself);	
		yourself.
]

{ #category : 'Not categorized' }
TournamentPlannerView >> theDashboardTab [

| aResultDiv aScroller aSpielanzahl aSpieleInSpalte aOffsetX aOffsetY aSpielBreite aSpielHoehe aReihenabstand aSpaltenabstand aSpielUndAbstandHoehe |

aSpielanzahl := 8.
aSpieleInSpalte := aSpielanzahl.
aOffsetX := 10.
aOffsetY := 10.
aSpielBreite := 400.
aSpielHoehe := 260.
aReihenabstand := 20.
aSpaltenabstand := 100.
aSpielUndAbstandHoehe := aSpielHoehe + aReihenabstand.


aResultDiv := Me5Div new.

aResultDiv addChild: (Me5H1 newWithText: 'Beispielansicht Turnier').
aResultDiv addChild: (aScroller := Me5Scroller new
	height: aSpielanzahl * aSpielUndAbstandHoehe).

0 to: (aSpielanzahl log: 2) do: [:indexSpalten |
	0 to: (aSpieleInSpalte - 1) do: [:indexReihen |
		aScroller addChild: (Me5Portlet newSuccess
			title: 'Gegner 1 VS Gegner 2';
			setPositionToAbsolute;
			top: aOffsetY + (indexReihen * aSpielUndAbstandHoehe);
			left: aOffsetX + (indexSpalten * (aSpielBreite + aSpaltenabstand));
			width: aSpielBreite;
			addChildToBody: (Me5Button newSuccess
				text: 'Ergebnis eintragen';
				yourself);
			addChildToFoot: (Me5Button newSuccess
				text: 'Wetten';
				yourself);
			yourself).
	].
	aSpieleInSpalte := aSpieleInSpalte / 2.
	aOffsetY := aOffsetY + (aSpielUndAbstandHoehe / 2).
	aSpielUndAbstandHoehe := aSpielUndAbstandHoehe * 2.
	
].
	"
aResultDiv addChild: (ClwHtmlSvgLine new
	x1: 50;
	y1: 50;
	x2: 100;
	y2: 100;
	fill: 'black';
	yourself).
"

^aResultDiv.
]

{ #category : 'Not categorized' }
TournamentPlannerView >> theTabs [

^OrderedCollection new
		add: (Me5Tab new
			text: 'Dashboard';
			icon: Me5I newFasHome;
			addChildToTabPane: self theDashboardTab;
			activateTab; "Make sure that 'activateTab' is called after you added a child to tabPane."
			yourself);
		add: (Me5Tab new
			text: 'Turniere';
			icon: Me5I newFasUser;
			addChildToTabPane: self theTurniereTab;
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
TournamentPlannerView >> theTurniereTab [

	| aTurniere aTurniereDiv |

	aTurniere := #('Turnier 1' 'Turnier 2' 'Turnier 3').
	aTurniereDiv := Me5Div new.

	aTurniere do: [:eachTurnier | 
		aTurniereDiv addChild: (Me5Form new
			addChildToBody: (Me5Portlet newInfo
				title: 'Full Display Width')
				).
		
		
	].


	^aTurniereDiv.
]
