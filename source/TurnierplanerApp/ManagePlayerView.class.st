Class {
	#name : 'ManagePlayerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'startUp',
		'listGrid',
		'data',
		'placeholder'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Events' }
ManagePlayerView >> AddPlayerEvent [

	(self data includes: (self placeholder))
	ifFalse: [
		self data add: self placeholder.
	].
	
	self listGrid dataSourceBlock: [ self data	].
	
	self listGrid resetEditedDataGridCells.

	self showSuccessNotificationWithMessage: ('Added row to save Player...')
]

{ #category : 'Initial-Events' }
ManagePlayerView >> beforeCreateComponents [

	| thePlayers player|

	"player := OrderedCollection new.
	player add: (Player new
		firstName: 'A';
		lastName:  'B';
		email: 'A@B.com';
		yourself).
	player add: (Player new
		firstName: 'C';
		lastName:  'D';
		email: 'C@D.com';
		yourself)."
		
	self startUp: StartUp new.	
	"self startUp saveObject: player onPath: 'C:\Test\playersV2.dat'."
	
	thePlayers := self startUp loadAnObjectFromPath: 'C:\Test\playersV2.dat'.
	
	"self placeholder:  (Player new
		firstName: '';
		lastName: '';
		email: '';
		yourself).
	thePlayers add: self placeholder."
	self data: thePlayers.
]

{ #category : 'Events' }
ManagePlayerView >> ClearEvent [

	(self data includes: (self placeholder))
	ifTrue: [
		self data remove: self placeholder.
	].
	
	self listGrid dataSourceBlock: [ self data	].
	
	self listGrid resetEditedDataGridCells.

	self showSuccessNotificationWithMessage: ('Cleared Grid...')
]

{ #category : 'Initial-Events' }
ManagePlayerView >> createComponents [
	
	self
		addChild: (Me5FormPortlet new
		addCssClassColMd12;
			addChildToBody: (listGrid := Me5ListGrid new
				addCssClassColMd12;
				height: '60vh';
				dataSourceBlock: [self data];
				addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
					title: 'First name';
					getterSelector: #firstName;
					setterSelector: #firstName:;
					enableHeaderSort;
					minWidth: 200;
					maxWidth:  'vw 40';
					yourself);
				addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
					title: 'Last name';
					getterSelector: #lastName;
					setterSelector: #lastName:;
					enableHeaderSort;
					enableInitialSort;
					minWidth: 200;
					yourself);
				addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
					title: 'Email';
					getterSelector: #email;
					setterSelector: #email:;
					enableHeaderSort;
					minWidth: 200;
					maxWidth:  'vw 40';
					yourself);
				addDataGridColumnDefinition: (Me5DataGridComponentsHolderColumnDefinition new
						title: 'Action';
						setHorizontalAlignmentToRight;
						componentsHolderBlock: [ :theDataGridComponentsHolderCell :theDataGridComponentsHoldingParameters |
							theDataGridComponentsHolderCell
								addChild: (Me5Button newPrimary
									text: 'Loeschen';
									icon: Me5Flaticon newDelete;
									addCssClassBtnSm;
									addClickEventSelector: #deletePlayerEvent:;
									yourself);
								yourself];
						yourself);
					yourself);
			addChildToFootButtonGroup: (Me5Button newSuccess
				icon: Me5I newFasSave; 
				text: 'Speichern';
				addClickEventSelector: #saveEvent;
				yourself);
				addChildToFootButtonGroup: (Me5Button newInfo
				icon: Me5I newFasPlus; 
				text: 'Spieler hinzufuegen';
				addClickEventSelector: #AddPlayerEvent;
				yourself);
			addChildToFootButtonGroup: (Me5Button newWarning
				icon: Me5I newFasUndo;
				text: 'Reinigen';
				addClickEventSelector: #ClearEvent;
				yourself);
			yourself);
		yourself
]

{ #category : 'Initial-Events' }
ManagePlayerView >> createModules [

	super createModules.
	self addModuleByModuleClass: Me5DataGridModuleBundle.
	self addModuleByModuleClass: Bs4TooltipsterTooltipModuleBundle.
]

{ #category : 'Accessing' }
ManagePlayerView >> data [

	^data
]

{ #category : 'Accessing' }
ManagePlayerView >> data: aListOfPlayer [

	data := aListOfPlayer
]

{ #category : 'Events' }
ManagePlayerView >> deletePlayerEvent: anEvent [

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
	
	self startUp saveObject: self data onPath: 'C:\Test\playersV2.dat'.
	
	self listGrid resetEditedDataGridCells.

	isSuccessful
	ifTrue: [
		self showSuccessNotificationWithMessage: ('Deleted Player %1 %2...' bindWith: (thePlayer firstName) with: (thePlayer lastName)).
	]
	ifFalse: [
		self showErrorNotificationWithMessage: ('Can not delete last Player...').
	]

]

{ #category : 'Accessing' }
ManagePlayerView >> listGrid [

	^listGrid
]

{ #category : 'Accessing' }
ManagePlayerView >> listGrid: anObject [

	listGrid := anObject
]

{ #category : 'Accessing' }
ManagePlayerView >> placeholder [

	^Player firstName: '' lastName: '' email: ''
]

{ #category : 'Events' }
ManagePlayerView >> saveEvent [

	| theNumberOfEditedDataGridRows |

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
		ifTrue: [^self showErrorNotificationWithMessage: 'Validation failed...'].
	
	self listGrid dataSourceBlock: [ self data	].

	self listGrid editedDataGridRows do: [ :eachEditedDataGridRow |
		eachEditedDataGridRow editedDataGridCells do: [ :eachEditedDataGridCell |
			eachEditedDataGridCell writeValueToObject]].

	self startUp saveObject: self data onPath: 'C:\Test\playersV2.dat'.
		
	self listGrid resetEditedDataGridCells.

	self showSuccessNotificationWithMessage: ('Saved %1 edited row(s)...' bindWith: theNumberOfEditedDataGridRows)
]

{ #category : 'Accessing' }
ManagePlayerView >> startUp [

	^startUp
]

{ #category : 'Accessing' }
ManagePlayerView >> startUp: anObject [

	startUp := anObject
]
