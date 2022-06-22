Class {
	#name : 'ManageTournamentsView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'tournaments',
		'rowTournaments',
		'divTournamentCreation',
		'multiComboBoxRivals',
		'textFieldTournamentName',
		'radioGroupTournamentType',
		'radioGroupGameMode',
		'removeTournamentEvent',
		'members'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
ManageTournamentsView >> beforeCreateComponents [

	"<^self>"
	"This method is called before #createComponents.
	 Sets players and tournaments."

	TournamentPlannerApp collectionOfPlayers observerCollection add: self.
	TournamentPlannerApp collectionOfTeams observerCollection add: self.
	self members: TournamentPlannerApp collectionOfPlayers data.
	self tournaments: TournamentPlannerApp collectionOfTournaments data
]

{ #category : 'Initial-Events' }
ManageTournamentsView >> createComponents [

	"<^self>"

	| thePlayers |
	
	thePlayers := OrderedCollection new.
	self members do: [:eachPlayer |
		thePlayers add: eachPlayer asString].
	self createTournamentRows.
	self divTournamentCreation: (Me5Div new
		addCssClassCol6;
		addChild: self createMe5Form;
		yourself).
	self addChild: (Me5H1 new 
			addCssClassTextCenter;
			text: 'Turniere');
		addChild: Me5Hr new;
		addChild: (Me5Accordion new
			addChild: (Me5AccordionItem new
				icon: Me5I newFasEdit;
				title: 'Turnier erstellen';
				addChildToContent: self divTournamentCreation;
				yourself);
			yourself);
		addChild: self rowTournaments;
		yourself
]

{ #category : 'Initial-Events' }
ManageTournamentsView >> createMe5Form [
	
	"<^self>"
	
	self textFieldTournamentName: (Me5TextField new
		text: 'Turniername';
		yourself).
	self radioGroupTournamentType: (Me5RadioGroup new
		text: 'Turnierart';
		addObjects: #('KO' 'Runden' 'Mixed');
		selectObject: 'KO';
		yourself).
	self radioGroupGameMode: (Me5RadioGroup new
		text: 'Spielmodus';
		addObjects: #('Einzel' 'Team');
		selectObject: 'Einzel';
		addChangeEventSelector: #createRivalsMultiComboBox eventReceiver: self;
		yourself).
	self multiComboBoxRivals: (Me5Select2MultiSelectBox new
		text: 'Rivalen';
		objects: (self getMemberCollection collect: [ :eachPlayer | 
			eachPlayer asString])
		yourself).
			
	^Me5Form new
		addChildToBody: self textFieldTournamentName;
		addChildToBody: self radioGroupTournamentType;
		addChildToBody: self radioGroupGameMode;
		addChildToBody: self multiComboBoxRivals;
		addChildToBody: (Me5Button newSuccess
			icon: Me5I newFasSave;
			text: 'Speichern';
			addClickEventSelector: #createTournament eventReceiver: self;
			yourself);
		yourself
]

{ #category : 'Events' }
ManageTournamentsView >> createRivalsMultiComboBox [

	"<^self>"
	"creates and fills rivalsMultiComboBox"

	| theMembers |
	
	self divTournamentCreation children first children first removeChild: (self multiComboBoxRivals) ifAbsent: [].
	self multiComboBoxRivals: (Me5Select2MultiSelectBox new 
		text: 'Rivalen').
	theMembers := OrderedCollection new.
	self getMemberCollection do: [ :eachPlayer | 
		theMembers add: eachPlayer asString].
	self multiComboBoxRivals objects: theMembers.
	self divTournamentCreation children first 
		children first addChild: self multiComboBoxRivals 
			after: self radioGroupGameMode
]

{ #category : 'Events' }
ManageTournamentsView >> createTournament [

	"<^self>"
	"creates and saves Tournament"

	| theSelectedCollection theCollection theExistingTournament theSelectedAsStringCollection theTournamentType theTournamentTypeAsString theGames theCurrentTournament |
	
	 self textFieldTournamentName clearErrorText.
	 self multiComboBoxRivals clearErrorText.
	 
	 self textFieldTournamentName value = ''
		ifTrue: [self textFieldTournamentName setErrorText: 'Turnier hat keinen Namen'].
	self multiComboBoxRivals selectedObjects size < 2
		ifTrue: [self multiComboBoxRivals setErrorText: 'Turnier hat zu wenig Mitspieler'].

	theSelectedAsStringCollection := OrderedCollection new.
	theSelectedCollection := OrderedCollection new.	
	theExistingTournament := self tournaments detect: [ :eachTournament |
		eachTournament name = self textFieldTournamentName value] ifNone: [nil].
	theExistingTournament 
		ifNotNil: [
			self textFieldTournamentName setErrorText: 'Das Turnier exisitert bereits'].
	self radioGroupGameMode value = 'Einzel'
		ifTrue: [theCollection := TournamentPlannerApp collectionOfPlayers data].
	self radioGroupGameMode value = 'Team'
		ifTrue: [theCollection := TournamentPlannerApp collectionOfTeams data].
	theTournamentTypeAsString := self radioGroupTournamentType value.
	theTournamentTypeAsString = 'KO'
		ifTrue: [theTournamentType := KOTournamentType new].
	theTournamentTypeAsString = 'Runden'
		ifTrue: [theTournamentType := LapsTournamentType new].
	theTournamentTypeAsString = 'Mixed'
		ifTrue: [theTournamentType := MixedTournamentType new].			
	self multiComboBoxRivals value do: [ :eachSelectable |
		| theSelected |
		theSelected := theCollection detect: [ :member |
			member asString = eachSelectable] ifNone: [].
		theSelectedCollection add: theSelected.
		theSelectedAsStringCollection add: theSelected asString].
	(theTournamentType class = MixedTournamentType and: [theSelectedCollection size < 4])
		ifTrue: [			
			self multiComboBoxRivals clearErrorText.
			self multiComboBoxRivals setErrorText: 'Turnier hat zu wenig Mitspieler'].
	(self multiComboBoxRivals hasErrorStyle or: [ self textFieldTournamentName hasErrorStyle])
		ifTrue: [^self].
	theGames := theTournamentType getCollectionOfGamesWithMembers: theSelectedCollection.
	theCurrentTournament := (Tournament new
		name: self textFieldTournamentName value;
		tournamentType: theTournamentType;
		gameMode: self radioGroupGameMode value;
		games: theGames;
		playedGames: (theGames select: [ :eachGame |
			eachGame isBuyBoolean]);
		membercollection: theSelectedCollection;
		yourself).
	self rowTournaments addChild: (self createTournamentDivWithTournament: theCurrentTournament 
		WithTournamenType: theTournamentTypeAsString
		WithMembers: theSelectedAsStringCollection).
	self tournaments add: theCurrentTournament.
	TournamentPlannerApp saveCollectionOfTournaments: self tournaments.
	self textFieldTournamentName value: ''.
	self multiComboBoxRivals deselectAllObjects.
	self showSuccessNotificationWithMessage: ('Turnier %1 wurde erstellt!' bindWith: theCurrentTournament asString)
]

{ #category : 'Internal' }
ManageTournamentsView >> createTournamentDivWithTournament: aTournament WithTournamenType: aString WithMembers: aCollection [

	"<aTournament: iOf Tournament, aString: hOf String, aCollection: hOf Collection: {hOf String}, ^Me5Div>"
	"Answer a Me5Div representing Tournament"

	^Me5Div new
		padding: 15;
		addCssClassColSm12;
		addCssClassColMd6;
		addCssClassColXl4;
		addChild: (Me5Portlet newPrimary
			title: aTournament name;
			addChildToHeadTools: (Me5A newIconOnlyPrimary
				icon: Me5I newFasTrash;
				addClickEventSelector: #yesNoModalRemoveTournament: eventReceiver: self;
				yourself);
			addChildToBody: (Me5P new
				text: ('%1 / %2' bindWith: aString with: aTournament gameMode);
				fontSize: 'medium';
				yourself);
			addChildToBody: (Me5P new 
				text: ('Rivalen: %1' bindWith: ((aCollection select: [ :eachMember | eachMember notNil ]) joinUsing:  ', '));
				fontSize: 'large';
				yourself);
			addChildToBody: (Me5A newPrimary
				setTargetBlank;
				rightIcon: Me5I newFasAngleRight;
				text: 'Zum Turnier';
				href: ('TurnierplanerView/specificTournament?tournamentName=%1&tournamentType=%2' bindWith: aTournament name with: aString);
				yourself);
			addChildToFoot:  (Me5ProgressBar newPrimary
				value: ((aTournament playedGames size 
					/ aTournament games size)*100) asInteger;
				height: 20;
				setPrimaryStyle;
				yourself);
			addChildToFoot: (Me5P new
				text: ('%1 von %2' bindWith: aTournament playedGames size asString with: aTournament games size asString);
				textAlign: 'center';
				fontSize: 'larger';
				yourself);
			setTargetBlank;
			subTitle: (self winnerOfTournament: aTournament);
			yourself);
		yourself
]

{ #category : 'Initial-Events' }
ManageTournamentsView >> createTournamentRows [
	
	"<^self>"
	"Creates Rows of Tournaments"
	
	self rowTournaments: Me5Row new.
	self tournaments do: [	:eachTournament | 
		| theMembers theTournamentType |
		(eachTournament tournamentType isKindOf: KOTournamentType)
			ifTrue: [theTournamentType := 'KO'].
		(eachTournament tournamentType isKindOf: LapsTournamentType)
			ifTrue: [theTournamentType := 'Runden'].
		(eachTournament tournamentType isKindOf: MixedTournamentType)
			ifTrue: [theTournamentType := 'Mixed'].
		theMembers := OrderedCollection new.
		eachTournament membercollection do: [ :eachMember |
			theMembers add: eachMember asString].			
		self rowTournaments addChild: (self createTournamentDivWithTournament: eachTournament
			WithTournamenType: theTournamentType WithMembers: theMembers)]
]

{ #category : 'Accessing' }
ManageTournamentsView >> divTournamentCreation [

	"<^iOf Me5Div>"
	"Answer the divTournamentCreation of the receiver"

	^divTournamentCreation
]

{ #category : 'Accessing' }
ManageTournamentsView >> divTournamentCreation: aDiv [

	"<aDiv: iOf Me5Div, ^self>"
	"Set the divTournamentCreation of the receiver"

	divTournamentCreation := aDiv
]

{ #category : 'Internal' }
ManageTournamentsView >> getMemberCollection [

	"<^hOf Collection: {iOf Member}>"
	"Answer Collection of Member depending on GameMode"
	
	self radioGroupGameMode value = 'Einzel'
		ifTrue: [^TournamentPlannerApp collectionOfPlayers data].
	self radioGroupGameMode value = 'Team'
		ifTrue: [^TournamentPlannerApp collectionOfTeams data].
	^OrderedCollection new
]

{ #category : 'Accessing' }
ManageTournamentsView >> members [

	"<^hOf Collection of: {iOf Member}>"
	"Answer the players of the receiver"

	^members
]

{ #category : 'Accessing' }
ManageTournamentsView >> members: aMemberCollection [

	"<aMemberCollection: hOf Collection of: {iOf Member}, ^self>"
	"Set the players of the receiver"

	members := aMemberCollection
]

{ #category : 'Accessing' }
ManageTournamentsView >> multiComboBoxRivals [

	"<^iOf Me5MultiComboBox>"
	"Answer the multiComboBoxRivals of the receiver"

	^multiComboBoxRivals
]

{ #category : 'Accessing' }
ManageTournamentsView >> multiComboBoxRivals: aMultiComboBox [

	"<aMultiComboBox: iOf Me5MultiComboBox, ^self>"
	"Set the multiComboBoxRivals of the receiver"

	multiComboBoxRivals := aMultiComboBox
]

{ #category : 'Accessing' }
ManageTournamentsView >> radioGroupGameMode [

	"<^iOf Me5RadioGroup>"
	"Answer the radioGroupGameMode of the receiver"

	^radioGroupGameMode
]

{ #category : 'Accessing' }
ManageTournamentsView >> radioGroupGameMode: aRadioGroup [

	"<aRadioGroup: iOf Me5RadioGroup, ^self>"
	"Set the radioGroupGameMode of the receiver"

	radioGroupGameMode := aRadioGroup
]

{ #category : 'Accessing' }
ManageTournamentsView >> radioGroupTournamentType [

	"<^iOf Me5RadioGroup>"
	"Answer the radioGroupTournamentType of the receiver"

	^radioGroupTournamentType
]

{ #category : 'Accessing' }
ManageTournamentsView >> radioGroupTournamentType: aMe5RadioGroup [

	"<aMe5RadioGroup: iOf Me5RadioGroup, ^self>"
	"Set the radioGroupTournamentType of the receiver"

	radioGroupTournamentType := aMe5RadioGroup
]

{ #category : 'Events' }
ManageTournamentsView >> removeTournament: aMe5DialogEvent [

	"<^self>"
	"removes and saves Tournament"
	
	| theDivTournament theTournament theTournamentExistsBoolean|
	
	theTournamentExistsBoolean := true.
	theDivTournament := aMe5DialogEvent originalEvent component parent parent parent parent parent parent.	
	theDivTournament parent removeChild: theDivTournament ifAbsent: [].
	theTournament := self tournaments detect: [ :eachTournament |
		eachTournament name = theDivTournament children first title]
		ifNone: [
			self showErrorNotificationWithMessage: 'Turnier exisistiert nicht mehr...'.
			theTournamentExistsBoolean := false].
	theTournamentExistsBoolean
		ifTrue: [
			self tournaments remove: theTournament ifAbsent: [].
			TournamentPlannerApp saveCollectionOfTournaments: self tournaments.
			self showSuccessNotificationWithMessage: ('Turnier mit dem Namen %1 gel&ouml;scht' 
				bindWith: theTournament name)]
]

{ #category : 'API' }
ManageTournamentsView >> resetData [
	
	"<^self>"
	"refreshes all data sources and rebuilds affected classes"
	
	self members: TournamentPlannerApp collectionOfPlayers data.
	self tournaments: TournamentPlannerApp collectionOfTournaments data.
	"self createRivalsMultiComboBox"
]

{ #category : 'Accessing' }
ManageTournamentsView >> rowTournaments [

	"<^iOf Me5Row>"
	"Answer the rowTournaments of the receiver"

	^rowTournaments
]

{ #category : 'Accessing' }
ManageTournamentsView >> rowTournaments: aMe5Row [

	"<aMe5Row: iOf Me5Row, ^self>"
	"Set the rowTournaments of the receiver"

	rowTournaments := aMe5Row
]

{ #category : 'Accessing' }
ManageTournamentsView >> textFieldTournamentName [

	"<^iOf Me5TextField>"
	"Answer the textFieldTournamentName of the receiver"

	^textFieldTournamentName
]

{ #category : 'Accessing' }
ManageTournamentsView >> textFieldTournamentName: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the textFieldTournamentName of the receiver"

	textFieldTournamentName := aMe5TextField
]

{ #category : 'Accessing' }
ManageTournamentsView >> tournaments [

	"<^hOf Collection of: {iOf Tournament}>"
	"Answer the tournaments of the receiver"

	^tournaments
]

{ #category : 'Accessing' }
ManageTournamentsView >> tournaments: aTournamentCollection [

	"<aTournamentCollection: hOf Collection of: {iOf Tournament}, ^self>"
	"Set the tournaments of the receiver"

	tournaments := aTournamentCollection
]

{ #category : 'Internal' }
ManageTournamentsView >> winnerOfTournament: aTournament [

	"<^self>"
	"returns the winner of a tournament"

	| theWinner theWinnerDictionary theMaxWins |
	
	aTournament playedGames size = aTournament games size 
		ifTrue: [
			theMaxWins := 0.
			aTournament tournamentType class = LapsTournamentType 
				ifTrue: [
					theWinnerDictionary := Dictionary new.
					aTournament playedGames do: [ :eachPlayedGame |
						| winnerOfGame |
						winnerOfGame := eachPlayedGame resultCollection first player asString.
						(theWinnerDictionary at: winnerOfGame ifAbsentPut: 0) 
							ifNotNil: [
								theWinnerDictionary at: winnerOfGame put: (theWinnerDictionary at: winnerOfGame) asInteger + 1].
						theMaxWins < (theWinnerDictionary at: winnerOfGame) asInteger
							ifTrue: [
								theMaxWins := (theWinnerDictionary at: winnerOfGame) asInteger.
								theWinner := 'Sieger: ', winnerOfGame]]]
				ifFalse: [
					theWinner := 'Sieger: ', (aTournament playedGames last resultCollection first player asString)].
		].
	^theWinner.
]

{ #category : 'Events' }
ManageTournamentsView >> yesNoModalRemoveTournament: aMe5Event [

	"<^self>"
	"confirmation to delete Tournament"

	self showYesNoDialogWithTitle: 'Turnier l&ouml;schen?' message: '' yesSelector: #removeTournament:
]
