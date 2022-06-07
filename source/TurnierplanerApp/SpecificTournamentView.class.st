Class {
	#name : 'SpecificTournamentView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'theGameID'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Initial-Events' }
SpecificTournamentView >> createComponents [

	| theQueryParameters |

	theQueryParameters := self queryParameters.

	super createModules.


	self 
		addChild: (Me5H1 new
			text: 'Specific Tournament';
			yourself
		);

		addChild: (Me5H3 new
			text: (theQueryParameters at: 'tournamentName'); 
			yourself);

		addChild: self theSpecificTournament;


		yourself.
]

{ #category : 'Not categorized' }
SpecificTournamentView >> openModalSetWinner [

	self openModal: Me5MetronicExampleSmallSizeModalModalView new
]

{ #category : 'Accessing' }
SpecificTournamentView >> theGameID [

	"<^hOf Number>"
	"Answer the theGameID of the receiver"

	^theGameID
]

{ #category : 'Accessing' }
SpecificTournamentView >> theGameID: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the theGameID of the receiver"

	theGameID := aNumber
]

{ #category : 'Not categorized' }
SpecificTournamentView >> theSpecificTournament [

| theSvgLine theResultDiv theScroller theNumberOfGames theGamesinColumn theOffsetX theOffsetY theGameWidth theGameHeight theRowsSpacing theColumnSpacing theGameHeightAndSpacing theCoordinatesLineArray theNumberOfColumn |

theNumberOfGames := 8.
theGamesinColumn := theNumberOfGames.
theOffsetX := 10.
theOffsetY := 10.
theGameWidth := 400.
theGameHeight := 260.
theRowsSpacing := 20.
theColumnSpacing := 100.
theGameHeightAndSpacing := theGameHeight + theRowsSpacing.
theNumberOfColumn := ((theNumberOfGames log: 2) + 1) asInteger.
theCoordinatesLineArray := Array new: theNumberOfColumn.
"{ spalte { reihe { x1 y1 x2 y2 } reihe {...} reihe {...} reihe {...} } spalte {...} spalte {...} }"

theResultDiv := Me5Div new.

theResultDiv addChild: (Me5H1 newWithText: 'Beispielansicht Turnier').
theResultDiv addChild: (theScroller := Me5Scroller new
	height: 2 * theNumberOfGames * theGameHeightAndSpacing).

1 to: theNumberOfColumn do: [:indexSpalten |
	theCoordinatesLineArray at: indexSpalten put: (Array new: theGamesinColumn).
	1 to: (theGamesinColumn) do: [:indexReihen |
		| theTop theLeft |
		theTop := theOffsetY + ((indexReihen - 1) * theGameHeightAndSpacing).
		theLeft := theOffsetX + ((indexSpalten - 1) * (theGameWidth + theColumnSpacing)).

		"theGameID := (indexSpalten * indexReihen)."

		theScroller addChild: (Me5Portlet newSuccess
			title: 'Gegner 1 VS Gegner 2';
			setPositionToAbsolute;
			zIndex: 1;
			top: theTop;
			left: theLeft;
			width: theGameWidth;
			addChildToBody: (Me5Button newSuccess
				text: 'Ergebnis eintragen';

				addClickEventSelector: #openModalSetWinner;
				yourself);
			addChildToFoot: (Me5Button newSuccess
				text: 'Wetten';
				yourself);
			yourself).
"set line coordinates (1er) x1 y1"
		(theCoordinatesLineArray at: indexSpalten) at: indexReihen put: ((Array new: 4) at: 1 put: theLeft; at: 2 put: theTop; yourself).
		"set line coordinates (2er) x2 y2"
		indexSpalten > 1 ifTrue: [
			((theCoordinatesLineArray at: (indexSpalten - 1)) at: ((indexReihen * 2) - 1)) at: 3 put: theLeft; at: 4 put: theTop; yourself.
			((theCoordinatesLineArray at: (indexSpalten - 1)) at: (indexReihen * 2)) at: 3 put: theLeft; at: 4 put: theTop; yourself.
		].
	].
	theGamesinColumn := theGamesinColumn / 2.
	theOffsetY := theOffsetY + (theGameHeightAndSpacing / 2).
	theGameHeightAndSpacing := theGameHeightAndSpacing * 2.

].

theCoordinatesLineArray size.


"draw Lines"

1 to: (theCoordinatesLineArray size - 1) do: [:theSpalte |
	1 to: ((theCoordinatesLineArray at: theSpalte) size ) do: [:theReihe |

		| theMaxX theMaxY theCoordinatesXY |

		theCoordinatesXY := (theCoordinatesLineArray at: theSpalte) at: theReihe.
		((theCoordinatesXY at: 1) > (theCoordinatesXY at: 3)) ifTrue: [theMaxX := theCoordinatesXY at: 1] ifFalse: [theMaxX := theCoordinatesXY at: 3].
		((theCoordinatesXY at: 2) > (theCoordinatesXY at: 4)) ifTrue: [theMaxY := theCoordinatesXY at: 2] ifFalse: [theMaxY := theCoordinatesXY at: 4].
		theSvgLine := (Me5SvgLine new
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
		yourself).

	theScroller addChild: (theSvgLine).

	].
].


^theResultDiv.
]
