; Copyright (c) 2011, SATO Kentaro
; BSD 2-Clause license

#NoEnv
#Warn All
#include %A_AppData%\AhkUnit\GuiRunner.ahk
#include %A_AppData%\AhkUnit\ParentReporter.ahk
#include %A_ScriptDir%\AhkUnitTestSupplyment.ahk

class AhkUnitFrameworkTest extends AhkUnit_Framework {
	SetUp() {
	}
	
	TestMethodTest() {
		test := MethodCallTestClass
		this.AssertObject(test, "")
		this.AssertEqual(0, test.isSetUpBeforeClass, "")
		this.AssertEqual(0, test.isToneDownBeforeClass, "")
		this.AssertEqual(0, test.isSetUp, "")
		this.AssertEqual(0, test.isToneDown, "")
		this.AssertNotEqual(0, test.testRemaining, "")
		this.AssertFalse(test.invalidTestCalled, "")
		runner := AhkUnit.RunTestClass(test, new AhkUnit.Runner())
		this.AssertEqual(1, test.isSetUpBeforeClass, "")
		this.AssertEqual(1, test.isToneDownBeforeClass, "")
		this.AssertEqual(2, test.isSetUp, "")
		this.AssertEqual(2, test.isToneDown, "")
		this.AssertEqual(0, test.testRemaining, "")
		this.AssertFalse(test.invalidTestCalled, "")
	}
	
	_CheckRunnerResultCount(test) {
		cs := new AhkUnit.ParentReporter(this)
		this.AssertObject(test)
		runner := AhkUnit.RunTestClass(test, new AhkUnit.Runner())
		this.AssertObjectEqual(test.expectCount, runner.GetCount())
	}
	
	TestResultTest() {
		test := TestResultTestClass
		this._CheckRunnerResultCount(test, "")
	}
	
	UncaughtExceptionTest() {
		test := UncaughtExceptionTestClass1
		this._CheckRunnerResultCount(test, "")
		test := UncaughtExceptionTestClass2
		this._CheckRunnerResultCount(test, "")
		test := UncaughtExceptionTestClass3
		this._CheckRunnerResultCount(test, "")
		test := UncaughtExceptionTestClass4
		this._CheckRunnerResultCount(test, "")
		test := UncaughtExceptionTestClass5
		this._CheckRunnerResultCount(test, "")
		test := UncaughtExceptionTestClass6
		this._CheckRunnerResultCount(test, "")
	}
	
	static ExpectedExceptionTest_throws := "ExpectedException"
	ExpectedExceptionTest() {
		throw new ExpectedException()
	}
	
	static ExpectedException2Test_throws := "Exception"
	ExpectedException2Test() {
		throw Exception("test")
	}
	
	static ExpectedException3Test_throws := "Exception"
	ExpectedException3Test() {
		throw 10 ; this won't provide you line number / file name
	}
	
	UnexpectedExceptionTest() {
		test := UnexpectedExceptionTestClass
		this._CheckRunnerResultCount(test, "")
	}
	
	ComparisonTest() {
		this.Assert(new AhkUnit.Assert.Equal(0, 0), "")
		this.Assert(new AhkUnit.Assert.Equal(true, 1), "")
		this.Assert(new AhkUnit.Assert.Equal(false, 0), "")
		this.Assert(new AhkUnit.Assert.Equal(1, 1), "")
		this.Assert(new AhkUnit.Assert.NotEqual("", 0), "")
		this.Assert(new AhkUnit.Assert.NotEqual("", " "), "")
		this.Assert(new AhkUnit.Assert.NotEqual("String", "string"), "")
		this.Assert(new AhkUnit.Assert.NotEqual("", " ").IgnoreCase(), "")
		this.Assert(new AhkUnit.Assert.Equal("String", "string").IgnoreCase(), "")
		this.Assert(new AhkUnit.Assert.Empty(""), "")
		this.Assert(new AhkUnit.Assert.NotEmpty("String"), "")
		this.Assert(new AhkUnit.Assert.NotEmpty(" "), "")
		this.Assert(new AhkUnit.Assert.NotEmpty(0), "")
	}
	
	BooleanTest() {
		this.Assert(new AhkUnit.Assert.True(true), "")
		this.Assert(new AhkUnit.Assert.True(1), "")
		this.Assert(new AhkUnit.Assert.True(true).Strict(), "")
		this.Assert(new AhkUnit.Assert.True(1).Strict(), "")
		this.Assert(new AhkUnit.Assert.False(false), "")
		this.Assert(new AhkUnit.Assert.False(false).Strict(), "")
		this.Assert(new AhkUnit.Assert.False(0), "")
		this.Assert(new AhkUnit.Assert.False(0).Strict(), "")
		this.Assert(new AhkUnit.Assert.False(""), "")
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.False("").Strict()), "")
		this.Assert(new AhkUnit.Assert.True(Object()), "")
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.True(Object()).Strict()), "")
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.False(Object()).Strict()), "")
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.True(2).Strict()), "")
	}
	
	ObjectComparisonTest() {
		this.Assert(new AhkUnit.Assert.ObjectEqual([1,2,3], [1,2,3]), "")
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.ObjectEqual([3,1,2], [1,2,3])), "")
		this.Assert(new AhkUnit.Assert.ObjectEqual({a: 1, b: 2}, {a: 1, b: 2}), "")
		this.Assert(new AhkUnit.Assert.ObjectEqual({a: 1, b: 2}, {b: 2, a: 1}), "")
		expected := {a: 1, b: 2}
		actual := {b: 2, c: 3}
		actual.a := 1
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.ObjectEqual(expected, actual)), "")
		actual.Remove("c")
		this.Assert(new AhkUnit.Assert.ObjectEqual(expected, actual), "")
	}
}

class ExpectedException extends BaseException {
	__New() {
		backtrace := Exception("", -1)
		this.file := backtrace.file
		this.line := backtrace.line
	}
}

AhkUnit.AddTestClass(AhkUnitFrameworkTest)
AhkUnit.Run()
