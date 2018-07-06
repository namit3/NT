; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Blumind"
!define PRODUCT_FULLNAME "Blumind - Mind Map Tool"
!define PRODUCT_VERSION "1.3.21.1"
!define OUTPUT_FILENAME "Output\${PRODUCT_NAME}-1.3.exe"
!define PRODUCT_PUBLISHER "hyfree.net"
!define PRODUCT_WEB_SITE "http://www.hyfree.net"
!define PRODUCT_COMPANY "HYFREE.NET"
!define PRODUCT_DIR_REGKEY "Software\${PRODUCT_COMPANY}\${PRODUCT_NAME}\App Paths\Blumind.exe"
!define PRODUCT_UNINST_KEY "Software\${PRODUCT_COMPANY}\${PRODUCT_NAME}\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; .Net Framework Detector
!include ".\Include\DotNetDetector.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON ".\Resources\Install.ico"
!define MUI_UNICON ".\Resources\Uninstall.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP ".\Resources\winzard.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP ".\Resources\winzard-uninstall.bmp"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Welcome page
!define MUI_WELCOMEPAGE_TITLE "${PRODUCT_FULLNAME} ${PRODUCT_VERSION}"
!define MUI_WELCOMEPAGE_TEXT "$_CLICK"
!insertmacro MUI_PAGE_WELCOME

; License page
!insertmacro MUI_PAGE_LICENSE ".\Include\Licence.txt"

; Directory page
!insertmacro MUI_PAGE_DIRECTORY

; Start menu page
var ICONS_GROUP
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "${PRODUCT_NAME}"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!insertmacro MUI_PAGE_STARTMENU START_MENU_PAGE $ICONS_GROUP

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\Blumind.exe"
; !define MUI_FINISHPAGE_RUN_TEXT "Run ${PRODUCT_NAME} ${PRODUCT_VERSION} "
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "TradChinese"

VIProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${PRODUCT_NAME}"
;VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" ""
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${PRODUCT_VERSION}"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${OUTPUT_FILENAME}"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show
BrandingText "${PRODUCT_WEB_SITE}";

Function .onInit
	!insertmacro DotNetSearch 2 0 50727 "INSTALL_NOABORT" "http://www.hyfree.net/product/blumind"
;	!insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Section "MainSection" SEC01
	SetOverwrite ifnewer

	SetOutPath "$INSTDIR"
	File "..\Code\Release\Dotfuscated\Blumind.exe"
	File "..\Code\Release\DocTypeReg.exe"
	File "..\Documents\Blumind Quick Help.bmd"
	
	SetOutPath "$INSTDIR\Icons"
	File "..\Code\Release\Icons\*.png"
	File "..\Code\Release\Icons\readme.txt"
	
	; Shortcuts
	!insertmacro MUI_STARTMENU_WRITE_BEGIN START_MENU_PAGE
	CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
	CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\${PRODUCT_NAME}.lnk" "$INSTDIR\Blumind.exe"
	CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\UnInstall.exe"
	; CreateShortCut "$DESKTOP\${PRODUCT_FULLNAME}.lnk" "$INSTDIR\Blumind.exe" "" "$INSTDIR\Blumind.exe"
	!insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -AdditionalIcons
	# SetOutPath $INSTDIR
	# CreateShortCut "$SMPROGRAMS\${PRODUCT_COMPANY}\Uninstall.lnk" "$INSTDIR\UnInstall.exe"
SectionEnd

Section -Post
	WriteUninstaller "$INSTDIR\UnInstall.exe"
	WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\Blumind.exe"
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
	writeregstr ${product_uninst_root_key} "${product_uninst_key}" "uninstallstring" "$instdir\uninstall.exe"
	writeregstr ${product_uninst_root_key} "${product_uninst_key}" "displayicon" "$instdir\blumind.exe"
	writeregstr ${product_uninst_root_key} "${product_uninst_key}" "displayversion" "${product_version}"
	writeregstr ${product_uninst_root_key} "${product_uninst_key}" "urlinfoabout" "${product_web_site}"
	writeregstr ${product_uninst_root_key} "${product_uninst_key}" "publisher" "${product_publisher}"

	; register file type
	WriteRegStr HKCR ".bmd" "" "Blumind.MindMap"
	WriteRegStr HKCR "Blumind.MindMap" "" "Blumind Mind Map Document"
	WriteRegStr HKCR "Blumind.MindMap\DefaultIcon" "" "$INSTDIR\DocTypeReg.exe,1"
	WriteRegStr HKCR "Blumind.MindMap\shell" "" "open"
	WriteRegStr HKCR "Blumind.MindMap\shell\open\command" "" '$INSTDIR\blumind.exe "%1"'
SectionEnd

Section -OnFinish
SectionEnd

Section Uninstall
	Delete "$INSTDIR\${PRODUCT_NAME}.url"
	Delete "$INSTDIR\UnInstall.exe"
	Delete "$INSTDIR\Blumind.exe"
	Delete "$INSTDIR\DocTypeReg.exe"
	Delete "$INSTDIR\Blumind Quick Help.bmd"

	RMDir "$INSTDIR"
	
	!insertmacro MUI_STARTMENU_GETFOLDER START_MENU_PAGE $R0

	Delete "$SMPROGRAMS\$R0\Uninstall.lnk"
	Delete "$SMPROGRAMS\$R0\${PRODUCT_NAME}.lnk"
	RMDir "$SMPROGRAMS\$R0"
	; Delete "$DESKTOP\${PRODUCT_FULLNAME}.lnk"

	DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
	DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
	SetAutoClose true

	; unregister file type
	ReadRegStr $R0 HKCR ".bmd" ""
	StrCmp $R0 "Blumind.MindMap" 0 +2
		DeleteRegKey HKCR ".bmd"

	DeleteRegKey HKCR "Blumind.MindMap"
SectionEnd
