Class {
	#name : 'TournamentTab',
	#superclass : 'Me5Div',
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
	#category : 'TurnierplanerApp'
}

{ #category : 'Not categorized' }
TournamentTab >> createComponents [

	| thePlayers |
	
	thePlayers := OrderedCollection new.
	1 to: self players size do: [
		:eachIndex |
		| eachPlayer |
		eachPlayer := self players at: eachIndex.
		thePlayers add: eachPlayer firstName, ' ', eachPlayer lastName.
	].
	self createTournamentRows.
	
	self textFieldTournamentName: (Me5TextField new
		text: 'Tournier Name';
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
		addFocusEventSelector: #resetPlayers:;
		yourself).
	self divTournamentCreation: (Me5Div new
		addCssClassCol6;
		addChild: (Me5Form new
			addChildToBody: self textFieldTournamentName;
			addChildToBody: self radioGroupTournamentType;
			addChildToBody: self radioGroupGameMode;
			addChildToBody: self multiComboBoxRivals;
			addChildToBody: (Me5Button newPrimary
				text: 'Turnier Erstellen';
				addClickEventSelector: #newTournamentClicked eventReceiver: self;
				yourself);
			yourself);
		yourself).
	
	(self 
		addChild: (Me5H1 new text: 'Turniere');
		addChild: (Me5Hr new);
		addChild: (Me5Accordion new
			addChild: (Me5AccordionItem new
				icon: Me5I newFasEdit;
				title: 'Turnier erstellen';
				addChildToContent: self divTournamentCreation;
				yourself);
			yourself);
		addChild: self rowTournaments;
		yourself)
]

{ #category : 'Not categorized' }
TournamentTab >> createTournamentRows [
	
	self rowTournaments: Me5Row new.
	1 to: (self tournaments size) do: [
		:index | 
		| currentTournament |
		currentTournament := (self tournaments at: index).
		self rowTournaments addChild: (Me5Div new
			addChild: (Me5Portlet newPrimary
				title: currentTournament name;
				addChildToHeadTools: (Me5A newIconOnlyPrimary
					icon: Me5I newFasTrash;
					addClickEventSelector: #yesNoModalRemoveTournament: eventReceiver: self;
					yourself);
				addChildToBody: (Me5P new
					text: ((currentTournament tournamentType) asString, ' / ', (currentTournament gameMode) asString );
					fontSize: 'medium';
					yourself);
				addChildToBody: (Me5P new 
					text: ('Rivalen: ', '-' );
					fontSize: 'large';
					yourself);
				addChildToBody: (Me5A newPrimary
					setTargetBlank;
					rightIcon: Me5I newFasAngleRight;
					text: 'Zum Turnier';
					href: ('TurnierplanerView/specificTournament?tournamentName=dasErsteTurnier %1&team=true' bindWith: (currentTournament name));
					yourself);
				addChildToFoot:  (Me5ProgressBar newPrimary
					value: ((currentTournament numberOfPlayedGames asInteger) / (currentTournament numberOfGames asInteger) * 100) asInteger;
					height: 20;
					setPrimaryStyle;
					yourself);
				addChildToFoot: (Me5P new
					text: (currentTournament numberOfPlayedGames asString), ' von ', (currentTournament numberOfGames asString);
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
	].
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> divTournamentCreation [

	^divTournamentCreation
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> divTournamentCreation: anObject [

	divTournamentCreation := anObject
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> multiComboBoxRivals [

	^multiComboBoxRivals
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> multiComboBoxRivals: anObject [

	multiComboBoxRivals := anObject
]

{ #category : 'Not categorized' }
TournamentTab >> newTournamentClicked [

	| thePlayerAsStringCollection currentTournament theTournamentType theTournamentTypeAsString theGames thePlayerOrTeamCollection|
	
	thePlayerAsStringCollection := OrderedCollection new..
	thePlayerOrTeamCollection := OrderedCollection new.
	
	1 to: (self multiComboBoxRivals value size) do: [
		:eachIndex |
		| thePlayerName thePlayer |
		thePlayerName := self multiComboBoxRivals value at: eachIndex.
		thePlayer := self players detect: [
			:player |
			player firstName, ' ', player lastName = thePlayerName
		] 
		ifNone: [].
		thePlayerOrTeamCollection add: thePlayer.
		thePlayerAsStringCollection add: thePlayer firstName.
	].
	.
	theTournamentTypeAsString := self radioGroupTournamentType value.
	theTournamentTypeAsString = 'KO'
	ifTrue: [
		theTournamentType := KO new.
	].
	theTournamentTypeAsString = 'Runden'
	ifTrue: [
		theTournamentType := Laps new.
	].
	theTournamentTypeAsString = 'Mixed'
	ifTrue: [
		theTournamentType := Mixed new.
	].
	self radioGroupGameMode value = 'Einzel'
	ifTrue: [
		theGames := theTournamentType getCollectionOfGamesWithPlayers: thePlayerOrTeamCollection.
	]
	ifFalse: [
		theGames := theTournamentType getCollectionOfGamesWithPlayers: thePlayerOrTeamCollection.
	].
	
	
	currentTournament := (Tournament new
		name: self textFieldTournamentName value;
		tournamentType: theTournamentType;
		gameMode: self radioGroupGameMode value;
		numberOfGames: theGames size;
		numberOfPlayedGames: 0;
		games: theGames;
		yourself).
	
	self rowTournaments addChild: (Me5Div new
			addChild: (Me5Portlet newPrimary
				addChildToHeadTools: (Me5A newIconOnlyPrimary
					icon: Me5I newFasTrash;
					addClickEventSelector: #yesNoModalRemoveTournament: eventReceiver: self;
					yourself);
				title: currentTournament name;
				addChildToBody: (Me5P new
					text: (theTournamentTypeAsString, ' / ', currentTournament gameMode );
					fontSize: 'medium';
					yourself);
				addChildToBody: (Me5P new 
					text: ('Rivalen: ', (thePlayerAsStringCollection joinUsing:  ', '));
					fontSize: 'large';
					yourself);
				addChildToBody: (Me5A newPrimary
					setTargetBlank;
					"showForMdAndBiggerDevices;"
					rightIcon: Me5I newFasAngleRight;
					text: 'Zum Turnier';
					href: ('TurnierplanerView/specificTournament?tournamentName=dasErsteTurnier%1&team=true', currentTournament name);
					yourself);
				addChildToFoot:  (Me5ProgressBar newPrimary
					value: ((currentTournament numberOfPlayedGames asInteger) / (currentTournament numberOfGames asInteger) * 100) asInteger;
					height: 20;
					setPrimaryStyle;
					yourself);
				addChildToFoot: (Me5P new
					text: (currentTournament numberOfPlayedGames asString), ' von ', (currentTournament numberOfGames asString);
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
				
				
		self tournaments add: currentTournament.
		
		"self startUp saveObject: (self tournaments) onPath:  'C:\TournamentPlanner\Memory\tournaments.dat'."
]

{ #category : 'Accessing' }
TournamentTab >> players [

	^players
]

{ #category : 'Accessing' }
TournamentTab >> players: anObject [

	players := anObject
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> radioGroupGameMode [

	^radioGroupGameMode
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> radioGroupGameMode: anObject [

	radioGroupGameMode := anObject
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> radioGroupTournamentType [

	^radioGroupTournamentType
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> radioGroupTournamentType: anObject [

	radioGroupTournamentType := anObject
]

{ #category : 'Not categorized' }
TournamentTab >> removeTournament [
	
	| theDivTournament |
	theDivTournament := self removeTournamentEvent component parent parent parent parent parent parent.
	theDivTournament parent removeChild:  theDivTournament
	ifAbsent: [].
"
	self view showSuccessNotificationWithMessage: ('Turnier gelÃ¶scht')"
]

{ #category : 'Accessing' }
TournamentTab >> removeTournamentEvent [

	"<^iOf Object>"
	"Answer the removeTournamentEvent of the receiver"

	^removeTournamentEvent
]

{ #category : 'Accessing' }
TournamentTab >> removeTournamentEvent: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the removeTournamentEvent of the receiver"

	removeTournamentEvent := anObject
]

{ #category : 'Not categorized' }
TournamentTab >> resetPlayers: aCollectionOfPlayers [

	| thePlayers |
	
	self players: aCollectionOfPlayers.
	
	self divTournamentCreation children first children first removeChild: (self multiComboBoxRivals)
	ifAbsent: [].
	
	thePlayers := OrderedCollection new.
	1 to: self players size do: [
		:eachIndex |
		| eachPlayer |
		eachPlayer := self players at: eachIndex.
		thePlayers add: eachPlayer firstName, ' ', eachPlayer lastName.
	].
	
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
TournamentTab >> rowTournaments [

	^rowTournaments
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> rowTournaments: anObject [

	rowTournaments := anObject
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> textFieldTournamentName [

	^textFieldTournamentName
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TournamentTab >> textFieldTournamentName: anObject [

	textFieldTournamentName := anObject
]

{ #category : 'Accessing' }
TournamentTab >> tournaments [

	^tournaments
]

{ #category : 'Accessing' }
TournamentTab >> tournaments: anObject [

	tournaments := anObject
]

{ #category : 'Not categorized' }
TournamentTab >> yesNoModalRemoveTournament: aMe5Event [

	
	self removeTournamentEvent: aMe5Event.
	self view showYesNoDialogWithTitle: 'Turnier l&ouml;schen?' message: '' yesSelector: #removeTournament

	
]
