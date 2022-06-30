Class {
	#name : 'SpecificTournamentView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'user',
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
		'resultModal',
		'highestRankedMembers',
		'winnerSelectBox',
		'bettedWinnerSelectBox'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
SpecificTournamentView >> beforeCreateComponents [

	"<^self>"

	self offsetX: 40;
		offsetY: 40;
		width: 420;
		height: 220;
		rowsSpacing: 20;
		columnSpacing: 120;
		tournament: (TournamentPlannerApp collectionOfTournaments data detect: [ :eachTournament |
			eachTournament name = (self queryParameters at: 'tournamentName' ifAbsent: [])] 
			ifNone: [^self showErrorNotificationWithMessage: 'Kein Turnier wurde gefunden!']);
		tournamentType: (self queryParameters at: 'tournamentType' ifAbsent: []);
		tournamentDrawingArea: Me5Div new;
		yourself
]

{ #category : 'Accessing' }
SpecificTournamentView >> bettedWinnerSelectBox [

	"<^iOf Me5SelectBox>"
	"Answer the bettedWinnerSelectBox of the receiver"

	^bettedWinnerSelectBox
]

{ #category : 'Accessing' }
SpecificTournamentView >> bettedWinnerSelectBox: aMe5SelectBox [

	"<aMe5SelectBox: iOf Me5SelectBox, ^self>"
	"Set the bettedWinnerSelectBox of the receiver"

	bettedWinnerSelectBox := aMe5SelectBox
]

{ #category : 'Internal' }
SpecificTournamentView >> calculateBetWinnings: aGame withWinner: aWinnerMember [

	"calculates the winnings for each correct bettor and add the winnings to the players money"
	
	| theWageragedMoney theWinningBets theWinningBetsSize theMoneyForBettors |
	
	theWageragedMoney := 0.
	theWinningBets := OrderedCollection new.
	
	self game betCollection ifNotNil: [
		self game betCollection do: [:eachBet |
		theWageragedMoney := theWageragedMoney + eachBet stake.
		eachBet guess = aWinnerMember
			ifTrue: [
				theWinningBets add: eachBet]
			ifFalse: [
				eachBet result: (eachBet stake) * (-1)]]].
	theWinningBetsSize := theWinningBets size.
	theWinningBetsSize > 0 ifTrue: [
		theMoneyForBettors := ((theWageragedMoney / theWinningBetsSize) - 
			((theWageragedMoney modulo: theWinningBetsSize) / theWinningBetsSize)).
		theWinningBets do: [:eachWinningBet |
			eachWinningBet bettor money: eachWinningBet bettor money + theMoneyForBettors.
			eachWinningBet result: theMoneyForBettors]]
	
]

{ #category : 'Events' }
SpecificTournamentView >> calculateTotalStake: aGame [

	"Add up all Bets for every member and return as Array"
	
	| addUpStake returnArray firstMember secondMember |
	
	returnArray := Array new: 4.
	firstMember := aGame memberCollection first.
	secondMember := aGame memberCollection second.
	addUpStake := 0.
	
	aGame betCollection ifNotNil: [
		|  betsFirstMember betsSecondMember |
		betsFirstMember := aGame betCollection select: [:eachBet |
			eachBet guess = firstMember].
		betsSecondMember := aGame betCollection select: [:eachBet |
			eachBet guess = secondMember].
		
		betsFirstMember do: [:eachBet |
			addUpStake := addUpStake + (eachBet stake)].
		returnArray at: 1 put: firstMember asString.
		returnArray at: 2 put: addUpStake.
		
		addUpStake := 0.
		betsSecondMember do: [:eachBet |
			addUpStake := addUpStake + (eachBet stake)].
		returnArray at: 3 put: secondMember asString.
		returnArray at: 4 put: addUpStake] 
	ifNil: [
		returnArray at: 1 put: firstMember asString.
		returnArray at: 2 put: 0.
		returnArray at: 3 put: secondMember asString.
		returnArray at: 4 put: 0
	].
	
	^returnArray
]

{ #category : 'Events' }
SpecificTournamentView >> closeTab [

	Bs4JavaScriptTranscript addJavaScript: ('window.close();')
]

{ #category : 'Accessing' }
SpecificTournamentView >> columnSpacing [

	"<^hOf Number>"
	"Answer the columnSpacing of the receiver"

	^columnSpacing
]

{ #category : 'Accessing' }
SpecificTournamentView >> columnSpacing: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the columnSpacing of the receiver"

	columnSpacing := aNumber
]

{ #category : 'Initial-Events' }
SpecificTournamentView >> createComponents [

	"<^self>"
	
	| theValidTypeStrings |
	
	theValidTypeStrings := OrderedCollection  new
		add: 'KO';
		add: 'Mixed';
		add: 'Runden';
		yourself.
	self tournament isNil
		ifTrue: [
			self createErrorViewWithTitle: 'Kein Turnier gefunden'.			
			^self].
	(self tournamentType isEmptyOrNil or: [(theValidTypeStrings includes: self tournamentType) not]) 
		ifTrue: [
			self createErrorViewWithTitle: 'Falscher Turniertyp'.			
			^self].
	(self tournament tournamentType asString ~= self tournamentType )
		ifTrue: [
			self createErrorViewWithTitle: 'Turnier und Turniertyp passen nicht zusammen'.
			^self].	
	self addChild: (Me5H1 new
			addCssClassTextCenter;
			text: self tournament name;
			yourself);
		addChild: Me5Hr new;
		yourself.
	self setDrawingArea
]

{ #category : 'Internal' }
SpecificTournamentView >> createErrorViewWithTitle: aTitle [
	
	"<^self>"
		
	self addChild: (Me5H1 newWithText: aTitle).
	self addChild: (Me5H2 newWithText: 'Bitte Tab schlie&szlig;en, und &uuml;ber die Hauptseite das Turnier &ouml;ffnen!').
	self addChild: (Me5Button newDanger
		text: 'Tab schlie&szlig;en';
		addClickEventSelector: #closeTab;
		yourself).
	^self
	
]

{ #category : 'Internal' }
SpecificTournamentView >> createKOTournament: canInitialGamesBePlayedBoolean [

	"<^iOf Me5Div>"
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
				| theTop theLeft theResultButton theBetButton thePortlet |
				
				eachLayer = 1
					ifTrue: [theTop := eachIndex - 1 * (self height + self rowsSpacing) + self offsetY].
				theLeft := self offsetX + (eachLayer - 1 * (self width + self columnSpacing)).

				thePortlet := (Me5Portlet newSuccess
					title: eachGame name;
					setPositionToAbsolute;
					zIndex: 1;
					width: self width;
					addChildToBody: (Me5Div new
						display: 'flex';
						justifyContent: 'space-around';
						addChild: (theResultButton := Me5Button newSuccess
							addCssClassCol6;
							componentObject: eachGame name;
							icon: Me5I newFasSave;
							text: 'Ergebnis eintragen';
							addClickEventSelector: #setKOResultEvent:;
							yourself);
						addChild: (theBetButton := Me5Button newSuccess
							addCssClassCol5;
							componentObject: eachGame name;
							text: 'Wetten';
							icon: Me5I newFasMoneyBill;
							addClickEventSelector: #setKOBetEvent:;
							yourself);
						yourself);
					yourself).
				
				canInitialGamesBePlayedBoolean
					ifFalse: [theResultButton disable].
					
				eachGame resultCollection size > 0 
					ifTrue: [
						thePortlet subTitle: ('Sieger: %1' bindWith: eachGame resultCollection first player asString).
						theResultButton disable.
						theBetButton disable].
					
				eachLayer > 1
					ifTrue: [
						| theIndex theMember1 theMember2 |
						
						theMember1 := '- '.
						theMember2 := ' - '.
						
						theIndex := eachLayer * (eachLayer - 1) * eachIndex + theNumberOfLaps.
						theTop := ((theLines at: theIndex - 1 - theNumberOfLaps) at: 1) y + ((theLines at: theIndex - theNumberOfLaps) at: 1) y / 2.
						
						eachGame memberCollection removeAll.
					
						(self tournament games at: (theIndex - 1)) resultCollection isEmptyOrNil
							ifFalse: [
								theMember1 := (self tournament games at: theIndex - 1) resultCollection first player asString.
								eachGame memberCollection add: (self tournament games at: theIndex - 1) resultCollection first player].	
						(self tournament games at: theIndex) resultCollection isEmptyOrNil
							ifFalse: [
								theMember2 := (self tournament games at: theIndex) resultCollection first player asString.
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
						((self tournament games at: theIndex - 1) resultCollection size > 0 
						and: [(self tournament games at: theIndex) resultCollection size > 0])
							ifFalse: [
								theResultButton disable.
								theBetButton disable]].
							
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

	"<^iOf Me5Div>"
	"creates the View of the Lapstournament."
	
	| theTableOfRanking theSortedCollection theMemberWinLoseCollection |
	
	theTableOfRanking := Me5Table new.
	theTableOfRanking
		addChildToHead: (Me5TableRow new
			addTableHeaderWithText: 'Platzierung';
			addTableHeaderWithText: 'Spieler';
			addTableHeaderWithText: 'Siege';
			addTableHeaderWithText: 'Niederlagen';
			yourself).
	
	theMemberWinLoseCollection := OrderedCollection new.	
	self tournament memberCollection do: [ :eachMember | 
		| theWins theLoses theSizeOfPlayedGames |
		theSizeOfPlayedGames := (self tournament playedGames select: [ :eachGame | 
				(eachGame memberCollection first asString = eachMember asString ) or: [ eachGame memberCollection last asString = eachMember asString ] ]) size.
	
		theWins := (self tournament playedGames select: [ :eachGame |
					(eachGame resultCollection first player asString = eachMember asString)]) size.
		theLoses := theSizeOfPlayedGames - theWins.
		
		theMemberWinLoseCollection add: (OrderedCollection new
			add: eachMember;
			add: theWins;
			add: theLoses;
			yourself)].
		
	theSortedCollection := theMemberWinLoseCollection asSortedCollection: [ :collection1 :collection2 |
		(collection1 at: 2) = (collection2 at: 2)
			ifTrue: [(collection1 at: 3) < (collection2 at: 3)]
			ifFalse: [(collection1 at: 2) > (collection2 at: 2)]].
	
	self tournamentType = 'Mixed'
		ifTrue: [self highestRankedMembers: (theSortedCollection first: 4)].
	
	theSortedCollection doWithIndex: [ :eachCollection :eachIndex |
		theTableOfRanking addChildToBody: (Me5TableRow new
			addTableDataWithText: eachIndex;
			addTableDataWithText: (eachCollection at: 1) asString;
			addTableDataWithText: (eachCollection at: 2) asString;
			addTableDataWithText: (eachCollection at: 3) asString;
			yourself)].
	
	^Me5Div new
		addChild: (Me5Portlet new
			icon: Me5I newFasTable;
			title: 'Auszutragende Spiele';
			addChildToBody: (Me5AutoLoadingTable new
				disableShowInfoTableRow;
				objects: (self tournament games select: [ :eachGame | 
					eachGame layer = 0]);
				addTableRowClickedEventSelector: #showDecisionResultBetEvent: ;
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

	"<^iOf Me5Div>"
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

	"<^iOf Boolean>"
	
	^(self tournament games select: [ :eachGame |
		eachGame layer = 0]) conform: [ :eachGame | 
			eachGame resultCollection notEmptyAndNotNil]
]

{ #category : 'Accessing' }
SpecificTournamentView >> height [

	"<^hOf Number>"
	"Answer the height of the receiver"

	^height
]

{ #category : 'Accessing' }
SpecificTournamentView >> height: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the height of the receiver"

	height := aNumber
]

{ #category : 'Accessing' }
SpecificTournamentView >> highestRankedMembers [

	"<^hOf Collection of: {iOf Member}>"
	"Answer the highestRankedMembers of the receiver"

	^highestRankedMembers
]

{ #category : 'Accessing' }
SpecificTournamentView >> highestRankedMembers: aCollection [

	"<aCollection: hOf Collection of: {iOf Member}, ^self>"
	"Set the highestRankedMembers of the receiver"

	highestRankedMembers := aCollection
]

{ #category : 'Accessing' }
SpecificTournamentView >> offsetX [

	"<^hOf Number>"
	"Answer the offsetX of the receiver"

	^offsetX
]

{ #category : 'Accessing' }
SpecificTournamentView >> offsetX: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the offsetX of the receiver"

	offsetX := aNumber
]

{ #category : 'Accessing' }
SpecificTournamentView >> offsetY [

	"<^hOf Number>"
	"Answer the offsetY of the receiver"

	^offsetY
]

{ #category : 'Accessing' }
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

{ #category : 'Accessing' }
SpecificTournamentView >> rowsSpacing [

	"<^hOf Number>"
	"Answer the rowsSpacing of the receiver"

	^rowsSpacing
]

{ #category : 'Accessing' }
SpecificTournamentView >> rowsSpacing: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the rowsSpacing of the receiver"

	rowsSpacing := aNumber
]

{ #category : 'Events' }
SpecificTournamentView >> saveBetEvent: anEvent [

	
	| theMemberName theWinnerMember theStake theOwnBet |
	
	self game resultCollection size = 1
		ifTrue: [^self].
	theMemberName := self bettedWinnerSelectBox value.
	(theMemberName = 'Kein Sieger festgelegt' or: [theMemberName isEmptyOrNil])
		ifTrue: [self showErrorNotificationWithMessage: 'Bitte Sieger ausw&auml;hlen'.
			^self].
	theWinnerMember := self game memberCollection detect: [:eachMember |
		eachMember asString = theMemberName] ifNone: [].
	theStake := anEvent component componentObject value asInteger.
	self user money < theStake 
		ifTrue: [self showErrorNotificationWithMessage: 'Du hast nicht genug Geld'.
			^self].	
	self game betCollection ifEmptyOrNil: [self game betCollection: OrderedCollection new].
	theOwnBet := self game betCollection detect: [:eachBet |
		eachBet bettor = self user] ifNone: [].
	theOwnBet ifNotNil: [
		(self game betCollection includes: theOwnBet)
		ifTrue: [
			self game betCollection remove: theOwnBet.
			self user money: (self user money - (theStake - theOwnBet stake))]]
	ifNil: [
		self user money: (self user money - theStake)].
	theStake > 0 ifTrue: [
		self game betCollection add: (Bet new
			bettor: self user;
			guess: theWinnerMember;
			stake: theStake asInteger;
			yourself)].
	theStake < 0 ifTrue: [theStake := 0].		
	TournamentPlannerApp saveCollectionOfPlayers: TournamentPlannerApp collectionOfPlayers data.
	TournamentPlannerApp saveCollectionOfTournaments: TournamentPlannerApp collectionOfTournaments data.
	self resultModal closeModal.
	self showSuccessNotificationWithMessage: ('Wette auf %1 wurde gespeichert' bindWith: theMemberName)
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
	(self tournamentType = 'Mixed' and: [self haveLapsBeenPlayed])
		ifTrue:[
			| theNumberOfLaps theGame |
			
			theNumberOfLaps := (self tournament games select: [ :eachGame |
				eachGame layer = 0
				]) size.
			theGame := (self tournament games at: (theNumberOfLaps + 1)). 
			theGame memberCollection removeAll.
			theGame memberCollection add: ((highestRankedMembers at: 1) at: 1).
			theGame memberCollection add: ((highestRankedMembers at: 2) at: 1).
			theGame name: ('%1 vs %2' bindWith: (theGame memberCollection at: 1) asString with: (theGame memberCollection at: 2) asString).
			theGame := (self tournament games at: (theNumberOfLaps + 2)). 
			theGame memberCollection removeAll.
			theGame memberCollection add: ((highestRankedMembers at: 3) at: 1).
			theGame memberCollection add: ((highestRankedMembers at: 4) at: 1).
			theGame name: ('%1 vs %2' bindWith: (theGame memberCollection at: 1) asString with: (theGame memberCollection at: 2) asString).].
		
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
	theMemberName := self winnerSelectBox value.
	(theMemberName = 'Kein Sieger festgelegt' or: [theMemberName isEmptyOrNil])
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
	self calculateBetWinnings: self game withWinner: theWinnerMember.
	self tournament playedGames remove: self game ifAbsent: [].
	self tournament playedGames add: self game.
	TournamentPlannerApp saveCollectionOfTournaments: TournamentPlannerApp collectionOfTournaments data.
	self showSuccessNotificationWithMessage: ('Sieger %1 wird gespeichert' bindWith: theMemberName)
]

{ #category : 'Accessing' }
SpecificTournamentView >> selectBoxPlayers [

	"<^iOf Me5SelectBox>"
	"Answer the selectBoxPlayers of the receiver"

	^selectBoxPlayers
]

{ #category : 'Accessing' }
SpecificTournamentView >> selectBoxPlayers: aMe5SelectBox [

	"<aMe5SelectBox: iOf Me5SelectBox, ^self>"
	"Set the selectBoxPlayers of the receiver"

	selectBoxPlayers := aMe5SelectBox
]

{ #category : 'Events' }
SpecificTournamentView >> setBetEvent [

	"<^self>"
	"wip"	
	
	| theSaveButton theSelectBox theIntegerField theOwnBet theCurrentStakes |
	
	self user: TournamentPlannerApp loggedInUser.
	theCurrentStakes := self calculateTotalStake: self game.
	
	self resultModal: (ModalView new title: 'Wetten').
	
	self resultModal body: (Me5Form new
		addChildToBody: (Me5H5 new
			text: ('Guthaben von %1: %2' bindWith: self user asString with: self user money);
			yourself);
		addChildToBody: (theSelectBox := Me5SelectBox new
			text: 'Sieger';
			noneObject: 'Kein Sieger festgelegt';
			objects: (self game memberCollection collect: [ :eachMember | 
				eachMember asString]);
			yourself);
		addChildToBody: (theIntegerField := Me5IntegerField new
			text: 'Einsatz (in &euro;)';
			yourself);
		addChildToBody: (Me5Div new
			display: 'flex';
			justifyContent: 'space-around';
			addChild: (Me5P newWithText: (theCurrentStakes at: 1));
			addChild: (Me5P newWithText: (theCurrentStakes at: 3));
			yourself);
		addChildToBody: (Me5Div new
			display: 'flex';
			justifyContent: 'space-around';
			addChild: (Me5H4 newWithText: ('%1&euro;' bindWith: (theCurrentStakes at: 2)));
			addChild: (Me5H4 newWithText: ('%1&euro;' bindWith: (theCurrentStakes at: 4)));
			yourself);
		yourself).
	self bettedWinnerSelectBox: theSelectBox.	
	theSaveButton := (Me5Button newPrimary
		text: 'Speichern';
		addClickEventSelector: #saveBetEvent: eventReceiver: self;
		icon: Me5I newFasSave;
		componentObject: theIntegerField;
		yourself).
	self resultModal foot: (Me5PortletFoot new
		addChild: theSaveButton).
	
	self game betCollection ifNotNil: [
		theOwnBet := self game betCollection detect: [:eachBet |
			eachBet bettor = self user] ifNone: [].
		theOwnBet ifNotNil: [
			theSelectBox value: theOwnBet guess asString.
			theIntegerField value: theOwnBet stake]].
	
	self openModal: self resultModal
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
SpecificTournamentView >> setKOBetEvent: anEvent [

	"<^self>"
		
	self game: (self tournament games detect: [ :eachGame |
		eachGame name = anEvent component componentObject ] ifNone: []).
	self setBetEvent
]

{ #category : 'Events' }
SpecificTournamentView >> setKOResultEvent: anEvent [

	"<^self>"
		
	self game: (self tournament games detect: [ :eachGame |
		eachGame name = anEvent component componentObject ] ifNone: []).
	self setResultEvent
]

{ #category : 'Events' }
SpecificTournamentView >> setLapsBetEvent: anEvent [

	"<^self>"
		
	
	self setBetEvent
]

{ #category : 'Events' }
SpecificTournamentView >> setLapsResultEvent: anEvent [

	"<^self>"
		
	
	self setResultEvent
]

{ #category : 'Events' }
SpecificTournamentView >> setResultEvent [

	"<^self>"
	"wip"	
	
	| theButton theSelectBox |
		
	self resultModal: (ModalView new title: 'Ergebnis').
	
	self game resultCollection size = 0
		ifTrue: [
			self resultModal body: (Me5Form new
				addChildToBody: (theSelectBox := (Me5SelectBox new
					text: 'Sieger';
					noneObject: 'Kein Sieger festgelegt';
					objects: (self game memberCollection collect: [ :eachMember | 
						eachMember asString]);
					yourself));
				yourself)]
		ifFalse: [
				self resultModal body: (Me5Form new
					addChildToBody: (theSelectBox := (Me5SelectBox new
						text: 'Sieger';
						disableNoneObject;
						objects: (self game resultCollection collect: [ :eachResult | 
							eachResult player asString]);
						yourself));
					yourself)].
	self winnerSelectBox: theSelectBox.
	theButton := Me5Button newPrimary
		text: 'Speichern';
		icon: Me5I newFasSave;
		yourself.
	(self tournamentType = 'KO' or: [self tournamentType = 'Mixed' and: [self haveLapsBeenPlayed]])
		ifTrue: [theButton addClickEventSelector: #saveKOWinnerEvent: eventReceiver: self].
	(self tournamentType = 'Runden' or: [self tournamentType = 'Mixed'  and: [self haveLapsBeenPlayed not]])
		ifTrue: [theButton addClickEventSelector: #saveLapsWinnerEvent: eventReceiver: self].
	self resultModal foot: (Me5PortletFoot new
		addChild: theButton).
		
	self openModal: self resultModal
]

{ #category : 'Events' }
SpecificTournamentView >> showDecisionResultBetEvent: anEvent [

	"<^self>"
	"wip"
	
	| returnTrueFalse |
	
	self game: anEvent loadingTableTableRowObject.
	self game resultCollection isEmptyOrNil
		ifFalse: [^self].
		
	self resultModal: (ModalView new 
		title: 'Ergebnis eintragen oder Wetten?';
		specificTournamentViewView: self;
		event: anEvent;
		yourself).
	
	self resultModal body: (Me5Div new
		addChild: (Me5Button newPrimary
			text: 'Ergebnis eintragen';
			icon: Me5I newFasSave;
			addClickEventSelector: #openSetLapsResultEvent;
			addCssClassCol5;
			yourself);
		addChild: (Me5Button newPrimary
			text: 'Wetten';
			icon: Me5I newFasMoneyBill;
			addClickEventSelector: #openSetLapsBetEvent;
			addCssClassCol5;
			yourself);
		display: 'flex';
		justifyContent: 'space-around';
		yourself).
		
	self openModal: self resultModal.
	
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

	"<^iOf Me5Div>"
	"Answer the tournamentDrawingArea of the receiver"

	^tournamentDrawingArea
]

{ #category : 'Accessing' }
SpecificTournamentView >> tournamentDrawingArea: aDiv [

	"<aDiv: iOf Me5Div, ^self>"
	"Set the tournamentDrawingArea of the receiver"

	tournamentDrawingArea := aDiv
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

{ #category : 'Accessing' }
SpecificTournamentView >> user [

	"<^iOf Player>"
	"Answer the player of the receiver"

	^user
]

{ #category : 'Accessing' }
SpecificTournamentView >> user: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the user of the receiver"

	user := anObject
]

{ #category : 'Accessing' }
SpecificTournamentView >> width [

	"<^hOf Number>"
	"Answer the width of the receiver"

	^width
]

{ #category : 'Accessing' }
SpecificTournamentView >> width: aNumber [

	"<aNumber: hOf Number, ^self>"
	"Set the width of the receiver"

	width := aNumber
]

{ #category : 'Accessing' }
SpecificTournamentView >> winnerSelectBox [

	"<^iOf Me5SelectBox>"
	"Answer the winnerSelectBox of the receiver"

	^winnerSelectBox
]

{ #category : 'Accessing' }
SpecificTournamentView >> winnerSelectBox: aMe5SelectBox [

	"<aMe5SelectBox: iOf Me5SelectBox, ^self>"
	"Set the winnerSelectBox of the receiver"

	winnerSelectBox := aMe5SelectBox
]
