; Copyright (c) 2011, SATO Kentaro
; BSD 2-Clause license

#NoEnv
#include %A_AppData%\AhkUnit\GuiRunner.ahk
#include %A_ScriptDir%\AhkUnitTestSupplyment.ahk

class AhkUnitFrameworkTest extends AhkUnit_Framework {
	SetUp() {
		this.SetFile(A_LineFile)
	}
	
	SetFileTest() {
		this.SetFile("File path")
		this.AssertEqual("File path", this.filePath_)
		this.SetFile(A_LineFile)
	}
	
	TestMethodTest() {
		test := new MethodCallTestClass()
		this.AssertObject(test, "", A_LineNumber)
		this.AssertFalse(test.isSetUp, "", A_LineNumber)
		this.AssertFalse(test.isToneDown, "", A_LineNumber)
		this.AssertNotEqual(0, test.testRemaining, "", A_LineNumber)
		this.AssertFalse(test.invalidTestCalled, "", A_LineNumber)
		runner := AhkUnit.RunTest(test, new AhkUnit.Runner())
		this.AssertTrue(test.isSetUp, "", A_LineNumber)
		this.AssertTrue(test.isToneDown, "", A_LineNumber)
		this.AssertEqual(0, test.testRemaining, "", A_LineNumber)
		this.AssertFalse(test.invalidTestCalled, "", A_LineNumber)
	}
	
	_CheckRunnerResultCount(test, file, line) {
		this.AssertObject(test, file, line)
		runner := AhkUnit.RunTest(test, new AhkUnit.Runner())
		this.AssertObjectEqual(test.expectCount, runner.GetCount(), file, line)
	}
	
	TestResultTest() {
		test := new TestResultTestClass()
		this._CheckRunnerResultCount(test, "", A_LineNumber)
	}
	
	UncaughtExceptionTest() {
		test := new UncaughtExceptionTestClass1()
		this._CheckRunnerResultCount(test, "", A_LineNumber)
		test := new UncaughtExceptionTestClass2()
		this._CheckRunnerResultCount(test, "", A_LineNumber)
		test := new UncaughtExceptionTestClass3()
		this._CheckRunnerResultCount(test, "", A_LineNumber)
	}
	
	ComparisonTest() {
		this.Assert(new AhkUnit.Assert.Equal(0, 0), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Equal(true, 1), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Equal(false, 0), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Equal(1, 1), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.NotEqual("", 0), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.NotEqual("", " "), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.NotEqual("String", "string"), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.NotEqual("", " ").IgnoreCase(), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Equal("String", "string").IgnoreCase(), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Empty(""), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.NotEmpty("String"), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.NotEmpty(" "), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.NotEmpty(0), "", A_LineNumber)
	}
	
	BooleanTest() {
		this.Assert(new AhkUnit.Assert.True(true), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.True(1), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.True(true).Strict(), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.True(1).Strict(), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.False(false), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.False(false).Strict(), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.False(0), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.False(0).Strict(), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.False(""), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.False("").Strict()), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.True(Object()), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.True(Object()).Strict()), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.False(Object()).Strict()), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.True(2).Strict()), "", A_LineNumber)
	}
	
	ObjectComparisonTest() {
		this.Assert(new AhkUnit.Assert.ObjectEqual([1,2,3], [1,2,3]), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.ObjectEqual([3,1,2], [1,2,3])), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.ObjectEqual({a: 1, b: 2}, {a: 1, b: 2}), "", A_LineNumber)
		this.Assert(new AhkUnit.Assert.ObjectEqual({a: 1, b: 2}, {b: 2, a: 1}), "", A_LineNumber)
		expected := {a: 1, b: 2}
		actual := {b: 2, c: 3}
		actual.a := 1
		this.Assert(new AhkUnit.Assert.Not(new AhkUnit.Assert.ObjectEqual(expected, actual)), "", A_LineNumber)
		actual.Remove("c")
		this.Assert(new AhkUnit.Assert.ObjectEqual(expected, actual), "", A_LineNumber)
	}
}

AhkUnit.AddTest(new AhkUnitFrameworkTest())
AhkUnit.Run()
