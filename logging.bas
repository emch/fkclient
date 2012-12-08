#Include "headers/logging.bi"
#Include "headers/params.bi" '' filename

Sub LogToFile(tolog As String)
	Open LOGGING_FILE_NAME For Append As #1
	Print #1, LOGGING_PREFIX + tolog
	Close #1
End Sub

Sub ClearLogFile()
	Open LOGGING_FILE_NAME For Output As #1
	Print #1, "Logfile created on " + Date + " at " + Time
	Print #1, "Using " + APP_NAME + VERSION_MESSAGE
	Print #1, "" '' blank line
	Close #1
End Sub
