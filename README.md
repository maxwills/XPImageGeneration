# XPImageGeneration

  
  ```Smalltalk

Metacello new
	baseline: 'XPImageGeneration';
	repository: 'github://Pharo-XP-Tools/XPImageGeneration:main';
	onConflict: [ :ex | ex useIncoming ];
	onUpgrade: [ :ex | ex useIncoming ];
	onDowngrade: [ :ex | ex useIncoming ];
	onWarning: [ :ex | Transcript crShow: ex ];
	load.
	
#XPImageGeneration asClass install

```


