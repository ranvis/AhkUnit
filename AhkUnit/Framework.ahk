; Copyright (c) 2011, SATO Kentaro
; BSD 2-Clause license

class AhkUnit_Framework extends AhkUnit.FrameworkCore {
	; filePath_
	
	SetFile(filePath) {
		this.filePath_ := filePath
	}
	
	Assert(assertion, message = "", line = 0, file = "") {
		if (IsObject(assertion)) {
			if (assertion.Evaluate()) {
				this.AuSuccess()
				return ""
			}
		} else {
			assertion := new AhkUnit.Assert.Message("Bad assertion object.")
		}
		pos := ""
		if (file == "" && this.filePath_ != "") {
			file := this.filePath_
		}
		if (file != "") {
			pos .= file
		}
		if (line != 0 && line != "") {
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
	
	AssertEqual(expected, actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.Equal(expected, actual), message, line, file)
	}
	
	AssertNotEqual(expected, actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.NotEqual(expected, actual), message, line, file)
	}
	
	AssertEqualIgnoreCase(expected, actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.Equal(expected, actual).IgnoreCase(), message, line, file)
	}
	
	AssertNotEqualIgnoreCase(expected, actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.NotEqual(expected, actual).IgnoreCase(), message, line, file)
	}
	
	AssertObjectEqual(expected, actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.ObjectEqual(expected, actual), message, line, file)
	}
	
	AssertTrue(actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.True(actual), message, line, file)
	}
	
	AssertFalse(actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.False(actual), message, line, file)
	}
	
	AssertEmpty(actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.Empty(actual), message, line, file)
	}
	
	AssertNotEmpty(actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.NotEmpty(actual), message, line, file)
	}
	
	AssertObject(actual, message = "", line = 0, file = "") {
		this.Assert(new AhkUnit.Assert.Object(actual), message, line, file)
	}
}
