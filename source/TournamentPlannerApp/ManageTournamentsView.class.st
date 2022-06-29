Class {
	#name : 'ManageTournamentsView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'rowTournaments',
		'divTournamentCreation',
		'multiComboBoxRivals',
		'textFieldTournamentName',
		'radioGroupTournamentType',
		'radioGroupGameMode',
		'removeTournamentEvent',
		'tournamentToDelete',
		'dictionaryOfTournamentDivs'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
ManageTournamentsView >> createComponents [

	"<^self>"

	| thePlayers |
	
	self dictionaryOfTournamentDivs: Dictionary new.
	thePlayers := OrderedCollection new.
	TournamentPlannerApp collectionOfPlayers data do: [:eachPlayer |
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
		objects: (self getMemberCollection collect: [ :eachMember | 
			eachMember asString])
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
	
	self multiComboBoxRivals removeComponent.
	self multiComboBoxRivals: (Me5Select2MultiSelectBox new 
		text: 'Rivalen';
		yourself).
	theMembers := OrderedCollection new.
	self getMemberCollection do: [ :eachMember | 
		theMembers add: eachMember asString].
	self multiComboBoxRivals objects: theMembers.
	self divTournamentCreation children first 
		children first addChild: self multiComboBoxRivals 
			after: self radioGroupGameMode
]

{ #category : 'Events' }
ManageTournamentsView >> createTournament [

	"<^self>"
	"creates and saves Tournament"

	| theSelectedCollection theCollection theExistingTournament theSelectedAsStringCollection theTournamentType theTournamentTypeAsString theGames theCurrentTournament theTournamentDiv |
	
	 self textFieldTournamentName clearErrorText.
	 self multiComboBoxRivals clearErrorText.
	 
	 self textFieldTournamentName value isEmpty
		ifTrue: [self textFieldTournamentName setErrorText: 'Turnier hat keinen Namen'].
	self multiComboBoxRivals selectedObjects size < 2
		ifTrue: [self multiComboBoxRivals setErrorText: 'Turnier hat zu wenig Mitspieler'].

	theSelectedAsStringCollection := OrderedCollection new.
	theSelectedCollection := OrderedCollection new.	
	theExistingTournament := TournamentPlannerApp collectionOfTournaments data detect: [ :eachTournament |
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
		memberCollection: theSelectedCollection;
		yourself).
	self rowTournaments addChild: (theTournamentDiv := self createTournamentDivWithTournament: theCurrentTournament 
		withTournamenType: theTournamentTypeAsString
		withMembers: theSelectedAsStringCollection).
	TournamentPlannerApp collectionOfTournaments data add: theCurrentTournament.
	self dictionaryOfTournamentDivs add: (Association new 
		key: theCurrentTournament name value: theTournamentDiv).
	TournamentPlannerApp saveCollectionOfTournaments: TournamentPlannerApp collectionOfTournaments data.
	self resetTournamentCreation.
	self showSuccessNotificationWithMessage: ('Turnier %1 wurde erstellt!' bindWith: theCurrentTournament name)
]

{ #category : 'Internal' }
ManageTournamentsView >> createTournamentDivWithTournament: aTournament withTournamenType: aString withMembers: aCollection [

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
				componentObject: aTournament name;
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
	TournamentPlannerApp collectionOfTournaments data do: [ :eachTournament | 
		| theMembers theTournamentDiv theTournamentType |
		(eachTournament tournamentType isKindOf: KOTournamentType)
			ifTrue: [theTournamentType := 'KO'].
		(eachTournament tournamentType isKindOf: LapsTournamentType)
			ifTrue: [theTournamentType := 'Runden'].
		(eachTournament tournamentType isKindOf: MixedTournamentType)
			ifTrue: [theTournamentType := 'Mixed'].
		theMembers := OrderedCollection new.
		eachTournament memberCollection do: [ :eachMember |
			theMembers add: eachMember asString].			
		self rowTournaments addChild: (theTournamentDiv := self createTournamentDivWithTournament: eachTournament
			withTournamenType: theTournamentType withMembers: theMembers).
		self dictionaryOfTournamentDivs add: (Association new
			key: eachTournament name value: theTournamentDiv)]
]

{ #category : 'Accessing' }
ManageTournamentsView >> dictionaryOfTournamentDivs [

	"<^hOf Dictionary: {key: iOf String, value: iOf Me5Div}>"
	"Answer the dictionaryOfTournamentDivs of the receiver"

	^dictionaryOfTournamentDivs
]

{ #category : 'Accessing' }
ManageTournamentsView >> dictionaryOfTournamentDivs: aDictionary [

	"<aDictionary: hOf Dictionary: {key: iOf String, value: iOf Me5Div}, ^self>"
	"Set the dictionaryOfTournamentDivs of the receiver"

	dictionaryOfTournamentDivs := aDictionary
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
	theDivTournament := self dictionaryOfTournamentDivs at: self tournamentToDelete ifAbsent: [^self showErrorNotificationWithMessage: 'Turnier wurde nicht gefunden!'].	
	theDivTournament removeComponent.
	theTournament := TournamentPlannerApp collectionOfTournaments data detect: [ :eachTournament |
		eachTournament name = self tournamentToDelete]
		ifNone: [
			self showErrorNotificationWithMessage: 'Turnier exisistiert nicht mehr...'.
			theTournamentExistsBoolean := false].
	theTournamentExistsBoolean
		ifTrue: [
			TournamentPlannerApp collectionOfTournaments data remove: theTournament ifAbsent: [].
			TournamentPlannerApp saveCollectionOfTournaments: TournamentPlannerApp collectionOfTournaments data.
			self showSuccessNotificationWithMessage: ('Turnier mit dem Namen %1 gel&ouml;scht' 
				bindWith: theTournament name)]
]

{ #category : 'Internal' }
ManageTournamentsView >> resetTournamentCreation [

	"^self"
	"Resets the filled in content of the tournament creation"

	| theSelectedObjects |
	
	self textFieldTournamentName value: ''.
	theSelectedObjects := self multiComboBoxRivals selectedObjects.	
	theSelectedObjects do: [ :eachMember |
		self multiComboBoxRivals deselectObject: eachMember].		
	self radioGroupTournamentType selectObject: 'KO'.
	self radioGroupGameMode selectObject: 'Einzel'.
	self createRivalsMultiComboBox
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
ManageTournamentsView >> tournamentToDelete [

	"<^iOf String>"
	"Answer the tournamentToDelete of the receiver"

	^tournamentToDelete
]

{ #category : 'Accessing' }
ManageTournamentsView >> tournamentToDelete: aString [

	"<aString: iOf String, ^self>"
	"Set the tournamentToDelete of the receiver"

	tournamentToDelete := aString
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
								theMaxWins := (theWinnerDictionary at: winnerOfGame) asInteger]].
					theWinner := (theWinnerDictionary select: [:eachWinner |
						eachWinner = theMaxWins]).
					theWinner := 'Sieger: ', (theWinner keys asArray joinUsing: ', ') asString]
				ifFalse: [
					theWinner := 'Sieger: ', (aTournament playedGames last resultCollection first player asString)]
		].
	^theWinner
]

{ #category : 'Events' }
ManageTournamentsView >> yesNoModalRemoveTournament: aMe5Event [

	"<^self>"
	"confirmation to delete Tournament"
	
	self tournamentToDelete: aMe5Event component componentObject.
	self showYesNoDialogWithTitle: 'Turnier l&ouml;schen?' message: '' yesSelector: #removeTournament:
]
