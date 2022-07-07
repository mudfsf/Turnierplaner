Class {
	#name : 'ManagePlayersView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'listGrid',
		'data',
		'placeholder',
		'newPlayerModal',
		'firstNameField',
		'lastNameField',
		'emailField',
		'symbolField',
		'moneyField'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Events' }
ManagePlayersView >> addPlayerEvent [
	
	"<^self>"
	"Adds empty row to listGrid"
	
	| theFirstNameField theLastNameField theEmailField theSymbolField theMoneyField |
	
	self newPlayerModal: (ModalView new title: 'Neuer Spieler').
	
	self newPlayerModal body: (Me5Form new
		addChildToBody: (theFirstNameField := (Me5TextField new
			text: 'Vorname';
			placeholder: 'Vorname';
			yourself));
		addChildToBody: (theLastNameField := (Me5TextField new
			text: 'Nachname';
			placeholder: 'Nachname';
			yourself));
	addChildToBody: (theEmailField := (Me5TextField new
			text: 'E-Mail';
			placeholder: 'E-Mail';
			yourself));
		addChildToBody: (theSymbolField := (Me5TextField new
			text: 'Kürzel';
			placeholder: 'Kürzel';
			yourself));
		addChildToBody: (theMoneyField := (Me5TextField new
			text: 'Guthaben';
			placeholder: 'Guthaben';
			yourself));
		yourself).
	self newPlayerModal foot: (Me5Button newPrimary
		text: 'Speichern';
		addClickEventSelector: #addPlayerSaveEvent: eventReceiver: self;
		icon: Me5I newFasSave;
		yourself).		
	
	self
		firstNameField: theFirstNameField;
		lastNameField:  theLastNameField;
		emailField: theEmailField;
		symbolField: theSymbolField;
		moneyField: theMoneyField;
		yourself.
	
	self openModal: self newPlayerModal
]

{ #category : 'Events' }
ManagePlayersView >> addPlayerSaveEvent: anEvent [

	"<anEvent: iOf Me5Event, ^self>"
	"Adds player to collection"

	| thePlayer |
	
	self firstNameField clearErrorText.
	self lastNameField clearErrorText.
	self emailField clearErrorText.
	self symbolField clearErrorText.
	self moneyField clearErrorText.
		
	self firstNameField value isEmpty
		ifTrue: [self firstNameField setErrorText: 'Bitte Vorname angegeben!'].
	self lastNameField value isEmpty
		ifTrue: [self lastNameField setErrorText: 'Bitte Nachname angegeben!'].
	self emailField value isEmpty
		ifTrue: [self emailField setErrorText: 'Bitte E-Mail angegeben!'].	
	self symbolField value isEmpty
		ifTrue: [self symbolField setErrorText: 'Bitte K&uuml;rzel angegeben!'].	
	thePlayer := Player new.
	thePlayer 
		firstName: self firstNameField value;
		lastName:  self lastNameField value;
		email:  self emailField value;
		symbol: self symbolField value;		
		yourself.
	(self moneyField value isEmpty or: [(self isValidMoney: self moneyField value) not])
		ifTrue: [self moneyField setErrorText: 'Bitte ein Guthaben angegeben!']
		ifFalse: [thePlayer money:  self moneyField value asInteger].
	(self playerAlreadyExist: thePlayer)
		ifTrue:[
			^self showErrorNotificationWithMessage: 'Spieler existiert bereits!'].
	(thePlayer isValid and: [(self playerAlreadyExist: thePlayer) not])
		ifTrue: [
			self data add: thePlayer.
			self listGrid dataSourceBlock: [self data].
			self listGrid resetEditedDataGridCells.
			TournamentPlannerApp saveCollectionOfPlayers: self data.
			self newPlayerModal closeModal].

			

	

]

{ #category : 'Initial-Events' }
ManagePlayersView >> beforeCreateComponents [

	"This method is called before #createComponents.
	 Sets data."
	
	self data: TournamentPlannerApp collectionOfPlayers data
]

{ #category : 'Events' }
ManagePlayersView >> clearEvent [

	"<^self>"
	"Removes empty row from listGrid"

	self listGrid dataSourceBlock: [self data].
	self listGrid resetEditedDataGridCells.
	self showSuccessNotificationWithMessage: ('&Auml;nderungen zur&uuml;ckgesetzt')
]

{ #category : 'Initial-Events' }
ManagePlayersView >> createComponents [

	"<^self>"
	"Entry point for creating components.
	 Sets listGrid"

	self listGrid: (Me5ListGrid new
		addCssClassColMd12;
		height: '60vh';
		dataSourceBlock: [self data];
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'Vorname';
			getterSelector: #firstName;
			setterSelector: #firstName:;
			enableHeaderSort;
			minWidth: 200;
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
			yourself);
		addDataGridColumnDefinition: (Me5DataGridTextFieldColumnDefinition new
			title: 'K&uumlrzel';
			getterSelector: #symbol;
			setterSelector: #symbol:;
			enableHeaderSort;
			minWidth: 200;
			yourself);
		addDataGridColumnDefinition: (Me5DataGridIntegerFieldColumnDefinition new
			title: 'Guthaben';
			getterSelector: #money;
			setterSelector: #money:;
			enableHeaderSort;
			minWidth: 200;
			yourself);
		addDataGridColumnDefinition: (Me5DataGridComponentsHolderColumnDefinition new
			title: 'Aktion';
			setHorizontalAlignmentToRight;
			componentsHolderBlock: [ 
				:theDataGridComponentsHolderCell :theDataGridComponentsHoldingParameters |
				theDataGridComponentsHolderCell
				addChild: (Me5Button newDanger
					icon: Me5I newFasTrash;
					text: 'L&ouml;schen';
					addClickEventSelector: #deletePlayerEvent: eventReceiver: self;
					yourself);
				yourself];
			yourself);
		yourself).
	
	self addChild: (Me5H1 new 
			text: 'Admin-Tools';
			addCssClassTextCenter;
			yourself);
		addChild: Me5Hr new;
		addChild: (Me5FormPortlet new
			addCssClassColMd12;
			addChildToBody: self listGrid;
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
				text: 'Zur&uuml;cksetzen';
				addClickEventSelector: #clearEvent eventReceiver: self;
				yourself);
			yourself);
		yourself
]

{ #category : 'Initial-Events' }
ManagePlayersView >> createModules [

	"<^self>"
	"Creates and adds the modules which should be embedded for this view."

	super createModules.
	
	self addModuleByModuleClass: Me5DataGridModuleBundle.
	self addModuleByModuleClass: Bs4TooltipsterTooltipModuleBundle
]

{ #category : 'Accessing' }
ManagePlayersView >> data [

	"<^hOf Collection of: {iOf Player}>"
	"Answer the data of the receiver"

	^data
]

{ #category : 'Accessing' }
ManagePlayersView >> data: aPlayerCollection [

	"<aPlayerCollection: hOf Collection of: {iOf Player}, ^self>"
	"Set the data of the receiver"

	data := aPlayerCollection
]

{ #category : 'Events' }
ManagePlayersView >> deletePlayerEvent: anEvent [

	"<anEvent: iOf Me5Event, ^self>"
	"Deletes Player from listGrid and memory"

	| thePlayer isSuccessfullBoolean |
	
	isSuccessfullBoolean := false.
	thePlayer := anEvent dataGridComponentsHolderCellObject.
	((self data includes: thePlayer) and: [self data size > 1])
		ifTrue: [
			self data remove: thePlayer.
			isSuccessfullBoolean := true].
	self listGrid dataSourceBlock: [self data].
	self listGrid resetEditedDataGridCells.
	isSuccessfullBoolean
		ifTrue: [self showSuccessNotificationWithMessage: ('Spieler %1 gel&ouml;scht!' 
			bindWith: thePlayer asString)]
		ifFalse: [self showErrorNotificationWithMessage: ('Der letzte Spieler kann nicht gel&ouml;scht werden!')].		
	TournamentPlannerApp saveCollectionOfPlayers: self data
]

{ #category : 'Accessing' }
ManagePlayersView >> emailField [

	"<^iOf Me5TextField>"
	"Answer the emailField of the receiver"

	^emailField
]

{ #category : 'Accessing' }
ManagePlayersView >> emailField: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the emailField of the receiver"

	emailField := aMe5TextField
]

{ #category : 'Accessing' }
ManagePlayersView >> firstNameField [

	"<^iOf Me5TextField>"
	"Answer the firstNameField of the receiver"

	^firstNameField
]

{ #category : 'Accessing' }
ManagePlayersView >> firstNameField: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the firstNameField of the receiver"

	firstNameField := aMe5TextField
]

{ #category : 'Internal' }
ManagePlayersView >> isValidMoney: aMoneyString [

	"^iof Boolean"
	"Validates the MoneyString"
	
	aMoneyString doWithIndex: [ :eachLetter :eachIndex |
		(eachIndex=1 and: [(eachLetter=$+ or: [eachLetter=$-])])
			ifFalse: [
				eachLetter isDigit
					ifFalse: [^false]]].
	^true
]

{ #category : 'Accessing' }
ManagePlayersView >> lastNameField [

	"<^iOf Me5TextField>"
	"Answer the lastNameField of the receiver"

	^lastNameField
]

{ #category : 'Accessing' }
ManagePlayersView >> lastNameField: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the lastNameField of the receiver"

	lastNameField := aMe5TextField
]

{ #category : 'Accessing' }
ManagePlayersView >> listGrid [

	"<^iOf ListGrid>"
	"Answer the listGrid of the receiver"

	^listGrid
]

{ #category : 'Accessing' }
ManagePlayersView >> listGrid: aListGrid [

	"<aListGrid: iOf ListGrid, ^self>"
	"Set the listGrid of the receiver"

	listGrid := aListGrid
]

{ #category : 'Accessing' }
ManagePlayersView >> moneyField [

	"<^iOf Me5TextField>"
	"Answer the moneyField of the receiver"

	^moneyField
]

{ #category : 'Accessing' }
ManagePlayersView >> moneyField: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the moneyField of the receiver"

	moneyField := aMe5TextField
]

{ #category : 'Accessing' }
ManagePlayersView >> newPlayerModal [

	"<^iOf ModalView>"
	"Answer the newPlayerModal of the receiver"

	^newPlayerModal
]

{ #category : 'Accessing' }
ManagePlayersView >> newPlayerModal: aModalView [

	"<aModalView: iOf ModalView, ^self>"
	"Set the newPlayerModal of the receiver"

	newPlayerModal := aModalView
]

{ #category : 'Internal' }
ManagePlayersView >> playerAlreadyExist: aPlayer [

	"^iof Boolean"
	"Checks if aPlayer exists"
	
	TournamentPlannerApp collectionOfPlayers data do: [ :eachPlayer |
		eachPlayer asString = aPlayer asString 
			ifTrue: [^true]].
	^false
	
]

{ #category : 'Events' }
ManagePlayersView >> saveEvent [
	
	"<^self>"
	"Adds Player to listGrid and memory"

	| theNumberOfEditedDataGridRows |

	theNumberOfEditedDataGridRows := self listGrid numberOfEditedDataGridRows.
	self listGrid validateEditedDataGridCellsForBlock: [ :eachEditedDataGridCell | | theFieldName theValue |
		theFieldName := (self listGrid dataGridColumnDefinitions at: eachEditedDataGridCell field asNumber) title.
		theValue := eachEditedDataGridCell value.
		(theValue isNil or: [((theValue isMemberOf: String) and: [theValue isEmpty])])
			ifTrue: [
				eachEditedDataGridCell errorText: ('Bitte geben sie ein %1 ein' bindWith: theFieldName)]].
	self listGrid hasValidationError
		ifTrue: [^self showErrorNotificationWithMessage: 'Validierung fehlgeschlagen...'].
	self listGrid dataSourceBlock: [self data].
	self listGrid editedDataGridRows do: [ :eachEditedDataGridRow |
		eachEditedDataGridRow editedDataGridCells do: [ :eachEditedDataGridCell |
			eachEditedDataGridCell writeValueToObject]].
	self listGrid resetEditedDataGridCells.
	self showSuccessNotificationWithMessage: ('%1 bearbeitete Reihe(n) gespeichert...' 
		bindWith: theNumberOfEditedDataGridRows).
	TournamentPlannerApp saveCollectionOfPlayers: self data
]

{ #category : 'Accessing' }
ManagePlayersView >> symbolField [

	"<^iOf Me5TextField>"
	"Answer the symbolField of the receiver"

	^symbolField
]

{ #category : 'Accessing' }
ManagePlayersView >> symbolField: aMe5TextField [

	"<aMe5TextField: iOf Me5TextField, ^self>"
	"Set the symbolField of the receiver"

	symbolField := aMe5TextField
]
