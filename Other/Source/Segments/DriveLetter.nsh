;=#
; 
; PORTABLEAPPS COMPILER 
; Developed by daemon.devin (daemon.devin@gmail.com)
;
; For support, visit the GitHub project:
; https://github.com/daemondevin/pac-man
; 
; SEGMENT
;   DriveLetter.nsh
;   This file sets variables according to the current drive letter and the drive letter from the previous launch.
; 

${SegmentFile}
${SegmentInit}
	!ifmacrodef Drive
		!insertmacro Drive
	!endif
	ReadINIStr $1 ${SETINI} ${APPNAME}Settings LastDrive
	${GetRoot} $EXEDIR $0
	${IfThen} $1 == "" ${|} StrCpy $1 $0 ${|}
	${SetEnvironmentVariable} PAL:Drive $0
	StrCpy $0 $0 1
	${SetEnvironmentVariable} PAL:DriveLetter $0
	${SetEnvironmentVariable} PAL:LastDrive $1
	StrCpy $1 $1 1
	${SetEnvironmentVariable} PAL:LastDriveLetter $1
!macroend

${SegmentPrePrimary}
	!ifmacrodef PreDrive
		!insertmacro PreDrive
	!endif
	ReadEnvStr $0 PAL:Drive
	WriteINIStr `${SETINI}` `${APPNAME}Settings` LastDrive `$0`
!macroend
