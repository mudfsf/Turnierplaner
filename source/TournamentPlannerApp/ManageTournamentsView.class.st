Class {
	#name : 'ManageTournamentsView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'tournaments',
		'players',
		'rowTournaments',
		'divTournamentCreation',
		'multiComboBoxRivals',
		'textFieldTournamentName',
		'radioGroupTournamentType',
		'radioGroupGameMode',
		'removeTournamentEvent'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
ManageTournamentsView >> beforeCreateComponents [

	"<^self>"
	"This method is called before #createComponents.
	 Sets players and tournaments."

	self players: TournamentPlannerApp collectionOfPlayers.
	self tournaments: TournamentPlannerApp collectionOfTournaments
]

{ #category : 'Initial-Events' }
ManageTournamentsView >> createComponents [

	| thePlayers |
	
	thePlayers := OrderedCollection new.
	self players do: [	:eachPlayer |
		thePlayers add: eachPlayer asString.].
	
	self createTournamentRows.
	
	self textFieldTournamentName: (Me5TextField new
		text: 'Turniername';
		yourself).
	self radioGroupTournamentType: (Me5RadioGroup new
		text: 'Turnierart';
		addObjects: #('KO' 'Runden' 'Mixed');
		yourself).
	self radioGroupGameMode: (Me5RadioGroup new
		text: 'Spielmodus';
		addObjects: #('Einzel' 'Team');
		yourself).
	self multiComboBoxRivals: (Me5Select2MultiSelectBox new
		text: 'Rivalen (muss noch dynamisch werden dass teams oder spieler angezeigt werden k&ouml;nnen)';
		objects: thePlayers;
		yourself).
	self divTournamentCreation: (Me5Div new
		addCssClassCol6;
		addChild: (Me5Form new
			addChildToBody: self textFieldTournamentName;
			addChildToBody: self radioGroupTournamentType;
			addChildToBody: self radioGroupGameMode;
			addChildToBody: self multiComboBoxRivals;
			addChildToBody: (Me5Button newPrimary
				text: 'erstellen';
				addClickEventSelector: #newTournamentClicked eventReceiver: self;
				yourself);
			yourself);
		yourself).
	
	self addChild: (Me5H1 new text: 'Turniere');
		addChild: (Me5Hr new);
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
ManageTournamentsView >> createTournamentRows [
	
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
			
		self rowTournaments addChild: (Me5Div new
			addChild: (Me5Portlet newPrimary
				title: eachTournament name;
				addChildToHeadTools: (Me5A newIconOnlyPrimary
					icon: Me5I newFasTrash;
					addClickEventSelector: #yesNoModalRemoveTournament: eventReceiver: self;
					yourself);
				addChildToBody: (Me5P new
					text: (theTournamentType, ' / ', (eachTournament gameMode) asString );
					fontSize: 'medium';
					yourself);
				addChildToBody: (Me5P new 
					text: ('Rivalen: ', (theMembers joinUsing: ', '));
					fontSize: 'large';
					yourself);
				addChildToBody: (Me5A newPrimary
					setTargetBlank;
					rightIcon: Me5I newFasAngleRight;
					text: 'Zum Turnier';
					href: ('TurnierplanerView/specificTournament?tournamentName=dasErsteTurnier %1&team=true' bindWith: (eachTournament name));
					yourself);
				addChildToFoot:  (Me5ProgressBar newPrimary
					value: ((eachTournament numberOfPlayedGames asInteger) / (eachTournament numberOfGames asInteger) * 100) asInteger;
					height: 20;
					setPrimaryStyle;
					yourself);
				addChildToFoot: (Me5P new
					text: (eachTournament numberOfPlayedGames asString), ' von ', (eachTournament numberOfGames asString);
					textAlign: 'center';
					fontSize: 'larger';
					yourself);
				yourself);
			padding: 15;
			addCssClassColSm12;
			addCssClassColMd6;
			addCssClassColXl4;
		yourself).]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> divTournamentCreation [

	"<^hOf Me5Div>"
	"Answer the divTournamentCreation of the receiver"

	^divTournamentCreation
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> divTournamentCreation: aDiv [

	"<aDiv: hOf Me5Div, ^self>"
	"Set the divTournamentCreation of the receiver"

	divTournamentCreation := aDiv
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> multiComboBoxRivals [

	"<^hOf Me5MultiComboBox>"
	"Answer the multiComboBoxRivals of the receiver"

	^multiComboBoxRivals
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> multiComboBoxRivals: aMultiComboBox [

	"<aMultiComboBox: hOf Me5MultiComboBox, ^self>"
	"Set the multiComboBoxRivals of the receiver"

	multiComboBoxRivals := aMultiComboBox
]

{ #category : 'Events' }
ManageTournamentsView >> newTournamentClicked [

	| theSelectedCollection theExistingTournament theSelectedAsStringCollection theCurrentTournament theTournamentType theTournamentTypeAsString theGames |
	
	theSelectedAsStringCollection := OrderedCollection new..
	theSelectedCollection := OrderedCollection new.
	
	theExistingTournament := self tournaments detect: [ :eachTournament |
		eachTournament name = self textFieldTournamentName value
	] ifNone: [nil].
	
	theExistingTournament 
		ifNil: [
			self multiComboBoxRivals value do: [ :eachSelectable |
				| theSelected |
				theSelected := self players detect: [ :player |
					player firstName, ' ', player lastName = eachSelectable] ifNone: [].
				theSelectedCollection add: theSelected.
				theSelectedAsStringCollection add: theSelected asString.].
	
			theTournamentTypeAsString := self radioGroupTournamentType value.
			theTournamentTypeAsString = 'KO'
				ifTrue: [theTournamentType := KOTournamentType new.].
			theTournamentTypeAsString = 'Runden'
				ifTrue: [theTournamentType := LapsTournamentType new.].
			theTournamentTypeAsString = 'Mixed'
				ifTrue: [theTournamentType := MixedTournamentType new.].
	
			self radioGroupGameMode value = 'Einzel'
				ifTrue: [theGames := theTournamentType getCollectionOfGamesWithPlayers: theSelectedCollection.]
				ifFalse: [theGames := theTournamentType getCollectionOfGamesWithPlayers: theSelectedCollection.].
	
	
			theCurrentTournament := (Tournament new
				name: self textFieldTournamentName value;
				tournamentType: theTournamentType;
				gameMode: self radioGroupGameMode value;
				numberOfGames: theGames size;
				numberOfPlayedGames: 0;
				games: theGames;
				membercollection: theSelectedCollection;
				yourself).
	
			self rowTournaments addChild: (Me5Div new
				addChild: (Me5Portlet newPrimary
					addChildToHeadTools: (Me5A newIconOnlyPrimary
						icon: Me5I newFasTrash;
						addClickEventSelector: #yesNoModalRemoveTournament: eventReceiver: self;
						yourself);
					title: theCurrentTournament name;
					addChildToBody: (Me5P new
						text: theTournamentTypeAsString, ' / ', theCurrentTournament gameMode;
						fontSize: 'medium';
						yourself);
					addChildToBody: (Me5P new 
						text: 'Rivalen: ', (theSelectedAsStringCollection joinUsing:  ', ');
						fontSize: 'large';
						yourself);
					addChildToBody: (Me5A newPrimary
						setTargetBlank;
						rightIcon: Me5I newFasAngleRight;
						text: 'Zum Turnier';
						href: ('TurnierplanerView/specificTournament?tournamentName=dasErsteTurnier%1&team=true', 
							theCurrentTournament name);
						yourself);
					addChildToFoot:  (Me5ProgressBar newPrimary
						value: (theCurrentTournament numberOfPlayedGames 
							/ theCurrentTournament numberOfGames * 100) asInteger;
						height: 20;
						setPrimaryStyle;
						yourself);
					addChildToFoot: (Me5P new
						text: theCurrentTournament numberOfPlayedGames asString, ' von ', theCurrentTournament numberOfGames asString;
						textAlign: 'center';
						fontSize: 'larger';
						yourself);
					setTargetBlank;
					yourself);
				padding: 15;
				addCssClassColSm12;
				addCssClassColMd6;
				addCssClassColXl4;
				yourself).	
				
			self tournaments add: theCurrentTournament.
			TournamentPlannerApp saveCollectionOfTournaments: self tournaments] 
		ifNotNil: [
			self showErrorNotificationWithMessage: ('Das Turnier mit dem Namen %1 exisistiert bereits...'
				bindWith: theExistingTournament name)]
]

{ #category : 'Accessing' }
ManageTournamentsView >> players [

	"<^hOf Collection of: {iOf Player}>"
	"Answer the players of the receiver"

	^players
]

{ #category : 'Accessing' }
ManageTournamentsView >> players: aCollection [

	"<aCollection: hOf Collection of: {iOf Player}, ^self>"
	"Set the players of the receiver"

	players := aCollection
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> radioGroupGameMode [

	"<^hOf Me5RadioGroup>"
	"Answer the radioGroupGameMode of the receiver"

	^radioGroupGameMode
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> radioGroupGameMode: aRadioGroup [

	"<aRadioGroup: hOf Me5RadioGroup, ^self>"
	"Set the radioGroupGameMode of the receiver"

	radioGroupGameMode := aRadioGroup
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> radioGroupTournamentType [

	"<^hOf Me5RadioGroup>"
	"Answer the radioGroupTournamentType of the receiver"

	^radioGroupTournamentType
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> radioGroupTournamentType: aMe5RadioGroup [

	"<aMe5RadioGroup: hOf Me5RadioGroup, ^self>"
	"Set the radioGroupTournamentType of the receiver"

	radioGroupTournamentType := aMe5RadioGroup
]

{ #category : 'Events' }
ManageTournamentsView >> removeTournament: aMe5DialogEvent [
	
	| theDivTournament theTournament |
	
	theDivTournament := aMe5DialogEvent originalEvent component parent parent parent parent parent parent.
	
	theDivTournament parent removeChild: theDivTournament ifAbsent: [].
	theTournament := self tournaments detect: [ :eachTournament |
		eachTournament name = theDivTournament children first title.
	] ifNone: [].
	self tournaments remove: theTournament ifAbsent: [].
	
	TournamentPlannerApp saveCollectionOfTournaments: self tournaments.
	self showSuccessNotificationWithMessage: ('Turnier mit dem Namen %1 gel&ouml;scht' 
		bindWith: theTournament name)
]

{ #category : 'API' }
ManageTournamentsView >> resetPlayers: aCollectionOfPlayers [

	| thePlayers |
	
	self players: aCollectionOfPlayers.
	
	self divTournamentCreation children first children first removeChild: (self multiComboBoxRivals) ifAbsent: [].
	
	thePlayers := OrderedCollection new.
	self players do: [ :eachPlayer |
		thePlayers add: eachPlayer asString.].
	
	self multiComboBoxRivals: (Me5Select2MultiSelectBox new
		text: 'Rivalen (muss noch dynamisch werden dass teams oder spieler angezeigt werden k&ouml;nnen)';
		objects: thePlayers;
		yourself).
		
	self divTournamentCreation children first 
		children first addChild: self multiComboBoxRivals 
			after: self radioGroupGameMode 
	
	
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> rowTournaments [

	"<^hOf Me5Row>"
	"Answer the rowTournaments of the receiver"

	^rowTournaments
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> rowTournaments: aMe5Row [

	"<aMe5Row: hOf Me5Row, ^self>"
	"Set the rowTournaments of the receiver"

	rowTournaments := aMe5Row
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> textFieldTournamentName [

	"<^hOf Me5TextField>"
	"Answer the textFieldTournamentName of the receiver"

	^textFieldTournamentName
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ManageTournamentsView >> textFieldTournamentName: aMe5TextField [

	"<aMe5TextField: hOf Me5TextField, ^self>"
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
ManageTournamentsView >> tournaments: aCollection [

	"<aCollection: hOf Collection of: {iOf Tournament}, ^self>"
	"Set the tournaments of the receiver"

	tournaments := aCollection
]

{ #category : 'Events' }
ManageTournamentsView >> yesNoModalRemoveTournament: aMe5Event [

	self showYesNoDialogWithTitle: 'Turnier l&ouml;schen?' message: '' yesSelector: #removeTournament:

	
]
