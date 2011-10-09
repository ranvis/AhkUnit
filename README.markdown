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

## Documentation

TODO

#### Initializing test class instance

	Setup() {
		...your setup process...
	}

Setup() is called before starting tests.

#### Cleaning up test class instance

	TearDown() {
		...your cleanup process...
	}

TearDown() is called after all tests.

#### Testing exceptions

Define an instance variable "YourTestName_throws" as "ExceptionName"

	ExceptionTest_throws := "ThrowingException"
	ExceptionTest() {
		throw new ThrowingException()
	}

	ExceptionTest_throws := "Exception"
	ExceptionTest() {
		throw 3
	}

## License

See the LICENSE file.
