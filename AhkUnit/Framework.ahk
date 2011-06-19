class AhkUnit_Framework extends AhkUnit.FrameworkCore {
	var filePath_
	
	SetFile(filePath) {
		this.filePath_ := filePath
	}
	
	Assert(assertion, message = "", line = 0) {
		if (IsObject(assertion)) {
			if (assertion.Evaluate()) {
				this.AuSuccess()
				return ""
			}
		} else {
			global AhkUnit
			assertion := new AhkUnit.Assert.Message("Bad assertion object.")
		}
		pos := ""
		if (this.filePath_ != "") {
			pos .= this.filePath_
		}
		if (line != 0) {
			pos .= " (" . line . ")"
		}
		if (pos != "") {
			pos .= ", "
		}
		pos .= this.AuGetMethod()
		if (message != "") {
			message := ": " . message
		}
		assertionMessage := assertion.GetMesssage()
		if (assertionMessage != "") {
			StringReplace,assertionMessage,assertionMessage,`n,% "`n  ",All
			assertionMessage := "  " . assertionMessage
			message .= "`n" . assertionMessage
		}
		this.AuFailed(pos . message)
	}
	
	AssertEqual(expected, actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.Equal(expected, actual), message, line)
	}
	
	AssertNotEqual(expected, actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.NotEqual(expected, actual), message, line)
	}
	
	AssertEqualIgnoreCase(expected, actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.Equal(expected, actual).IgnoreCase(), message, line)
	}
	
	AssertNotEqualIgnoreCase(expected, actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.NotEqual(expected, actual).IgnoreCase(), message, line)
	}
	
	AssertObjectEqual(expected, actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.ObjectEqual(expected, actual), message, line)
	}
	
	AssertTrue(actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.True(actual), message, line)
	}
	
	AssertFalse(actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.False(actual), message, line)
	}
	
	AssertEmpty(actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.Empty(actual), message, line)
	}
	
	AssertNotEmpty(actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.NotEmpty(actual), message, line)
	}
	
	AssertObject(actual, message = "", line = 0) {
		global AhkUnit
		this.Assert(new AhkUnit.Assert.Object(actual), message, line)
	}
}
