; Copyright (c) 2011, SATO Kentaro
; BSD 2-Clause license

class AhkUnit {
	SetDefaultRunner(runnerClass) {
		AhkUnit.defaultRunner := runnerClass
	}
	
	RunTest(testInstance, runner = false) {
		if (!runner) {
			runner := new AhkUnit.defaultRunner()
			runner.Default()
		}
		runner.Run(testInstance)
		return runner
	}
	
	AddTest(testInstance) {
		AhkUnit.testInstances.Insert(testInstance)
	}
	
	Run(runner = false) {
		if (AhkUnit.nesting != 0) {
			return
		}
		if (!runner) {
			runner := new AhkUnit.defaultRunner()
			runner.Default()
		}
		for key in AhkUnit.testInstances {
			runner.Run(AhkUnit.testInstances[key])
		}
	}
	
	Begin() {
		AhkUnit.nesting++
	}
	
	End(runner = false) {
		if (AhkUnit.nesting == 0) {
			MsgBox,AhkUnit.Begin() not called.
			Exit
		}
		AhkUnit.nesting--
		return AhkUnit.Run(runner)
	}
	
	class FrameworkCore {
		; method_
		; result_, message_, assertionCount_
		
		SetUp() {
		}
		
		TearDown() {
		}
		
		AuInit(method) {
			this.method_ := method
			this.result_ := true
			this.message_ := ""
			this.assertionCount_ := 0
		}
		
		AuSuccess() {
			this.assertionCount_++
		}
		
		AuFailed(message) {
			this.assertionCount_++
			this.result_ := false
			if (this.message_ != "") {
				this.message_ .= "`n"
			}
			this.message_ .= message
		}
		
		AuGetMethod() {
			return this.method_
		}
		
		AuGetResult() {
			return this.result_
		}
		
		AuGetMessage() {
			return this.message_
		}
		
		AuGetAssertionCount() {
			return this.assertionCount_
		}
	}
}

AhkUnit.nesting := 0
AhkUnit.testInstances := []

#include %A_AppData%\AhkUnit\Assert.ahk
#include %A_AppData%\AhkUnit\Framework.ahk
#include %A_AppData%\AhkUnit\Runner.ahk

AhkUnit.SetDefaultRunner(AhkUnit.Runner)
