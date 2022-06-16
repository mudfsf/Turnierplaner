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
		'columnSpacing',
		'resultModal'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
SpecificTournamentView >> beforeCreateComponents [

	"<^self>"

	self offsetX: 40;
		offsetY: 40;
		width: 420;
		height: 280;
		rowsSpacing: 20;
		columnSpacing: 120;
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
SpecificTournamentView >> createKOTournament: canInitialGamesBePlayedBoolean [

	"<^hOf Me5Div>"
	"creates Tournaments with KOTournamentType"
	
	| theResultDiv theScroller theLines theNumberOfLaps |
	
	theNumberOfLaps := (self tournament games select: [ :eachGame | 
		eachGame layer = 0]) size.
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
				| theTop theLeft theButton thePortlet |
				
				eachLayer = 1
					ifTrue: [theTop := (eachIndex - 1) * (self height + self rowsSpacing) + self offsetY].
				theLeft := self offsetX + ((eachLayer - 1) * (self width + self columnSpacing)).

				thePortlet := (Me5Portlet newSuccess
					title: eachGame name;
					setPositionToAbsolute;
					zIndex: 1;
					width: self width;
					addChildToBody: (theButton := Me5Button newSuccess
						text: 'Ergebnis eintragen';
						addClickEventSelector: #setKOResultEvent:;
						yourself);
					addChildToFoot: (Me5Button newSuccess
						text: 'Wetten';
						yourself);
					yourself).
				
				canInitialGamesBePlayedBoolean
					ifFalse: [theButton disable].
					
				eachGame resultCollection size > 0 
					ifTrue: [
						thePortlet subTitle: ('Sieger: %1' bindWith: eachGame resultCollection first player asString).
						theButton disable].
					
				eachLayer > 1
					ifTrue: [
						| theIndex theMember1 theMember2 |
						
						theMember1 := '- '.
						theMember2 := ' - '.
						
						theIndex := ((eachLayer * (eachLayer - 1)) * eachIndex) + theNumberOfLaps.
						theTop := (((theLines at: theIndex -1 - theNumberOfLaps) at: 1) y + ((theLines at: theIndex - theNumberOfLaps) at: 1) y) / 2.
						
						eachGame memberCollection removeAll.
					
						(self tournament games at: (theIndex - 1) ) resultCollection isEmptyOrNil
							ifFalse: [
								theMember1 := (self tournament games at: (theIndex - 1)) resultCollection first player asString.
								eachGame memberCollection add: (self tournament games at: (theIndex - 1)) resultCollection first player].	
						(self tournament games at: theIndex) resultCollection isEmptyOrNil
							ifFalse: [
								theMember2 := (self tournament games at: theIndex ) resultCollection first player asString.
								eachGame memberCollection add: (self tournament games at: theIndex) resultCollection first player].
							
						eachGame name: ('%1 vs %2' bindWith: theMember1 with: theMember2).
												
						(theLines at: theIndex - 1 - theNumberOfLaps)
							at: 2 put: (Point new
								x: theLeft;
								y: theTop;
								yourself).
						(theLines at: theIndex - theNumberOfLaps)
							at: 2 put: (Point new
								x: theLeft;
								y: theTop;
								yourself).
						"Have prerequisite games already been played"
						((self tournament games at: theIndex -1) resultCollection size > 0 
						and: [(self tournament games at: theIndex) resultCollection size > 0])
							ifFalse: [theButton disable]].
							
				eachLayer < self tournament games last layer
					ifTrue: [
						| theLine |
						theLine := Array new: 2.
						theLine at: 1 put: (Point new 
							x: theLeft;
							y: theTop;
							yourself).
						theLines add: theLine].
						
				thePortlet top: theTop;
					left: theLeft;
					yourself.
				theScroller addChild: thePortlet]].
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
	
	| theTableOfRanking |
	
	theTableOfRanking := Me5Table new.
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
			addChildToBody: (Me5AutoLoadingTable new
				disableShowInfoTableRow;
				objects: (self tournament games select: [ :eachGame | 
					eachGame layer = 0]);
				addTableRowClickedEventSelector: #setLapsResultEvent: ;
				addColumnDefinition: (Me5ColumnDefinition new
					title: 'Spieler 1';
					definitionBlock: [ :theObjecst :theTableData  |
						theTableData
							text: theObjecst memberCollection first asString ;
							yourself];
					yourself);
				addColumnDefinition: (Me5ColumnDefinition new
					title: 'Spieler 2';
					definitionBlock: [ :theObjecst :theTableData  |
						theTableData
							text: theObjecst memberCollection second asString ;
							yourself];
					yourself);
				addColumnDefinition: (Me5ColumnDefinition new
					title: 'Sieger';
					definitionBlock: [ :theObjecst :theTableData  |
						| theText |
						theText := 'Kein Sieger festgelegt'.
						theObjecst resultCollection isEmptyOrNil
							ifFalse: [theText := theObjecst resultCollection first player asString].
						theTableData
							text: theText;
							yourself];
					yourself);
				yourself);
			yourself);
		addChild: (Me5Portlet new
			icon: Me5I newFasTable;
			title: 'Platzierungstabelle';
			addChildToBody: theTableOfRanking;
			yourself);	
		yourself
]

{ #category : 'Internal' }
SpecificTournamentView >> createMixedTournament [

	"<^hOf Me5Div>"
	"creates the View of the Mixedtournament."
	
	^Me5Div new
		addChild: (Me5H3 newWithText: 'Rundenturnier');
		addChild: self createLapsTournament;
		addChild: (Me5H3 newWithText: 'KO Turnier');
		addChild: (self createKOTournament: self haveLapsBeenPlayed);
		yourself
]

{ #category : 'Initial-Events' }
SpecificTournamentView >> createModules [

	"<^self>"

	super createModules.
	self addModuleByModuleClass: Me5LoadingTableModuleBundle 
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

{ #category : 'Internal' }
SpecificTournamentView >> haveLapsBeenPlayed [

	"<^hOf Boolean>"
	
	^(self tournament games select: [ :eachGame |
		eachGame layer = 0]) conform: [ :eachGame | 
			eachGame resultCollection notEmptyAndNotNil]
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

{ #category : 'Accessing' }
SpecificTournamentView >> resultModal [

	"<^iOf ModalView>"
	"Answer the resultModal of the receiver"

	^resultModal
]

{ #category : 'Accessing' }
SpecificTournamentView >> resultModal: aModalView [

	"<aModalView: iOf ModalView, ^self>"
	"Set the resultModal of the receiver"

	resultModal := aModalView
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
	self setDrawingArea.
	self resultModal closeModal.
	self reloadViewBySourceView: self
]

{ #category : 'Events' }
SpecificTournamentView >> saveLapsWinnerEvent: anEvent [

	self saveWinnerEvent: anEvent.
	self tournamentDrawingArea parent removeChild: self tournamentDrawingArea ifAbsent: [].
	self setDrawingArea.
	self resultModal closeModal.
	self reloadViewBySourceView: self
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
		
	self tournament playedGames add: self game.	
	
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
		ifTrue: [self tournamentDrawingArea: (self createKOTournament: true)].
	self tournamentType = 'Runden'
		ifTrue: [self tournamentDrawingArea: self createLapsTournament].
	self tournamentType = 'Mixed'
		ifTrue: [self tournamentDrawingArea: self createMixedTournament].
		
	self addChild: self tournamentDrawingArea
]

{ #category : 'Events' }
SpecificTournamentView >> setKOResultEvent: anEvent [

	"<^self>"
		
	self game: (self tournament games detect: [ :eachGame |
		eachGame name = anEvent component parent parent title] ifNone: []).
	self setResultEvent
]

{ #category : 'Events' }
SpecificTournamentView >> setLapsResultEvent: anEvent [

	"<^self>"
		
	self game: anEvent loadingTableTableRowObject.
	self game resultCollection isEmptyOrNil
		ifFalse: [^self].
	self setResultEvent
]

{ #category : 'Events' }
SpecificTournamentView >> setResultEvent [

	"<^self>"
	"wip"	
	
	| theButton |
		
	self resultModal: (ModalView new title: 'Ergebnis').
	
	self game resultCollection size = 0
		ifTrue: [
			self resultModal body: (Me5Form new
				addChildToBody: (Me5SelectBox new
					text: 'Sieger';
					noneObject: 'Kein Sieger festgelegt';
					objects: (self game memberCollection collect: [ :eachMember | 
						eachMember asString]);
					yourself);
				yourself)]
		ifFalse: [
				self resultModal body: (Me5Form new
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
	(self tournamentType = 'KO' or: [self tournamentType = 'Mixed' and: [self haveLapsBeenPlayed]])
		ifTrue: [theButton addClickEventSelector: #saveKOWinnerEvent: eventReceiver: self].
	(self tournamentType = 'Runden' or: [self tournamentType = 'Mixed'  and: [self haveLapsBeenPlayed not]])
		ifTrue: [theButton addClickEventSelector: #saveLapsWinnerEvent: eventReceiver: self].
	self resultModal body addChildToBody: theButton.
		
	self openModal: self resultModal
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
