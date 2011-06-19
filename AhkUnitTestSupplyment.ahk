#include %A_AppData%\AhkUnit\AhkUnit.ahk

class MethodCallTestClass extends AhkUnit_Framework {
	var isSetUp := false
	var isToneDown := false
	var testRemaining := 3
	var invalidTestCalled := false
	
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
	var expectCount := { test: 6, assertion: 4, failure: 2, incomplete: 3 }
	
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
