; Copyright (c) 2011, SATO Kentaro
; BSD 2-Clause license

#NoEnv
#Warn All
#include %A_AppData%\AhkUnit\GuiRunner.ahk

AhkUnit.Begin()
#include %A_ScriptDir%\AhkUnitTest.ahk
#include %A_ScriptDir%\AhkUnitTestSupplyment.ahk
AhkUnit.AddTestClass(MethodCallTestClass)
AhkUnit.AddTestClass(TestResultTestClass)
AhkUnit.AddTestClass(UncaughtExceptionTestClass1)
AhkUnit.AddTestClass(UncaughtExceptionTestClass2)
AhkUnit.AddTestClass(UncaughtExceptionTestClass3)
AhkUnit.AddTestClass(UnexpectedExceptionTestClass)
AhkUnit.End()
