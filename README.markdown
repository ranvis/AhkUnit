AhkUnit 1.1
===========

AhkUnit is a unit test framework for AutoHotkey_L 1.1.05.

## Installation

Copy AhkUnit directory into %A_AppData% directory.

On Windows Vista or later,
the following steps will clone the project from GitHub
and make a junction of AhkUnit script folder.

	git clone git://github.com/ranvis/AhkUnit.git
	cd AhkUnit
	mklink /j %APPDATA%\AhkUnit AhkUnit

## Usage

	#NoEnv
	#include %A_AppData%\AhkUnit\GuiRunner.ahk
	
	class YourClassTest extends AhkUnit_Framework {
		YourTest() {
			...assertions...
		}
	}
	
	AhkUnit.AddClass(YourClassTest)
	AhkUnit.Run()

## Tutorial etc.

https://github.com/ranvis/AhkUnit/wiki/

## License

See the LICENSE file.
