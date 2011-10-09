AhkUnit
=======

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
        ...your test cases...
    }
    
    AhkUnit.AddTest(new YourClassTest())
    AhkUnit.Run()

## Tutorial

https://github.com/ranvis/AhkUnit/wiki/Tutorial

## TODO

Future assertion functions may throw an exception on failure,
so that each  callers no longer need to pass its file name or
line number.

Test case functions should not catch exceptions.
To expect an exception to be thrown, some special method will be prepared.

## License

See the LICENSE file.
