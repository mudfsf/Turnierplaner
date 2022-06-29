Class {
	#name : 'DashboardView',
	#superclass : 'Me5BaseView',
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
DashboardView >> createComponents [

	"<^self>"

	| theDashboardDiv theCurrentTournamentText theCurrentMatchText thePlayersCurrentTournamentText theRemainingGamesInTournamentText theCurrentPlayerText theRemainingGamesForThePlayerText 
	thePlayerMoneyText theWageredMoneyText theTournamentProgressBar thePlayerProgressBar theNeededTournament theNeededPlayer theListOfGamesFromNeededPlayer theListOfGamesFromNeededPlayerPlayed 
	theCollectionOfNotPlayedGamesFromNeededPlayer theIndexOfThePlayersTournament theNeededMember theCollectionOfIncompletedTournaments theSumOfBettedMoney |

	theNeededPlayer := TournamentPlannerApp loggedInUser.
	theNeededMember := theNeededPlayer.
	theIndexOfThePlayersTournament := TournamentPlannerApp collectionOfTournaments data findFirst: [ :eachTournament |
		(eachTournament memberCollection first isMemberOf: Team)
			ifTrue: [ 
				theNeededMember := eachTournament memberCollection at: (eachTournament memberCollection findFirst: [ :eachTeam | 
					(eachTeam members findFirst: [ :eachPlayer | eachPlayer asString = theNeededPlayer asString ]) ~= 0]) ifAbsent: [Team new]]
			ifFalse: [theNeededMember := theNeededPlayer].
		eachTournament games size ~= eachTournament playedGames size and: [(eachTournament memberCollection findFirst: [ :eachMember |
			eachMember asString = theNeededMember asString]) ~= 0]].
	theTournamentProgressBar := 0. 
	thePlayerProgressBar := 0.
	(TournamentPlannerApp collectionOfTournaments data isEmpty or: [ theIndexOfThePlayersTournament = 0 ])
		ifTrue: [ 
			theCurrentTournamentText := Me5H5 new text: ('Turnier: -').
			theCurrentMatchText := Me5H5 new text: ('Spiel: -').
			thePlayersCurrentTournamentText := Me5H5 new text: ('Turnier: -'). 
			theRemainingGamesInTournamentText := Me5H6 new text: ('&Uuml;brige Spiele: -').
			theRemainingGamesForThePlayerText := theRemainingGamesInTournamentText.
			theCurrentPlayerText := Me5H5 new text: ('Spieler: -').
			theListOfGamesFromNeededPlayer := 1. 
			theListOfGamesFromNeededPlayerPlayed := 1]
		ifFalse: [ 		
			theNeededTournament := TournamentPlannerApp collectionOfTournaments data at: theIndexOfThePlayersTournament.			
			theCurrentTournamentText := Me5H5 new text: ('Turnier: %1' bindWith: theNeededTournament name). 			
			thePlayersCurrentTournamentText := Me5H5 new text: ('Turnier: %1' bindWith: theNeededTournament name). 
			theRemainingGamesInTournamentText := Me5H6 new text: ('&Uuml;brige Spiele: %1' bindWith: (theNeededTournament games size - theNeededTournament playedGames size)).
			theCurrentPlayerText := Me5H5 new text: ('Spieler: %1' bindWith: theNeededPlayer asString).
			theListOfGamesFromNeededPlayer := theNeededTournament games select: [ :eachGame | 
				((eachGame memberCollection at: 1 ifAbsent: ['']) asString = theNeededMember asString ) or: [(eachGame memberCollection at: 2 ifAbsent: [''])  asString = theNeededMember asString ] ]. 
			theListOfGamesFromNeededPlayerPlayed := theNeededTournament playedGames select: [ :eachGame | 
				(eachGame memberCollection first asString = theNeededMember asString ) or: [ eachGame memberCollection last asString = theNeededMember asString ] ].
			theNeededTournament games size ~= 0
				ifTrue: [theTournamentProgressBar := 100 * theNeededTournament playedGames size / theNeededTournament games size].
			theListOfGamesFromNeededPlayer size ~= 0
				ifTrue: [thePlayerProgressBar := 100 * theListOfGamesFromNeededPlayerPlayed size / theListOfGamesFromNeededPlayer size].
			theRemainingGamesForThePlayerText := Me5H6 new text: ('&Uuml;brige Spiele: %1' bindWith: theListOfGamesFromNeededPlayer size - theListOfGamesFromNeededPlayerPlayed size ) .
			theListOfGamesFromNeededPlayerPlayed isEmpty
				ifTrue: [theCurrentMatchText := Me5H5 new text: ('Spiel: %1' bindWith: theListOfGamesFromNeededPlayer first name)] 
				ifFalse: [		
					theCollectionOfNotPlayedGamesFromNeededPlayer := theListOfGamesFromNeededPlayer select: [ :eachGame |
						(theListOfGamesFromNeededPlayerPlayed findFirst: [ :eachPlayedGame | eachPlayedGame name = eachGame name]) = 0].							
					theCollectionOfNotPlayedGamesFromNeededPlayer isEmpty
						ifTrue: [theCurrentMatchText := Me5H5 new text: ('Spiel: -')] 
						ifFalse: [theCurrentMatchText := Me5H5 new text: ('Spiel: %1' bindWith: theCollectionOfNotPlayedGamesFromNeededPlayer first name)]]].
	thePlayerMoneyText := Me5H5 new text: ('Guthaben: %1&euro;' bindWith: theNeededPlayer money).
	theCollectionOfIncompletedTournaments := TournamentPlannerApp collectionOfTournaments data select: [ :eachTournament |
		eachTournament games size ~= eachTournament playedGames size].	
	theSumOfBettedMoney := 0.
	theCollectionOfIncompletedTournaments do: [ :eachTournament |	
		eachTournament games do: [ :eachGame |
			eachGame resultCollection ifEmpty: [
				eachGame betCollection ifNotEmptyAndNotNil: [
					eachGame betCollection do: [ :eachBet |
						(eachBet bettor asString = theNeededPlayer asString) 
							ifTrue: [theSumOfBettedMoney := theSumOfBettedMoney + eachBet stake]]]]]].		
	theWageredMoneyText := Me5H5 new text: ('%1&euro;' bindWith: theSumOfBettedMoney).
	theDashboardDiv := (Me5Div new
		addChild: (Me5H2 newWithText: 'HR-Works Turnierplaner');
		addChild: (Me5Portlet new
			addChildToBody: (Me5H3 new text: 'N&auml;chstes Spiel f&uuml;r dich');
			addChildToBody: Me5Hr new;
			addChildToBody: theCurrentTournamentText;
			addChildToBody: theCurrentMatchText;
			yourself);		
		addChild: (Me5Portlet new
			addChildToBody: (Me5H3 new text: 'Laufende Turniere');
			addChildToBody: Me5Hr new;
			addChildToBody: thePlayersCurrentTournamentText;
			addChildToBody: theRemainingGamesInTournamentText;
			addChildToBody: (Me5ProgressBar newPrimary
				addCssClassMProgressLg;
				value: theTournamentProgressBar;
				yourself);
			addChildToBody: Me5Hr new;									
			addChildToBody: theCurrentPlayerText;
			addChildToBody: theRemainingGamesForThePlayerText;
			addChildToBody: (Me5ProgressBar newPrimary
				addCssClassMProgressLg;
				value: thePlayerProgressBar;
				yourself);
			yourself);
		addChild: (Me5Portlet new
			addChildToBody: (Me5H3 new text: 'Wetten');
			addChildToBody: Me5Hr new;
			addChildToBody: thePlayerMoneyText;
			addChildToBody: Me5Hr new;									
			addChildToBody: (Me5H5 new text: 'Laufende Wetten');
			addChildToBody: theWageredMoneyText;
			addChildToBody: (self createScrollerBetsForPlayer: theNeededPlayer);
			yourself);
		yourself).		
	self 
		addChild: (Me5H1 new
			addCssClassTextCenter;
			text: 'Dashboard';
			yourself);
		addChild: Me5Hr new;
		addChild: theDashboardDiv;
		yourself
]

{ #category : 'Initial-Events' }
DashboardView >> createScrollerBetsForPlayer: aPlayer [
	
	| theReturnDiv theScroller theBetPortlets |
	
	theReturnDiv := (Me5Div new
		addCssClassCol12;
		overflow: 'hidden';
		addChild: (theScroller := Me5Scroller new
			setWhiteSpaceToNoWrap;
			yourself);
		yourself).
	
	theBetPortlets := OrderedCollection new.
		
	TournamentPlannerApp collectionOfTournaments data do: [:eachTournament |
		eachTournament games do: [:eachGame |
			eachGame betCollection ifNotNil: [
				eachGame betCollection do: [:eachBet |
					eachBet bettor = aPlayer ifTrue: [
						theScroller addChild: (Me5Portlet new
							display: 'inline-block';
							margin: 10;
							title: (eachBet result asString);
							addChildToBody: (Me5H5 newWithText: ('Turnier: %1' bindWith: eachTournament name));
							addChildToBody: (Me5H5 newWithText: (('Spiel: %1' bindWith: eachGame name) 
								clwReplaceSubString: (eachBet guess asString) with: ('<<%1>>' bindWith: eachBet guess asString)));
							addChildToBody: (Me5H5 newWithText: ('Einsatz: %1&euro;' bindWith: eachBet stake));
							yourself)]]]]].
	
	theScroller children do: [:eachPortlet |
		| theResultNumber |
		theResultNumber := eachPortlet title asInteger.
		theResultNumber negative ifTrue: [
			eachPortlet title: ((eachPortlet title asNumber abs) asString, '&euro; Verloren').
			eachPortlet setDangerStyle] 
			ifFalse: [
				theResultNumber isZero ifTrue: [
					eachPortlet title: 'Spiel ausstehend'] 
					ifFalse: [
						eachPortlet title: (eachPortlet title, '&euro; Gewonnen').
						eachPortlet setSuccessStyle]]].
	
	^theScroller
]
