Class {
	#name : 'SpecificTournamentView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'tournamentDrawingArea',
		'selectBoxPlayers',
		'game',
		'tournament',
		'tournamentType',
		'offsetX',
		'offsetY',
		'width',
		'height',
		'rowsSpacing',
		'columnSpacing'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
SpecificTournamentView >> beforeCreateComponents [

	"<^self>"

	self offsetX: 40;
		offsetY: 40;
		width: 400;
		height: 260;
		rowsSpacing: 20;
		columnSpacing: 100;
		tournament: (TournamentPlannerApp collectionOfTournaments data detect: [ :eachTournament |
			eachTournament name = (self queryParameters at: 'tournamentName')]);
		tournamentType: (self queryParameters at: 'tournamentType');
		tournamentDrawingArea: Me5Div new;
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> columnSpacing [

	"<^hOf Number>"
	"Answer the columnSpacing of the receiver"

	^columnSpacing
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> columnSpacing: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the columnSpacing of the receiver"

	columnSpacing := aNumber
]

{ #category : 'Initial-Events' }
SpecificTournamentView >> createComponents [

	"<^self>"

	self addChild: (Me5H1 new
			addCssClassTextCenter;
			text: self tournament name;
			yourself);
		addChild: Me5Hr new;
		yourself.
	self setDrawingArea
]

{ #category : 'Internal' }
SpecificTournamentView >> createKOTournament [

	"<^self>"
	"creates Tournaments with KOTournamentType"
	
	| theResultDiv theScroller theLines |

	theLines := OrderedCollection new.
	"{ spalte { reihe { x1 y1 x2 y2 } reihe {...} reihe {...} reihe {...} } spalte {...} spalte {...} }"
	theResultDiv := Me5Div new
		addChild: (theScroller := Me5Scroller new
		height: 2 * self tournament games last layer * (self height + self rowsSpacing )).
	1 to: self tournament games last layer do: [ :eachLayer |
		| theGamesOfLayer |
		theGamesOfLayer := self tournament games select: [ :eachGame |
			eachGame layer = eachLayer].
			theGamesOfLayer doWithIndex: [ :eachGame :eachIndex |
				| theTop theLeft theButton |
				theTop := (((self height + self rowsSpacing) * eachLayer) / 2  + self offsetY) + ((eachIndex - 1) * (self height + self rowsSpacing)).
				theLeft := self offsetX + ((eachLayer - 1) * (self width + self columnSpacing)).				
				theScroller addChild: (Me5Portlet newSuccess
					title: eachGame name;
					setPositionToAbsolute;
					zIndex: 1;
					top: theTop;
					left: theLeft;
					width: self width;
					addChildToBody: (theButton := Me5Button newSuccess
						text: 'Ergebnis eintragen';
						addClickEventSelector: #setResultEvent:;
						yourself);
					addChildToFoot: (Me5Button newSuccess
						text: 'Wetten';
						yourself);
					yourself).
				eachLayer < self tournament games last layer
					ifTrue: [
						| theLine |
						theLine := Array new: 2.
						theLine at: 1 put: (Point new 
							x: theLeft;
							y: theTop;
							yourself).
						theLines add: theLine].
				eachLayer > 1 
					ifTrue: [
						| theIndex |
						theIndex := (eachLayer * (eachLayer - 1)) * eachIndex.
						(theLines at: theIndex - 1)
							at: 2 put: (Point new
								x: theLeft;
								y: theTop;
								yourself).
						(theLines at: theIndex)
							at: 2 put: (Point new
								x: theLeft;
								y: theTop;
								yourself).
						"Have prerequisite games already been played"
						((self tournament games at: theIndex -1) resultCollection size > 0 
						and: [(self tournament games at: theIndex) resultCollection size > 0])
							ifFalse: [theButton disable]]]].
	"draw Lines"
	theLines do: [ :eachLine |
		| theFirstPoint theSecondPoint theMaxX theMaxY |
		theFirstPoint := eachLine at: 1.
		theSecondPoint := eachLine at: 2.
		(theFirstPoint x  > theSecondPoint x) 
			ifTrue: [theMaxX := theFirstPoint x] 
			ifFalse: [theMaxX := theSecondPoint x].
		(theFirstPoint y  > theSecondPoint y) 
			ifTrue: [theMaxY := theFirstPoint y] 
			ifFalse: [theMaxY := theSecondPoint x].
		theScroller addChild: (Me5SvgLine new
			x1: theFirstPoint x + (self width * 0.75);
			y1: theFirstPoint y+ (self height * 0.5);
			x2: theSecondPoint x + (self width * 0.25);
			y2: theSecondPoint y + (self height * 0.5);
			strokeWidth: 5;
			stroke: 'lightGrey';
			svgHeight: theMaxY * 2;
			svgWidth: theMaxX * 2;
			svgTop: 0;
			svgLeft: 0;
			yourself)].
	^theResultDiv
]

{ #category : 'Internal' }
SpecificTournamentView >> createLapsTournament [

	"<^hOf Me5Div>"
	"creates the View of the Lapstournament."
	
	| theTableOfMatches theTableOfRanking |
	
	theTableOfMatches := Me5Table new.
	theTableOfRanking := Me5Table new.
	theTableOfMatches
		addChildToHead: (Me5TableRow new
			addTableHeaderWithText: 'Spiel-Nr.';
			addTableHeaderWithText: 'Spieler 1';
			addTableHeaderWithText: 'Spieler 2';
			addTableHeaderWithText: 'Sieger';
			yourself).
	self tournament games doWithIndex: [ :eachGame  :eachIndex |
	theTableOfMatches addChildToBody: (Me5TableRow new
		addTableDataWithText: eachIndex;
		addTableDataWithText: eachGame memberCollection first;
		addTableDataWithText: eachGame memberCollection second;
		addTableDataWithText: 'noch nicht ausgetragen';
		yourself)].	
	theTableOfRanking
		addChildToHead: (Me5TableRow new
			addTableHeaderWithText: 'Platzierung';
			addTableHeaderWithText: 'Spieler';
			addTableHeaderWithText: 'Siege';
			addTableHeaderWithText: 'Niederlagen';
			yourself).
	self tournament membercollection doWithIndex: [ :eachMember :eachIndex |
	theTableOfRanking addChildToBody: (Me5TableRow new
		addTableDataWithText: eachIndex;
		addTableDataWithText: eachMember asString;
		addTableDataWithText: 0;
		addTableDataWithText: '0';
		yourself)].
	
	^Me5Div new
		addChild: (Me5Portlet new
			icon: Me5I newFasTable;
			title: 'Auszutragende Spiele';
			addChildToBody: theTableOfMatches;
			yourself);
			addChild: (Me5Button newAirPrimary
				text: 'Ergebnisse melden';
				yourself);
		addChild: (Me5Portlet new
			icon: Me5I newFasTable;
			title: 'Platzierungstabelle';
			addChildToBody: theTableOfRanking;
			yourself);	
		yourself
]

{ #category : 'Initial-Events' }
SpecificTournamentView >> createModules [

	"<^self>"

	super createModules
]

{ #category : 'Accessing' }
SpecificTournamentView >> game [

	"<^iOf Game>"
	"Answer the game of the receiver"

	^game
]

{ #category : 'Accessing' }
SpecificTournamentView >> game: aGame [

	"<aGame: iOf Game, ^self>"
	"Set the game of the receiver"

	game := aGame
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> height [

	"<^hOf Number>"
	"Answer the height of the receiver"

	^height
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> height: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the height of the receiver"

	height := aNumber
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> offsetX [

	"<^hOf Number>"
	"Answer the offsetX of the receiver"

	^offsetX
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> offsetX: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the offsetX of the receiver"

	offsetX := aNumber
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> offsetY [

	"<^hOf Number>"
	"Answer the offsetY of the receiver"

	^offsetY
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> offsetY: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the offsetY of the receiver"

	offsetY := aNumber
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> rowsSpacing [

	"<^hOf Number>"
	"Answer the rowsSpacing of the receiver"

	^rowsSpacing
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> rowsSpacing: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the rowsSpacing of the receiver"

	rowsSpacing := aNumber
]

{ #category : 'Events' }
SpecificTournamentView >> saveKOWinnerEvent: anEvent [

	self saveWinnerEvent: anEvent.
	self tournamentDrawingArea parent removeChild: self tournamentDrawingArea ifAbsent: [].
	self setDrawingArea
]

{ #category : 'Events' }
SpecificTournamentView >> saveWinnerEvent: anEvent [

	
	| theMemberName theWinnerMember theMember theResultCollection |
	
	self game resultCollection size = 1
		ifTrue: [^self].
	theMemberName := anEvent component parent children first value.
	theMemberName = 'Kein Sieger festgelegt'
		ifTrue: [self showErrorNotificationWithMessage: 'Bitte Sieger ausw&auml;hlen'.
			^self].
	theWinnerMember := self game memberCollection detect: [:eachMember |
		eachMember asString = theMemberName] ifNone: [].
	theMember := self game memberCollection reject: [:eachMember |
		eachMember asString = theMemberName].
		
	theResultCollection := OrderedCollection new	
		add: (Result newWithPlayer: theWinnerMember ranking: 1 points: 2);
		add: (Result newWithPlayer: theMember first ranking: 2 points: 1);
		yourself.
	self game resultCollection removeAll.
	self game resultCollection addAll: theResultCollection.
	self tournament playedGames remove: self game ifAbsent: [].
	self tournament playedGames add: self game.
	TournamentPlannerApp saveCollectionOfTournaments: TournamentPlannerApp collectionOfTournaments data.
	self showSuccessNotificationWithMessage: ('Sieger %1 wird gespeichert' bindWith: theMemberName)
]

{ #category : 'Accessing' }
SpecificTournamentView >> selectBoxPlayers [

	"<^hOf Me5SelectBox>"
	"Answer the selectBoxPlayers of the receiver"

	^selectBoxPlayers
]

{ #category : 'Accessing' }
SpecificTournamentView >> selectBoxPlayers: aMe5SelectBox [

	"<aMe5SelectBox: hOf Me5SelectBox, ^self>"
	"Set the selectBoxPlayers of the receiver"

	selectBoxPlayers := aMe5SelectBox
]

{ #category : 'Internal' }
SpecificTournamentView >> setDrawingArea [
	
	"<^self>"

	self tournamentType = 'KO'
		ifTrue: [self tournamentDrawingArea: self createKOTournament].
	self tournamentType = 'Runden'
		ifTrue: [self tournamentDrawingArea: self createLapsTournament].
		
	self addChild: self tournamentDrawingArea
]

{ #category : 'Events' }
SpecificTournamentView >> setResultEvent: anEvent [

	"<^self>"
	"wip"	
	
	| theModalView theButton |
	
	self game: (self tournament games detect: [ :eachGame |
		eachGame name = anEvent component parent parent title] ifNone: []).
		
	theModalView := ModalView new title: 'Ergebnis'.
	
	self game resultCollection size = 0
		ifTrue: [
			theModalView body: (Me5Form new
				addChildToBody: (Me5SelectBox new
					text: 'Sieger';
					noneObject: 'Kein Sieger festgelegt';
					objects: (self game memberCollection collect: [ :eachMember | 
						eachMember asString]);
					yourself);
				yourself)]
		ifFalse: [
				theModalView body: (Me5Form new
					addChildToBody: (Me5SelectBox new
						text: 'Sieger';
						disableNoneObject;
						objects: (self game resultCollection collect: [ :eachResult | 
							eachResult player asString]);
						yourself);
					yourself)].
	theButton := Me5Button newPrimary
		text: 'Speichern';
		icon: Me5I newFasSave;
		yourself.
	self tournamentType = 'KO'
		ifTrue: [theButton addClickEventSelector: #saveKOWinnerEvent: eventReceiver: self].
	theModalView body addChildToBody: theButton.
		
	self openModal: theModalView
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournament [

	"<^iOf Tournament>"
	"Answer the tournament of the receiver"

	^tournament
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournament: aTournament [

	"<aTournament: iOf Tournament, ^self>"
	"Set the tournament of the receiver"

	tournament := aTournament
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournamentDrawingArea [

	"<^hOf Me5Div>"
	"Answer the tournamentDrawingArea of the receiver"

	^tournamentDrawingArea
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournamentDrawingArea: aDiv [

	"<aDiv: hOf Me5Div, ^self>"
	"Set the tournamentDrawingArea of the receiver"

	tournamentDrawingArea := aDiv
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournamentType [

	"<^hOf String>"
	"Answer the tournamentType of the receiver"

	^tournamentType
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournamentType: aString [

	"<aString: hOf String, ^self>"
	"Set the tournamentType of the receiver"

	tournamentType := aString
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> width [

	"<^hOf Number>"
	"Answer the width of the receiver"

	^width
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SpecificTournamentView >> width: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the width of the receiver"

	width := aNumber
]
