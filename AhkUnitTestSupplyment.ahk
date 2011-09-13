; Copyright (c) 2011, SATO Kentaro
; BSD 2-Clause license

#include %A_AppData%\AhkUnit\AhkUnit.ahk

class MethodCallTestClass extends AhkUnit_Framework {
	isSetUp := false
	isToneDown := false
	testRemaining := 3
	invalidTestCalled := false
	
	SetUp() {
		this.SetFile(A_LineFile)
		this.isSetUp := true
	}
	
	TearDown() {
		this.isToneDown := true
	}
	
	ThisIsTest() {
		this.AssertTrue(true)
		this.testRemaining -= 1
	}
	
	thisIsTestTooTest() {
		this.AssertTrue(true)
		this.testRemaining -= 2
	}
	
	thisIsNotTEST() {
		this.invalidTestCalled := true
	}
	
	thisIsNotTestEither() {
		this.invalidTestCalled := true
	}
}

class TestResultTestClass extends AhkUnit_Framework {
	expectCount := { test: 6, assertion: 4, failure: 2, incomplete: 3 }
	
	SetUp() {
		this.SetFile(A_LineFile)
	}
	
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
	expectCount := { test: 0, assertion: 0, failure: 1, incomplete: 0 }
	
	SetUp() {
		throw 1
	}
	
	DummyTest() {
		; never executed below
		this.AssertTrue(true)
	}
}

class UncaughtExceptionTestClass2 extends AhkUnit_Framework {
	expectCount := { test: 1, assertion: 0, failure: 1, incomplete: 0 }
	
	ExceptionTest() {
		this.AssertTrue(true)
		throw 1
		; never executed below
		this.AssertTrue(true)
	}
}

class UncaughtExceptionTestClass3 extends AhkUnit_Framework {
	expectCount := { test: 1, assertion: 1, failure: 1, incomplete: 0 }
	
	DummyTest() {
		this.AssertTrue(true)
	}
	
	TearDown() {
		throw 1
	}
}
