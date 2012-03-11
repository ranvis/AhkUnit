; Copyright (c) 2011, SATO Kentaro
; BSD 2-Clause license

#include %A_AppData%\AhkUnit\AhkUnit.ahk

class MethodCallTestClass extends AhkUnit_Framework {
	static isSetUpBeforeClass := 0
	static isToneDownBeforeClass := 0
	static isSetUp := 0
	static isToneDown := 0
	static testRemaining := 3
	static invalidTestCalled := false
	
	SetUpBeforeClass() {
		MethodCallTestClass.isSetUpBeforeClass++
	}
	
	TearDownAfterClass() {
		MethodCallTestClass.isToneDownBeforeClass++
	}
	
	SetUp() {
		MethodCallTestClass.isSetUp++
	}
	
	TearDown() {
		MethodCallTestClass.isToneDown++
	}
	
	ThisIsTest() {
		MethodCallTestClass.AssertTrue(true)
		MethodCallTestClass.testRemaining -= 1
	}
	
	thisIsTestTooTest() {
		MethodCallTestClass.AssertTrue(true)
		MethodCallTestClass.testRemaining -= 2
	}
	
	thisIsNotTEST() {
		MethodCallTestClass.invalidTestCalled := true
	}
	
	thisIsNotTestEither() {
		MethodCallTestClass.invalidTestCalled := true
	}
}

class TestResultTestClass extends AhkUnit_Framework {
	static expectCount := { test: 6, assertion: 4, failure: 2, incomplete: 3 }
	
	EmptyTest() {
	}
	
	Empty2Test() {
	}
	
	Empty3Test() {
	}
	
	ValidTest() {
		this.AssertEqual(1, 1)
	}
	
	InvalidTest() {
		this.AssertTrue(false)
		this.AssertEqual("text", "Text")
	}
	
	Invalid2Test() {
		this.AssertEqual(0, 1)
	}
}

class UncaughtExceptionTestClass1 extends AhkUnit_Framework {
	static expectCount := { test: 0, assertion: 0, failure: 1, incomplete: 0 }
	
	SetUpBeforeClass() {
		throw 1
	}
	
	DummyTest() {
		; never executed below
		this.AssertTrue(true)
	}
}

class UncaughtExceptionTestClass2 extends AhkUnit_Framework {
	static expectCount := { test: 1, assertion: 0, failure: 1, incomplete: 0 }
	
	__New() {
		throw 1
	}
	
	DummyTest() {
		; never executed below
		this.AssertTrue(true)
	}
}

class UncaughtExceptionTestClass3 extends AhkUnit_Framework {
	static expectCount := { test: 1, assertion: 0, failure: 1, incomplete: 0 }
	
	SetUp() {
		throw 1
	}
	
	DummyTest() {
		; never executed below
		this.AssertTrue(true)
	}
}

class UncaughtExceptionTestClass4 extends AhkUnit_Framework {
	static expectCount := { test: 1, assertion: 0, failure: 1, incomplete: 0 }
	
	ExceptionTest() {
		this.AssertTrue(true)
		throw 1
		; never executed below
		this.AssertTrue(true)
	}
}

class UncaughtExceptionTestClass5 extends AhkUnit_Framework {
	static expectCount := { test: 1, assertion: 1, failure: 1, incomplete: 0 }
	
	DummyTest() {
		this.AssertTrue(true)
	}
	
	TearDown() {
		throw 1
	}
}

class UncaughtExceptionTestClass6 extends AhkUnit_Framework {
	static expectCount := { test: 1, assertion: 1, failure: 1, incomplete: 0 }
	
	DummyTest() {
		this.AssertTrue(true)
	}
	
	TearDownAfterClass() {
		throw 1
	}
}

class UnexpectedExceptionTestClass extends AhkUnit_Framework {
	static expectCount := { test: 1, assertion: 1, failure: 1, incomplete: 0 }
	
	static BadExceptionTest_throws := "CorrectException"
	BadExceptionTest() {
		throw new BadException()
	}
}

class BaseException {
	__New() {
		backtrace := Exception("", -1)
		this.file := backtrace.file
		this.line := backtrace.line
	}
}

class BadException extends BaseException {
}
