Class {
	#name : 'SpecificTournamentView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'gameID',
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

	self offsetX: 40;
		offsetY: 40;
		width: 400;
		height: 260;
		rowsSpacing: 20;
		columnSpacing: 100;
		tournament: (TournamentPlannerApp collectionOfTournaments data detect: [ :eachTournament |
			eachTournament name = (self queryParameters at: 'tournamentName')]);
		tournamentType: (self queryParameters at: 'tournamentType');
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

	self addChild: (Me5H1 new
			addCssClassTextCenter;
			text: self tournament name;
			yourself);
		addChild: Me5Hr new;
		yourself.
		
	self tournamentType = 'KO'
		ifTrue: [self addChild: self createTournament]
]

{ #category : 'Initial-Events' }
SpecificTournamentView >> createModules [

	super createModules
]

{ #category : 'Internal' }
SpecificTournamentView >> createTournament [

	"^self"
	"creates Tournaments with KOTournamentType"
	
	| theResultDiv theScroller thePoints |

	thePoints := OrderedCollection new.
	"{ spalte { reihe { x1 y1 x2 y2 } reihe {...} reihe {...} reihe {...} } spalte {...} spalte {...} }"
	
	theResultDiv := Me5Div new
		addChild: (theScroller := Me5Scroller new
		height: 2 * self tournament games last layer * (self height + self rowsSpacing )).

	1 to: self tournament games last layer do: [ :eachLayer |
		| theGamesOfLayer |
		theGamesOfLayer := self tournament games select: [ :eachGame |
			eachGame layer = eachLayer].
			theGamesOfLayer doWithIndex: [ :eachGame :eachIndex |
				| theTop theLeft |
				theTop := (((self height + self rowsSpacing) * eachLayer) / 2  + self offsetY) + ((eachIndex - 1) * (self height + self rowsSpacing)).
				theLeft := self offsetX + ((eachLayer - 1) * (self width + self columnSpacing )).
				
				theScroller addChild: (Me5Portlet newSuccess
					title: eachGame name;
					setPositionToAbsolute;
					zIndex: 1;
					top: theTop;
					left: theLeft;
					width: self width;
					addChildToBody: (Me5Button newSuccess
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
						thePoints add: theLine].

				eachLayer > 1 
					ifTrue: [
						(thePoints at: (eachLayer * eachIndex - 1))
							at: 2 put: (Point new
								x: theLeft;
								y: theTop;
								yourself).
						(thePoints at: (eachLayer * eachIndex))
							at: 2 put: (Point new
								x: theLeft;
								y: theTop;
								yourself)]]].
	
	"draw Lines"
	
	thePoints do: [ :eachLine |
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
SpecificTournamentView >> setResultEvent: anEvent [

	"wip"

	anEvent component parent parent title.
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
SpecificTournamentView >> tournamentType [

	"<^iOf String>"
	"Answer the tournamentType of the receiver"

	^tournamentType
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournamentType: aString [

	"<aString: iOf String, ^self>"
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
