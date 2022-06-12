Class {
	#name : 'SpecificTournamentView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'gameID',
		'tournament'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
SpecificTournamentView >> beforeCreateComponents [

	self tournament: (TournamentPlannerApp collectionOfTournaments data detect: [ :eachTournament |
		eachTournament name = (self queryParameters at: 'tournamentName')])
]

{ #category : 'Initial-Events' }
SpecificTournamentView >> createComponents [

	self addChild: (Me5H1 new
			addCssClassTextCenter;
			text: self tournament name;
			yourself);
		addChild: Me5Hr new;
		addChild: self createTournament;
		yourself
]

{ #category : 'Initial-Events' }
SpecificTournamentView >> createModules [

	super createModules
]

{ #category : 'Internal' }
SpecificTournamentView >> createTournament [

	| theResultDiv theScroller theNumberOfGamesFirstColumn theGamesinColumn theOffsetX theOffsetY theGameWidth theGameHeight theRowsSpacing theColumnSpacing theGameHeightAndSpacing theCoordinatesLineArray theNumberOfColumn theGameIndex |

	theNumberOfGamesFirstColumn := (self tournament membercollection size) / 2.
	theGamesinColumn := theNumberOfGamesFirstColumn.
	theOffsetX := 40.
	theOffsetY := 40.
	theGameWidth := 400.
	theGameHeight := 260.
	theRowsSpacing := 20.
	theColumnSpacing := 100.
	theGameHeightAndSpacing := theGameHeight + theRowsSpacing.
	theNumberOfColumn := ((theNumberOfGamesFirstColumn log: 2) + 1) asInteger.
	theCoordinatesLineArray := Array new: theNumberOfColumn.
	theGameIndex := 1.
	"{ spalte { reihe { x1 y1 x2 y2 } reihe {...} reihe {...} reihe {...} } spalte {...} spalte {...} }"
	
	theResultDiv := Me5Div new
		addChild: (theScroller := Me5Scroller new
		height: 2 * theNumberOfGamesFirstColumn * theGameHeightAndSpacing).

	1 to: theNumberOfColumn do: [ :eachColumn |
		theCoordinatesLineArray at: eachColumn put: (Array new: theGamesinColumn).
		1 to: theGamesinColumn do: [ :eachRow |
			| theTop theLeft gameTitle gameMembers |
			theTop := theOffsetY + ((eachRow - 1) * theGameHeightAndSpacing).
			theLeft := theOffsetX + ((eachColumn - 1) * (theGameWidth + theColumnSpacing)).
			
			gameMembers := (self tournament games at: theGameIndex) members.
			(gameMembers at: 1) class = UndefinedObject ifTrue: [
				(gameMembers at: 2) class = UndefinedObject ifTrue: [
					gameTitle := ''.] ifFalse: [
						gameTitle := ('Freilos %1' bindWith: (gameMembers at: 2) firstName).] 
				.]
				
				ifFalse: [
					(gameMembers at: 2) class = UndefinedObject ifTrue: [
						gameTitle := ('Freilos %1' bindWith: (gameMembers at: 1) firstName).] 
						ifFalse: [
							gameTitle := ('%1 VS %2' bindWith: (gameMembers at: 1) firstName with: (gameMembers at: 2) firstName).].].
					
				
			
			theScroller addChild: (Me5Portlet newSuccess
				title: gameTitle;
				setPositionToAbsolute;
				zIndex: 1;
				top: theTop;
				left: theLeft;
				width: theGameWidth;
				addChildToBody: (Me5Button newSuccess
					text: 'Ergebnis eintragen';
					yourself);
				addChildToFoot: (Me5Button newSuccess
					text: 'Wetten';
					yourself);
				yourself).
			"set line coordinates (1er) x1 y1"
			(theCoordinatesLineArray at: eachColumn)
				at: eachRow put: ((Array new: 4)
					at: 1 put: theLeft; 
					at: 2 put: theTop; 
					yourself).
			"set line coordinates (2er) x2 y2"
			eachColumn > 1 
				ifTrue: [
					((theCoordinatesLineArray at: eachColumn - 1) 
						at: eachRow * 2 - 1)
							at: 3 put: theLeft;
							at: 4 put: theTop;
							yourself.
					((theCoordinatesLineArray at: eachColumn - 1)
						at: eachRow * 2)
							at: 3 put: theLeft;
							at: 4 put: theTop;
							yourself].
					theGameIndex := theGameIndex + 1.].

		theGamesinColumn := theGamesinColumn / 2.
		theOffsetY := theOffsetY + (theGameHeightAndSpacing / 2) asInteger.
		theGameHeightAndSpacing := theGameHeightAndSpacing * 2.
	].
	
	"draw Lines"
	1 to: theCoordinatesLineArray size - 1 do: [ :eachColumn |
		1 to: (theCoordinatesLineArray at: eachColumn) size do: [:eachRow |
			| theMaxX theMaxY theCoordinatesXY |
			theCoordinatesXY := (theCoordinatesLineArray at: eachColumn)
				at: eachRow.
			((theCoordinatesXY at: 1) > (theCoordinatesXY at: 3)) 
				ifTrue: [theMaxX := theCoordinatesXY at: 1] 
				ifFalse: [theMaxX := theCoordinatesXY at: 3].
			((theCoordinatesXY at: 2) > (theCoordinatesXY at: 4)) 
				ifTrue: [theMaxY := theCoordinatesXY at: 2] 
				ifFalse: [theMaxY := theCoordinatesXY at: 4].

		theScroller addChild: (Me5SvgLine new
			x1: (theCoordinatesXY at: 1) + (theGameWidth * 0.75);
			y1: (theCoordinatesXY at: 2) + (theGameHeight * 0.5);
			x2: (theCoordinatesXY at: 3) + (theGameWidth * 0.25);
			y2: (theCoordinatesXY at: 4) + (theGameHeight * 0.5);
			strokeWidth: 5;
			stroke: 'lightGrey';
			svgHeight: theMaxY * 2;
			svgWidth: theMaxX * 2;
			svgTop: 0;
			svgLeft: 0;
			yourself).].].

	^theResultDiv
]

{ #category : 'Accessing' }
SpecificTournamentView >> gameID [

	"<^iOf String>"
	"Answer the gameID of the receiver"

	^gameID
]

{ #category : 'Accessing' }
SpecificTournamentView >> gameID: aString [

	"<aString: iOf String, ^self>"
	"Set the gameID of the receiver"

	gameID := aString
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournament [

	"<^iOf Object>"
	"Answer the tournament of the receiver"

	^tournament
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournament: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the tournament of the receiver"

	tournament := anObject
]
