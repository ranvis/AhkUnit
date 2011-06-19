#NoEnv
#include %A_AppData%\AhkUnit\GuiRunner.ahk

AhkUnit.Begin()
#include %A_ScriptDir%\AhkUnitTest.ahk
#include %A_ScriptDir%\AhkUnitTestSupplyment.ahk
AhkUnit.AddTest(new MethodCallTestClass())
AhkUnit.AddTest(new TestResultTestClass())
AhkUnit.End()
