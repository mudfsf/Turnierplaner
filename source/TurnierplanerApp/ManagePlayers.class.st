Class {
	#name : 'ManagePlayers',
	#superclass : 'Me5Div',
	#instVars : [
		'startUp',
		'listGrid',
		'data',
		'placeholder'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Events' }
ManagePlayers >> addPlayerEvent [

	(self data includes: (self placeholder))
	ifFalse: [
		self data add: self placeholder.
	].
	
	self listGrid dataSourceBlock: [ self data	].
	
	self listGrid resetEditedDataGridCells.

	self view showSuccessNotificationWithMessage: ('Added row to save Player...')
]

{ #category : 'Events' }
ManagePlayers >> clearEvent [

	(self data includes: (self placeholder))
	ifTrue: [
		self data remove: self placeholder.
	].
	
	self listGrid dataSourceBlock: [ self data	].
	
	self listGrid resetEditedDataGridCells.

	self view showSuccessNotificationWithMessage: ('Cleared Grid...')
]

{ #category : 'Initial-Events' }
ManagePlayers >> createComponents [

	self startUp: StartUp new.
	
	self listGrid: (Me5ListGrid new
		addCssClassColMd12;
		height: '55vh';
		dataSourceBlock: [self data];
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'Vorname';
			getterSelector: #firstName;
			setterSelector: #firstName:;
			enableHeaderSort;
			minWidth: 200;
			maxWidth:  'vw 40';
			yourself);
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'Nachname';
			getterSelector: #lastName;
			setterSelector: #lastName:;
			enableHeaderSort;
			enableInitialSort;
			minWidth: 200;
			yourself);
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'E-Mail';
			getterSelector: #email;
			setterSelector: #email:;
			enableHeaderSort;
			minWidth: 200;
			maxWidth:  'vw 40';
			yourself);
		addDataGridColumnDefinition: (Me5DataGridComponentsHolderColumnDefinition new
			title: 'Action';
			setHorizontalAlignmentToRight;
			componentsHolderBlock: [ 
				:theDataGridComponentsHolderCell :theDataGridComponentsHoldingParameters |
				theDataGridComponentsHolderCell
				addChild: (Me5Button newDanger
					addCssClassBtnSm;
					icon: Me5I newFarTrash; 
					text: 'L&ouml;schen';
					addClickEventSelector: #deletePlayerEvent: eventReceiver: self;
					yourself);
				yourself];
			yourself);
		yourself).
	
	self addChild: (Me5H1 new text: 'Admin-Tools').
	self addChild: Me5Hr new.
	self addChild: (Me5FormPortlet new
		addCssClassColMd12;
		addChildToBody: (Me5Div new
			addChild: self listGrid;
			yourself); 
		addChildToFootButtonGroup: (Me5Button newSuccess
				icon: Me5I newFasSave; 
				text: 'Speichern';
				addClickEventSelector: #saveEvent eventReceiver: self;
				yourself);
				addChildToFootButtonGroup: (Me5Button newInfo
				icon: Me5I newFasPlus; 
				text: 'Spieler hinzuf&uuml;gen';
				addClickEventSelector: #addPlayerEvent eventReceiver: self;
				yourself);
			addChildToFootButtonGroup: (Me5Button newWarning
				icon: Me5I newFasUndo;
				text: 'Reinigen';
				addClickEventSelector: #clearEvent eventReceiver: self;
				yourself);
		yourself).
		
		self listGrid resetEditedDataGridCells.
		self listGrid resetSortingCache
]

{ #category : 'Accessing' }
ManagePlayers >> data [

	^data
]

{ #category : 'Accessing' }
ManagePlayers >> data: aListOfPlayer [

	data := aListOfPlayer
]

{ #category : 'Events' }
ManagePlayers >> deletePlayerEvent: anEvent [

	| thePlayer isSuccessful|
	isSuccessful := false.
	thePlayer := anEvent dataGridComponentsHolderCellObject.
	
	(self data includes:thePlayer)
	ifTrue: [
		 (self data size > 1)
		 ifTrue: [
			self data remove: thePlayer.
			isSuccessful := true.
		 ].
	].
	
	self listGrid dataSourceBlock: [ self data	].
	
	self startUp saveObject: self data onPath: 'C:\TournamentPlanner\Memory\players.dat'.
	
	self listGrid resetEditedDataGridCells.

	isSuccessful
	ifTrue: [
		self view showSuccessNotificationWithMessage: ('Deleted Player %1 %2...' bindWith: (thePlayer firstName) with: (thePlayer lastName)).
	]
	ifFalse: [
		self view showErrorNotificationWithMessage: ('Can not delete last Player...').
	].
	self view resetTournamentTabWithPlayers: self data

]

{ #category : 'Accessing' }
ManagePlayers >> listGrid [

	^listGrid
]

{ #category : 'Accessing' }
ManagePlayers >> listGrid: anObject [

	listGrid := anObject
]

{ #category : 'Accessing' }
ManagePlayers >> placeholder [

	^Player firstName: '' lastName: '' email: ''
]

{ #category : 'Events' }
ManagePlayers >> saveEvent [

	| theNumberOfEditedDataGridRows thePlayers|

	theNumberOfEditedDataGridRows := self listGrid numberOfEditedDataGridRows.

	self listGrid validateEditedDataGridCellsForBlock: [ :eachEditedDataGridCell | | theFieldName theValue |
		theFieldName := (self listGrid dataGridColumnDefinitions at: eachEditedDataGridCell field asNumber) title lowercaseFirstCharacter.
		theValue := eachEditedDataGridCell value.
		theValue isEmptyOrNil
		ifTrue: [
			(theFieldName at: 1) isVowel
			ifFalse: [ eachEditedDataGridCell errorText: 'Please enter a ', theFieldName]
			ifTrue: [ eachEditedDataGridCell errorText: 'Please enter an ', theFieldName ].
		].
	].

	self listGrid hasValidationError
		ifTrue: [^self view showErrorNotificationWithMessage: 'Validation failed...'].
	
	self listGrid dataSourceBlock: [ self data	].

	self listGrid editedDataGridRows do: [ :eachEditedDataGridRow |
		eachEditedDataGridRow editedDataGridCells do: [ :eachEditedDataGridCell |
			eachEditedDataGridCell writeValueToObject]].

	self view collectionOfPlayers: self data.
	self startUp saveObject: self data onPath: 'C:\TournamentPlanner\Memory\players.dat'.
		
	self listGrid resetEditedDataGridCells.
	
	self view showSuccessNotificationWithMessage: ('Saved %1 edited row(s)...' bindWith: theNumberOfEditedDataGridRows).
	
	self view collectionOfPlayers: self data.

	self view resetTournamentTabWithPlayers: self data
]

{ #category : 'Accessing' }
ManagePlayers >> startUp [

	^startUp
]

{ #category : 'Accessing' }
ManagePlayers >> startUp: anObject [

	startUp := anObject
]
