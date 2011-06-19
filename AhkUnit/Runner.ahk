class AhkUnit_Runner {
	var result, message, count
	var test
	
	Default() {
	}
	
	Run(testInstance) {
		this.result := ""
		this.message := ""
		this.count := { test: 0, assertion: 0, failure: 0, incomplete: 0 }
		this.test := testInstance
		testInstance.SetUp()
		for key in testInstance.base {
			if (SubStr(key, -3) == "Test") {
				testInstance.AuInit(key)
				testInstance[key]()
				assertionCount := testInstance.AuGetAssertionCount()
				this.count.assertion += assertionCount
				if (assertionCount == 0) {
					this.result .= "I"
					this.count.incomplete++
					this.message .= key . " has no assertions.`n`n"
				} else if (!testInstance.AuGetResult()) {
					this.result .= "F"
					this.count.failure++
					this.message .= testInstance.AuGetMessage() . "`n`n"
				} else {
					this.result .= "."
				}
				this.count.test++
			}
		}
		testInstance.TearDown()
	}
	
	GetCountString() {
		count := this.GetCount()
		report := "Tests: " . count.test . ", Assertions: " . count.assertion
		if (count.failure) {
			report .= ", Failures: " . count.failure
		}
		if (count.incomplete) {
			report .= ", Incomplete: " . count.incomplete
		}
		return report
	}
	
	GetReport() {
		result := this.GetResult()
		count := this.GetCount()
		report := "Result: " . result . "`n"
		if (!count.failure) {
			report .= "OK, "
		}
		report .= this.GetCountString() . "`n`n"
		report .= this.GetMessage()
		return report
	}
	
	GetResult() {
		return this.result
	}
	
	GetMessage() {
		return this.message
	}
	
	GetCount() {
		return this.count
	}
}

AhkUnit.Runner := AhkUnit_Runner
