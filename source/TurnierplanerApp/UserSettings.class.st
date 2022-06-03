Class {
	#name : 'UserSettings',
	#superclass : 'Me5BaseView',
	#instVars : [
		'user',
		'theUserSettingsView'
	],
	#category : 'TurnierplanerApp'
}

{ #category : 'Initial-Events' }
UserSettings >> beforeCreateComponents [
	|thePlayer|
	"User muss noch ermittelt werden"
	(self user = nil)
		ifTrue: [
			thePlayer:=Player firstName: 'Max' lastName: 'Muster'  email: 'max.muster@gmail.com'.
			self user:thePlayer.] 
]

{ #category : 'Initial-Events' }
UserSettings >> createComponents [
	
	self theUserSettingsView: (Me5Portlet newPrimary
			title:'Einstellungen';
			addChildToBody: (Me5Form new
				addChildToBody: (Me5Row  new
					addChild: (Me5TextField new
						text:'Vorname';
						value: user firstName;
						placeholder:'Vorname';
						addCssClassCol12;
						addCssClassColLg6;
					yourself);
					addChild: (Me5TextField new
						text:'Nachname';
						value: user lastName;
						placeholder: 'Nachname';
						addCssClassColLg6;
						addCssClassCol12;
					yourself);	
					addChild: (Me5TextField new
						text:'E-Mail';
						value: user email;
						placeholder: 'E-Mail';
						addCssClassColLg6;
						addCssClassCol12;
					yourself);	
				yourself);
				addChildToBody: (Me5Row new
					addChild: (Me5PasswordField new
							text:'Passwort';
							placeholder: 'Passwort';
							addCssClassColLg6;
							addCssClassCol12;
						yourself);	
					yourself);
				yourself);
				
				addChildToFoot: (Me5Button newPrimary
					text:'Speichern';
					icon: Me5I newFasSave;
					"addClickEventSelector: #savePlayer;"
					yourself);
				
			yourself).
		
		
]

{ #category : 'Accessing' }
UserSettings >> theUserSettingsView [

	"<^iOf Object>"
	"Answer the theUserSettingsView of the receiver"

	^theUserSettingsView
]

{ #category : 'Accessing' }
UserSettings >> theUserSettingsView: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the theUserSettingsView of the receiver"

	theUserSettingsView := anObject
]

{ #category : 'Accessing' }
UserSettings >> user [

	^user
]

{ #category : 'Accessing' }
UserSettings >> user: aPlayer [

	user := aPlayer
	
]
