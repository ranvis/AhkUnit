; Copyright (c) 2011, SATO Kentaro
; BSD 2-Clause license

class AhkUnit_Runner {
	; result, message, count
	; test
	
	Default() {
	}
	
	Run(testInstance) {
		this.result := ""
		this.message := ""
		this.count := { test: 0, assertion: 0, failure: 0, incomplete: 0 }
		this.test := testInstance
		try {
			testInstance.SetUp()
		} catch e {
			this._AddFailure("Exception thrown in SetUp")
			return
		}
		for key in testInstance.base {
			if (SubStr(key, -3) == "Test") {
				this.count.test++
				try {
					testInstance.AuInit(key)
					testInstance[key]()
				} catch e {
					thrownClass := (e.__Class == "") ? "Exception" : e.__Class
					expectedClass := testInstance[key . "_throws"]
					if (expectedClass != "") {
						assertion := new AhkUnit.Assert.Equal("throw " . expectedClass, "throw " . thrownClass)
						caller := IsObject(e) ? e : Object()
						testInstance.Assert_(assertion, message, caller)
					} else {
						this._AddFailure("Exception thrown in " . key)
						continue
					}
				}
				assertionCount := testInstance.AuGetAssertionCount()
				this.count.assertion += assertionCount
				if (assertionCount == 0) {
					this.result .= "I"
					this.count.incomplete++
					this.message .= key . " has no assertions.`n`n"
				} else if (!testInstance.AuGetResult()) {
					this._AddFailure(testInstance.AuGetMessage())
				} else {
					this.result .= "."
				}
			}
		}
		try {
			testInstance.TearDown()
		} catch e {
			this._AddFailure("Exception thrown in TearDown")
		}
	}
	
	_AddFailure(message) {
		this.result .= "F"
		this.count.failure++
		this.message .= message . "`n`n"
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
