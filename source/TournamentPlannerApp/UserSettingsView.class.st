Class {
	#name : 'UserSettingsView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'user'
	],
	#category : 'TournamentPlannerApp'
}

{ #category : 'Initial-Events' }
UserSettingsView >> beforeCreateComponents [

	"User muss noch ermittelt werden"
	self user isNil
		ifTrue: [
			self user: (Player newWithFirstName: 'Max' lastName: 'Muster'  email: 'max.muster@gmail.com').] 
]

{ #category : 'Initial-Events' }
UserSettingsView >> createComponents [
	
	self addChild: (Me5Portlet newPrimary
		title:'Einstellungen';
		addChildToBody: (Me5Form new
			addChildToBody: (Me5Row  new
				addChild: (Me5TextField new
					text:'Vorname';
					value: self user firstName;
					placeholder:'Vorname';
					addCssClassCol12;
					addCssClassColLg6;
					yourself);
				addChild: (Me5TextField new
					text:'Nachname';
					value: self user lastName;
					placeholder: 'Nachname';
					addCssClassColLg6;
					addCssClassCol12;
					yourself);	
				addChild: (Me5TextField new
					text:'E-Mail';
					value: self user email;
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
			yourself);
		yourself).
		
		
]

{ #category : 'Accessing' }
UserSettingsView >> user [
	
	"<^iOf Player>"
	"Answer the user of the receiver"
	
	^user
]

{ #category : 'Accessing' }
UserSettingsView >> user: aPlayer [

	"<aPlayer: iOf Player, ^self>"
	"Set the user of the receiver"

	user := aPlayer
	
]
