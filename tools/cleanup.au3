Func Install($config)
   Local $install = $config.Item("install")
   ; Run installation program
   Run($install)

   WinWaitActive("Installing CleanUp! 4.5.2", "I &agree with the above terms and conditions")
   ; I agree with the above terms and conditions
   Send("!a")
   Send("{SPACE}")
   ; Next
   Send("!n")

   WinWait("Installing CleanUp! 4.5.2", "Destination Directory")
   ; Start
   Send("{ENTER}")

   WinWait("Installing CleanUp! 4.5.2", "Thank you for your interest")
   ; Don't want to View Readme File
   ControlCommand("Installing CleanUp! 4.5.2", "", "[CLASS:Button; INSTANCE:5]", "UnCheck", "")
   ; Don't run the application
   ControlCommand("Installing CleanUp! 4.5.2", "", "[CLASS:Button; INSTANCE:6]", "UnCheck", "")
   ; OK
   Send("{ENTER}")

   WinWait("CleanUp!", "CleanUp!")
   WinClose("CleanUp!", "CleanUp!")
EndFunc

Local $config = ObjCreate("Scripting.Dictionary")
$config.Add("install", $CmdLine[1])

Install($config)
ConsoleWrite("End of CleanUp!" & @LF)