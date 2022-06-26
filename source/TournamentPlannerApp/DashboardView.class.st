Class {
	#name : 'DashboardView',
	#superclass : 'Me5BaseView',
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
DashboardView >> createComponents [

	"<^self>"

	| theDashboard theTextNextGame theTextActualTournament theTextActualMatch theTextRunningTournaments theTextBestTeamNowInTheTournament theTextTeamMatchesInTheTournament 	theTextBestPlayerNowInTheTournament theTextPlayerMatchesInTheTournament 
	theTextForBets theTextWithWageredMoney theTextForRunningBets theTextWithWageredMoneyForTheBets progressBarTournament progressBarPlayer theNeededTournament theNeededPlayer theListofGamesfromNeededPlayer theListofGamesfromNeededPlayerPlayed 
	theCollectionOfNotPlayedGamesFromNeededPlayer theIndexOfFirstUncompletedTournament theIndexOfThePlayersTournament theNeededMember theCollectionOfIncompletedTournaments theSumOfBettedMoney |

	theNeededPlayer := TournamentPlannerApp loggedInUser.
	theNeededMember := theNeededPlayer.
	theIndexOfFirstUncompletedTournament := TournamentPlannerApp collectionOfTournaments data findFirst: [ :eachTournament |
		eachTournament games size ~= eachTournament playedGames size].
	theIndexOfThePlayersTournament := TournamentPlannerApp collectionOfTournaments data findFirst: [ :eachTournament |
		(eachTournament memberCollection first isMemberOf: Team)
			ifTrue: [ 
				theNeededMember := eachTournament memberCollection detect: [ :eachTeam | 
					(eachTeam members findFirst: [ :eachPlayer | eachPlayer asString = theNeededPlayer asString ]) ~= 0]].
		eachTournament games size ~= eachTournament playedGames size and: [ eachTournament memberCollection includes: theNeededMember] ].
	progressBarTournament := 0. 
	progressBarPlayer := 0.
	(TournamentPlannerApp collectionOfTournaments data isEmpty or: [ theIndexOfThePlayersTournament = 0 ])
		ifTrue: [ 
			theTextActualTournament := Me5H5 new text: ('Turnier: -').
			theTextActualMatch := Me5H5 new text: ('Spiel: -').
			theTextBestTeamNowInTheTournament := Me5H5 new text: ('Turnier: -'). 
			theTextTeamMatchesInTheTournament := Me5H6 new text: ('&Uuml;brige Spiele: -').
			theTextPlayerMatchesInTheTournament := theTextTeamMatchesInTheTournament.
			theTextBestPlayerNowInTheTournament := Me5H5 new text: ('Spieler: -').
			theListofGamesfromNeededPlayer := 1. 
			theListofGamesfromNeededPlayerPlayed := 1]
		ifFalse: [ 		
			theNeededTournament := TournamentPlannerApp collectionOfTournaments data at: theIndexOfThePlayersTournament.			
			theTextActualTournament := Me5H5 new text: ('Turnier: %1' bindWith: theNeededTournament name). 			
			theTextBestTeamNowInTheTournament := Me5H5 new text: ('Turnier: %1' bindWith: theNeededTournament name). 
			theTextTeamMatchesInTheTournament := Me5H6 new text: ('&Uuml;brige Spiele: %1' bindWith: (theNeededTournament games size - theNeededTournament playedGames size)).
			theTextBestPlayerNowInTheTournament := Me5H5 new text: ('Spieler: %1' bindWith: theNeededMember asString).
			theListofGamesfromNeededPlayer := theNeededTournament games select: [ :eachGame | 
				((eachGame memberCollection at: 1 ifAbsent: ['']) asString = theNeededMember asString ) or: [(eachGame memberCollection at: 2 ifAbsent: [''])  asString = theNeededMember asString ] ]. 
			theListofGamesfromNeededPlayerPlayed := theNeededTournament playedGames select: [ :eachGame | 
				(eachGame memberCollection first asString = theNeededMember asString ) or: [ eachGame memberCollection last asString = theNeededMember asString ] ].
			theNeededTournament games size ~= 0
				ifTrue: [progressBarTournament := 100 * theNeededTournament playedGames size / theNeededTournament games size].
			theListofGamesfromNeededPlayer size ~= 0
				ifTrue: [progressBarPlayer := 100 * theListofGamesfromNeededPlayerPlayed size / theListofGamesfromNeededPlayer size].
			theTextPlayerMatchesInTheTournament := Me5H6 new text: ('&Uuml;brige Spiele: %1' bindWith: theListofGamesfromNeededPlayer size - theListofGamesfromNeededPlayerPlayed size ) .
			theListofGamesfromNeededPlayerPlayed isEmpty
				ifTrue: [theTextActualMatch := Me5H5 new text: ('Spiel: %1' bindWith: theListofGamesfromNeededPlayer first name)] 
				ifFalse: [		
					theCollectionOfNotPlayedGamesFromNeededPlayer := theListofGamesfromNeededPlayer select: [ :eachGame |
						(theListofGamesfromNeededPlayerPlayed findFirst: [ :eachPlayedGame | eachPlayedGame name = eachGame name]) = 0].							
					theCollectionOfNotPlayedGamesFromNeededPlayer isEmpty
						ifTrue: [theTextActualMatch := Me5H5 new text: ('Spiel: -')] 
						ifFalse: [theTextActualMatch := Me5H5 new text: ('Spiel: %1' bindWith: theCollectionOfNotPlayedGamesFromNeededPlayer first name)]]].			
	theTextNextGame := Me5H3 new text: 'N&auml;chstes Spiel f&uuml;r dich'.
	theTextRunningTournaments := Me5H3 new text: 'Laufende Turniere'.	
	theTextForBets := Me5H3 new text: 'Wetten'.		"ToDo: connect to implemented Bets."
	theTextWithWageredMoney := Me5H5 new text: ('%1&euro;' bindWith: theNeededPlayer money).
	theTextForRunningBets := Me5H5 new text: 'Laufende Wetten'.	
	theCollectionOfIncompletedTournaments := TournamentPlannerApp collectionOfTournaments data select: [ :eachTournament |
		eachTournament games size ~= eachTournament playedGames size].	
	theSumOfBettedMoney := 0.
	theCollectionOfIncompletedTournaments do: [ :eachTournament |	
		eachTournament games do: [ :eachGame |
			eachGame betCollection isNil
				ifFalse: [
					eachGame betCollection do: [ :eachBet |
						(eachBet bettor asString = theNeededPlayer asString) 
							ifTrue: [theSumOfBettedMoney := theSumOfBettedMoney + eachBet stake]]]]].		
	theTextWithWageredMoneyForTheBets := Me5H5 new text: ('%1&euro;' bindWith: theSumOfBettedMoney).
	theDashboard := (Me5Div new
		addChild: (Me5H2 newWithText: 'HR-Works Turnierplaner');
		addChild: (Me5Portlet new
			addChildToBody: theTextNextGame;
			addChildToBody: Me5Hr new;
			addChildToBody: theTextActualTournament;
			addChildToBody: theTextActualMatch;
			yourself);		
		addChild: (Me5Portlet new
			addChildToBody: theTextRunningTournaments;
			addChildToBody: Me5Hr new;
			addChildToBody: theTextBestTeamNowInTheTournament;
			addChildToBody: theTextTeamMatchesInTheTournament;
			addChildToBody: (Me5ProgressBar newPrimary
				addCssClassMProgressLg;
				value: progressBarTournament;
				yourself);
			addChildToBody: Me5Hr new;									
			addChildToBody: theTextBestPlayerNowInTheTournament;
			addChildToBody: theTextPlayerMatchesInTheTournament;
			addChildToBody: (Me5ProgressBar newPrimary
				addCssClassMProgressLg;
				value: progressBarPlayer;
				yourself);
			yourself);
		addChild: (Me5Portlet new
			addChildToBody: theTextForBets;
			addChildToBody: Me5Hr new;
			addChildToBody: theTextWithWageredMoney;
			addChildToBody: Me5Hr new;									
			addChildToBody: theTextForRunningBets;
			addChildToBody: theTextWithWageredMoneyForTheBets;
			addChildToBody: (self createScrollerBetsForPlayer: theNeededPlayer);
			yourself);
		yourself).
		
	self 
		addChild: (Me5H1 new
			addCssClassTextCenter;
			text: 'Dashboard';
			yourself);
		addChild: Me5Hr new;
		addChild: theDashboard;
		yourself
]

{ #category : 'Initial-Events' }
DashboardView >> createScrollerBetsForPlayer: aPlayer [
	
	| theScroller theScrollerRow theBetPortlets |
	
	theScroller := (Me5Scroller new
		suppressScrollY: true;
		suppressScrollX: false;
		setWhiteSpaceToNoWrap;
		addChild: (theScrollerRow := Me5Row new
			margin: 10;
			yourself);
		yourself).
		
	theBetPortlets := OrderedCollection new.
		
	TournamentPlannerApp collectionOfTournaments data do: [:eachTournament |
		eachTournament games do: [:eachGame |
			eachGame betCollection ifNotNil: [
				eachGame betCollection do: [:eachBet |
					eachBet bettor = aPlayer ifTrue: [
						theScrollerRow addChild: (Me5Portlet new
							title: 'Titel';
							margin: 10;
							title: (eachBet result asString);
							addChildToBody: (Me5H5 newWithText: ('Turnier: %1' bindWith: eachTournament name));
							addChildToBody: (Me5H5 newWithText: ('Spiel: %1' bindWith: eachGame name));
							addChildToBody: (Me5H5 newWithText: ('Einsatz: %1&euro;' bindWith: eachBet stake));
							"addChildToFoot: (Me5H5 newWithText: ('Gewonnen x verloren x: %1' bindWith: eachTournament name));"
							yourself)]]]]].
	
	theScrollerRow children do: [:eachPortlet |
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
