# XPImageGeneration

  
  ```Smalltalk
Metacello new
	baseline: 'XPImageGeneration';
	repository: 'github://Pharo-XP-Tools/XPImageGeneration:main';
	load.
```

## Quickly create an experiment

- Create a for of this repository.
- Install the framework using the previous baseline, but pointing to you fork.
- In Pharo, search for the class ExampleExperiment in the Experiments package. Copy it (right click, copy it, write the new name in the dialog).
- Rewrite the instance methods of you new experiment class.
  - The tasks displayed in the PhexTasksPresenter will be loaded from `ptx` files in the folder `tasksDefinition/*your-experiment-id*` located in the root directory of the repository.
  - The method `prepareSystemForExperiment`is called when your experiment is loaded. Code there to make all required modifications in the system needed for your complete experiment. (The system modifications can be part of you fork, or be in another baseline. Your choice).
  - Commit and Push `XPImageGeneration` changes to your fork.

## Participants' point of view.
- Participants must download a specific Pharo 9.0 clean image.
- They need to execute the same baseline from your fork. A message will appear once everything is loaded.
- In the World menu, they need to click Library>Phex. And then load your experiment.
- They see the tasks you defined (the ones in `tasksDefinition/*your-experiment-id*` folder) and the experience is started.

## Tasks definition

- TODO: the ptx file production
- TODO: System changes

## Logging

- TODO: Logging modalities (centralized, local)
- TODO: Instrumenting your experiment.

