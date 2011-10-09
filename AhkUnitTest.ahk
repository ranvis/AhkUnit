; Copyright (c) 2011, SATO Kentaro
; BSD 2-Clause license

#NoEnv
#include %A_AppData%\AhkUnit\GuiRunner.ahk
#include %A_ScriptDir%\AhkUnitTestSupplyment.ahk

class AhkUnitFrameworkTest extends AhkUnit_Framework {
	SetUp() {
	}
	
	TestMethodTest() {
		test := new MethodCallTestClass()
		this.AssertObject(test, "")
		this.AssertFalse(test.isSetUp, "")
		this.AssertFalse(test.isToneDown, "")
		this.AssertNotEqual(0, test.testRemaining, "")
		this.AssertFalse(test.invalidTestCalled, "")
		runner := AhkUnit.RunTest(test, new AhkUnit.Runner())
		this.AssertTrue(test.isSetUp, "")
		this.AssertTrue(test.isToneDown, "")
		this.AssertEqual(0, test.testRemaining, "")
		this.AssertFalse(test.invalidTestCalled, "")
	}
	
	_CheckRunnerResultCount(test) {
		this.AssertObject(test)
		runner := AhkUnit.RunTest(test, new AhkUnit.Runner())
		this.AssertObjectEqual(test.expectCount, runner.GetCount())
	}
	
	TestResultTest() {
		test := new TestResultTestClass()
		this._CheckRunnerResultCount(test, "")
	}
	
	UncaughtExceptionTest() {
		test := new UncaughtExceptionTestClass1()
		this._CheckRunnerResultCount(test, "")
		test := new UncaughtExceptionTestClass2()
		this._CheckRunnerResultCount(test, "")
		test := new UncaughtExceptionTestClass3()
		this._CheckRunnerResultCount(test, "")
	}
	
	ExpectedExceptionTest_throws := "ExpectedException"
	ExpectedExceptionTest() {
		throw new ExpectedException()
	}
	
	ExpectedException2Test_throws := "Exception"
	ExpectedException2Test() {
		throw Exception("test")
	}
	
	ExpectedException3Test_throws := "Exception"
	ExpectedException3Test() {
		throw 10 ; this won't provide you line number / file name
	}
	
	UnexpectedExceptionTest() {
		test := new UnexpectedExceptionTestClass()
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

AhkUnit.AddTest(new AhkUnitFrameworkTest())
AhkUnit.Run()
