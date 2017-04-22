::
::   File: ServerInstallation.bat
:: Author: Dalton Perkins
::
:: Description:
:: Install Two ARK Servers in a Cluster Setup. Configure them with Default ini Files
:: Create ease of use Shortcuts and finish will launch of both servers to install
:: the select mods.

@echo off

:: Prompt Program Info
echo	---------------------------------------------------------------------------
echo	***           Below is a List of what this Batch File Will Do           ***
echo	---------------------------------------------------------------------------
echo	     - Install Two ARK Servers and Cluster Folder which they will Share
echo	     - Configure the Custom Command lines and Configeration Files
echo	     - Add Batch Updater, Server Start, and Configeration Shortcuts
echo	     - Boot Both Servers once installation is complete to Install Mods
echo	---------------------------------------------------------------------------
echo.

timeout /t 1 /nobreak > NUL
pause

::Clear Screen Show Ports to Open on Firewal
test&cls

:: Prompt For Steamcmd
echo	---------------------------------------------------------------------------
echo	***      The Following Ports will Need to Be Open on your Firewall      ***
echo	---------------------------------------------------------------------------
echo	     - UDP 27015 Quary Port Steam (Server One)
echo	     - UDP 27016 Quary Port Steam (Server Two)
echo	     - UDP 7777  Game Port (Server One)
echo	     - UDP 7778  Raw UDP Socket Port (Server One)
echo	     - UDP 7779  Game Port (Server Two)
echo	     - UDP 7780  Raw UDP Socket Port (Server Two)
echo	     - TCP 27020 Remote RCON Port (Server One)
echo	     - TCP 27021 Remote RCON Port (Server Two)
echo	---------------------------------------------------------------------------
echo.

timeout /t 1 /nobreak > NUL
pause

::Clear Screen Once User Chooses to Begin
test&cls

:: Prompt For Steamcmd
echo	---------------------------------------------------------------------------
echo	***                Make Sure you have downloaded STEAMCMD               ***
echo	***               Extract steamcmd.exe to Desired Location              ***
echo	***             Run Steamcmd to Install all of its Contents             ***
echo	***         http://media.steampowered.com/installer/steamcmd.zip        ***
echo	---------------------------------------------------------------------------
echo.

:: Wait Before User Selects where Steamcmd is Installed
timeout /t 5 /nobreak > NUL

:: Allow User to Select where Steamcmd is Installed
echo	---------------------------------------------------------------------------
echo	***           Choose the location where you Installed Steamcmd          ***
echo	***                       Example - D:\Apps\Steam\                      ***
echo	---------------------------------------------------------------------------
echo.
set /p SteamLocation=Please Enter the Location of Steamcmd: 
echo.

:: Wait Before User Selects where Servers will be Installed
timeout /t 1 /nobreak > NUL

::Clear Screen After Input
test&cls

:: Allow User to Select where to Install the Servers
echo	---------------------------------------------------------------------------
echo	***             Choose an Install Directory for the Servers             ***
echo	***                        Example - D:\Servers\                        ***
echo	---------------------------------------------------------------------------
echo.
set /p ServerLocation=Enter Desired Server Location: 

:: Wait Before Promt Asking for Server One Directory Name
timeout /t 1 /nobreak > NUL

::Clear Screen After Input
test&cls

:: Allow User to Select Server One Directory Name
echo	---------------------------------------------------------------------------
echo	***             Choose a Directory Name for the First Server            ***
echo	***                   Example - ServerOne or TheIsland                  ***
echo	---------------------------------------------------------------------------
echo.
set /p ServerOneName=Desired Directory Name: 

:: Wait Before Promt Asking for Server Two Directory Name
timeout /t 1 /nobreak > NUL

:: Allow User to Select Server Two Directory Name
echo.
echo	---------------------------------------------------------------------------
echo	***             Choose a Directory Name for the First Server            ***
echo	***                 Example - ServerTwo or ScorchedEarth                ***
echo	---------------------------------------------------------------------------
echo.
set /p ServerTwoName=Desired Directory Name: 

:: Wait Before Promt Showing if Configuration is Correct
timeout /t 1 /nobreak > NUL

::Clear Screen After Input
test&cls

:: Prompt Before Server Will Be Installed
echo	---------------------------------------------------------------------------
echo	***    Installation of Both Servers will Take Place once you Continue   ***
echo	***                                                                     ***
echo	***            Double Check the Information Below is Correct            *** 
echo	---------------------------------------------------------------------------
echo.
echo	    Steamcmd File Location: %SteamLocation%steamcmd.exe
echo	         Server One Folder: %ServerLocation%%ServerOneName%\
echo	         Server Two Folder: %ServerLocation%%ServerTwoName%\
echo.
pause /t 5

::Clear Screen Before Install
test&cls

:: Prompt Before Server Will Be Installed
echo	---------------------------------------------------------------------------
echo	***               Server One is Starting Install Procedure              ***
echo	---------------------------------------------------------------------------
echo.

:: Wait Before Install Call
timeout /t 1 /nobreak > NUL

:: Create Folder Location if it doesn't exist
:: Master Folder is Server Contents
:: Files Folder is for Server Updater
if not exist %ServerLocation%%ServerOneName%\%ServerOneName%Master mkdir %ServerLocation%%ServerOneName%\%ServerOneName%Master
if not exist %ServerLocation%%ServerOneName%\%ServerOneName%Files mkdir %ServerLocation%%ServerOneName%\%ServerOneName%Files
timeout /t 1 /nobreak > NUL

:: Install Server One
    SET STEAMLOGIN=anonymous
    SET ARKserverBRANCH=376030
    SET ARKserverPath=%ServerLocation%%ServerOneName%\%ServerOneName%Master
    	SET STEAMPATH=%SteamLocation%
echo.
echo     You are about to Install Server One to
echo        Dir: %ARKserverPath%
echo.
timeout /t 5 /nobreak > NUL
%STEAMPATH%\steamcmd.exe +login %STEAMLOGIN% +force_install_dir %ARKserverPath% +"app_update %ARKserverBRANCH%" validate +quit

:: Wait Before Batch Update Prompt Is Called
timeout /t 1 /nobreak > NUL

::Clear Screen After Install
test&cls

:: Prompt Create Batch Update File
echo	---------------------------------------------------------------------------
echo	***                Created Server One Batch Updater File                ***     
echo	---------------------------------------------------------------------------
echo.

:: Wait Before Batch Updater
timeout /t 1 /nobreak > NUL

:: Create Boot Batch File for Server One
>%ServerLocation%%ServerOneName%\%ServerOneName%Files\ARK_Server_Update_.bat (
echo @echo off
echo @rem http://media.steampowered.com/installer/steamcmd.zip
echo SETLOCAL ENABLEDELAYEDEXPANSION
echo.
echo        :: DEFINE the following variables where applicable to your install
echo.
echo     SET STEAMLOGIN=anonymous
echo     SET ARKserverBRANCH=376030
echo.
echo     SET ARKserverPath=%ServerLocation%%ServerOneName%\%ServerOneName%Master
echo         SET STEAMPATH=%SteamLocation%
echo.
echo :: _________________________________________________________
echo.
echo echo.
echo echo     You are about to update Server One
echo echo        Dir: %%ARKserverPath%%
echo echo.
echo echo     Key "ENTER" to proceed
echo pause
echo %%STEAMPATH%%\steamcmd.exe +login %%STEAMLOGIN%% +force_install_dir %%ARKserverPath%% +"app_update %%ARKserverBRANCH%%" validate +quit
echo echo .
echo echo     Your ARK server is now up to date
echo echo     key "ENTER" to exit
echo pause
)

:: Prompt Before Server Will Be Installed
echo.
echo	---------------------------------------------------------------------------
echo	***    Server One is Now Installed, Proceeding to Install Server Two    ***
echo	---------------------------------------------------------------------------
echo.

:: Wait Before Install Call
timeout /t 5 /nobreak > NUL

:: Create Folder Location if it doesn't exist
:: Master Folder is Server Contents
:: Files Folder is for Server Updater
if not exist %ServerLocation%%ServerTwoName%\%ServerTwoName%Master mkdir %ServerLocation%%ServerTwoName%\%ServerTwoName%Master
if not exist %ServerLocation%%ServerTwoName%\%ServerTwoName%Files mkdir %ServerLocation%%ServerTwoName%\%ServerTwoName%Files
timeout /t 1 /nobreak > NUL

:: Install Server Two
    SET STEAMLOGIN=anonymous
    SET ARKserverBRANCH=376030
    SET ARKserverPath=%ServerLocation%%ServerTwoName%\%ServerTwoName%Master
    	SET STEAMPATH=%SteamLocation%
echo.
echo     You are about to Install Server Two to
echo        Dir: %ARKserverPath%
echo.

timeout /t 5 /nobreak > NUL
%STEAMPATH%\steamcmd.exe +login %STEAMLOGIN% +force_install_dir %ARKserverPath% +"app_update %ARKserverBRANCH%" validate +quit

:: Wait Before Batch Update Server Two Call
timeout /t 1 /nobreak > NUL

::Clear Screen After Install
test&cls

:: Prompt Create Batch Update File
echo	---------------------------------------------------------------------------
echo	***                Created Server Two Batch Updater File                ***     
echo	---------------------------------------------------------------------------
echo.

:: Wait Before Batch Update Prompt Is Called
timeout /t 1 /nobreak > NUL

:: Create Boot Batch File for Server Two
>%ServerLocation%%ServerTwoName%\%ServerTwoName%Files\ARK_Server_Update_.bat (
echo @echo off
echo @rem http://media.steampowered.com/installer/steamcmd.zip
echo SETLOCAL ENABLEDELAYEDEXPANSION
echo.
echo        :: DEFINE the following variables where applicable to your install
echo.
echo     SET STEAMLOGIN=anonymous
echo     SET ARKserverBRANCH=376030
echo.
echo     SET ARKserverPath=%ServerLocation%%ServerTwoName%\%ServerTwoName%Master
echo         SET STEAMPATH=%SteamLocation%
echo.
echo :: _________________________________________________________
echo.
echo echo.
echo echo     You are about to update Server Two
echo echo        Dir: %%ARKserverPath%%
echo echo.
echo echo     Key "ENTER" to proceed
echo pause
echo %%STEAMPATH%%\steamcmd.exe +login %%STEAMLOGIN%% +force_install_dir %%ARKserverPath%% +"app_update %%ARKserverBRANCH%%" validate +quit
echo echo .
echo echo     Your ARK server is now up to date
echo echo     key "ENTER" to exit
echo pause
)

:: Prompt After Both Server Installs
echo.
echo	---------------------------------------------------------------------------
echo	***   Server Two is Now Installed, Proceeding to Create Cluster Folder  ***
echo	---------------------------------------------------------------------------
echo.

:: Wait Before Cluster Folder Creation
timeout /t 1 /nobreak > NUL

:: Create Cluster Folder
if not exist %ServerLocation%"Cluster" mkdir %ServerLocation%"Cluster"

:: Prompt After Both Server Installs
echo.
echo	---------------------------------------------------------------------------
echo	***                        Cluster Folder Created                       ***
echo	---------------------------------------------------------------------------
echo.

timeout /t 5 /nobreak > NUL

::Clear Screen After Cluster is Finished
test&cls

:: Prompt After Both Server Installs
echo	---------------------------------------------------------------------------
echo	***         Configure Launch Parameters and Configuration Files         ***
echo	---------------------------------------------------------------------------
echo.
pause

:: Wait Before Editing Configs
timeout /t 1 /nobreak > NUL

:: Prompt Before Editing Configs for Server One
echo.
echo	---------------------------------------------------------------------------
echo	***                       Server One Config Files                       ***
echo	---------------------------------------------------------------------------
echo.

:: Wait Before Editing Configs for Server One
timeout /t 4 /nobreak > NUL

>%ServerLocation%%ServerOneName%\%ServerOneName%Master\ShooterGame\Binaries\Win64\ServerCommandLine.bat (
echo start ShooterGameServer.exe TheIsland?GameModIds=558079412,859041479,793605978,871075928,731604991,719928795,693416678,637517143?Port=7777?queryport=27001?maxplayers=20?SessionName="uDi PvP | 3xT 2.5xG | The Island | Cluster | Few Mods"?RCONEnabled=True?PreventDownloadSurvivors=False?PreventDownloadItems=False?PreventDownloadDinos=False?PreventUploadSurvivors=False?PreventUploadItems=False?PreventUploadDinos=False?RCONPort=27020 -automanagedmods -console -UseBattlEye -ClusterDirOverride=C:\Servers\ -clusterid=100 -culture=en -servergamelog -webalarms
echo exit
)

:: Create Folder Location since it doesn't exist
if not exist %ServerLocation%%ServerOneName%\%ServerOneName%Master\ShooterGame\Saved\Config\WindowsServer\ mkdir %ServerLocation%%ServerOneName%\%ServerOneName%Master\ShooterGame\Saved\Config\WindowsServer\
timeout /t 1 /nobreak > NUL

:: Wait Before Editing GameUserSettings.ini for Server One
timeout /t 1 /nobreak > NUL

:: Edit Config GameUserSettings.ini for Server One
>%ServerLocation%%ServerOneName%\%ServerOneName%Master\ShooterGame\Saved\Config\WindowsServer\GameUserSettings.ini (
echo [/Script/ShooterGame.ShooterGameUserSettings]
echo MasterAudioVolume=1.000000
echo MusicAudioVolume=1.000000
echo SFXAudioVolume=1.000000
echo VoiceAudioVolume=1.000000
echo UIScaling=1.000000
echo UIQuickbarScaling=1.000000
echo CameraShakeScale=1.000000
echo bFirstPersonRiding=False
echo bThirdPersonPlayer=False
echo bShowStatusNotificationMessages=True
echo TrueSkyQuality=0.700000
echo FOVMultiplier=1.000000
echo GroundClutterDensity=1.000000
echo bFilmGrain=False
echo bMotionBlur=False
echo bUseDFAO=False
echo bUseSSAO=True
echo bShowChatBox=True
echo bCameraViewBob=True
echo bInvertLookY=False
echo bFloatingNames=True
echo bChatBubbles=True
echo bHideServerInfo=False
echo bJoinNotifications=False
echo bCraftablesShowAllItems=False
echo bLocalInventoryShowAllItems=False
echo bRemoteInventoryShowAllItems=False
echo bRemoteInventoryShowEngrams=False
echo LookLeftRightSensitivity=1.000000
echo LookUpDownSensitivity=1.000000
echo GraphicsQuality=1
echo ActiveLingeringWorldTiles=7
echo ClientNetQuality=3
echo LastServerSearchType=0
echo LastDLCTypeSearchType=-1
echo LastServerSearchHideFull=False
echo LastServerSearchProtected=False
echo HideItemTextOverlay=True
echo bDistanceFieldShadowing=True
echo LODScalar=1.000000
echo bToggleToTalk=False
echo HighQualityMaterials=True
echo HighQualitySurfaces=True
echo bTemperatureF=False
echo bDisableTorporEffect=False
echo bChatShowSteamName=False
echo bChatShowTribeName=True
echo EmoteKeyBind1=0
echo EmoteKeyBind2=0
echo bNoBloodEffects=False
echo bLowQualityVFX=False
echo bSpectatorManualFloatingNames=False
echo bSuppressAdminIcon=False
echo bUseSimpleDistanceMovement=False
echo bDisableMeleeCameraSwingAnims=False
echo bHighQualityAnisotropicFiltering=False
echo bUseLowQualityLevelStreaming=True
echo bPreventInventoryOpeningSounds=False
echo bPreventItemCraftingSounds=False
echo bPreventHitMarkers=False
echo bPreventCrosshair=False
echo bPreventColorizedItemNames=False
echo bHighQualityLODs=False
echo bExtraLevelStreamingDistance=False
echo bEnableColorGrading=True
echo DOFSettingInterpTime=0.000000
echo bDisableBloom=False
echo bDisableLightShafts=False
echo bDisableMenuTransitions=False
echo bEnableInventoryItemTooltips=True
echo LastPVESearchType=-1
echo VersionMetaTag=1
echo bUseVSync=False
echo MacroCtrl0=
echo MacroCtrl1=
echo MacroCtrl2=
echo MacroCtrl3=
echo MacroCtrl4=
echo MacroCtrl5=
echo MacroCtrl6=
echo MacroCtrl7=
echo MacroCtrl8=
echo MacroCtrl9=
echo ResolutionSizeX=1280
echo ResolutionSizeY=720
echo LastUserConfirmedResolutionSizeX=1280
echo LastUserConfirmedResolutionSizeY=720
echo WindowPosX=-1
echo WindowPosY=-1
echo bUseDesktopResolutionForFullscreen=False
echo FullscreenMode=2
echo LastConfirmedFullscreenMode=2
echo Version=5
echo 
echo [ServerSettings]
echo AdminLogging=False
echo AllowAnyoneBabyImprintCuddle=True
echo AllowCaveBuildingPvE=True
echo AllowCrateSpawnsOnTopOfStructures=False
echo AllowFlyerCarryPvE=True
echo AllowFlyingStaminaRecovery=True
echo AllowHitMarkers=True
echo AllowMultipleAttachedC4=True
echo AllowRaidDinoFeeding=True
echo AllowThirdPersonPlayer=True
echo AlwaysNotifyPlayerJoined=False
echo AlwaysNotifyPlayerLeft=False
echo AutoDestroyDecayedDinos=true
echo AutoSavePeriodMinutes=15.0
echo BanlistURL=http:/playark.com/banlist.txt
echo ClampItemSpoilingTimes=False
echo DayCycleSpeedScale=0.28571432
echo DayTimeSpeedScale=0.6
echo DestroyUnconnectedWaterPipes=True
echo DifficultyOffset=1.0
echo DinoCharacterFoodDrainMultiplier=1.0
echo DinoCharacterHealthRecoveryMultiplier=1.0
echo DinoCharacterStaminaDrainMultiplier=1.0
echo DinoCountMultiplier=1.0
echo DinoDamageMultiplier=1.0
echo DinoResistanceMultiplier=1.0
echo DisableDinoDecayPvE=True
echo DisableImprintDinoBuff=True
echo DisableStructureDecayPvE=True
echo DontAlwaysNotifyPlayerJoined=True
echo EnableExtraStructurePreventionVolumes=True
echo EnablePVEGamma=True
echo EnablePvPGamma=False
echo GlobalVoiceChat=False
echo HarvestAmountMultiplier=2.5
echo KickIdlePlayersPeriod=3600
echo ListenServerTetherDistanceMultiplier=1.0
echo MaxPlatformSaddleStructureLimit=25
echo MaxStructuresInRange=10000
echo MaxTamedDinos=1000.0
echo NightTimeSpeedScale=3.0
echo NonPermanentDiseases=True
echo NoTributeDownloads=True
echo OverideStructurePlatformPrevention=True
echo OxygenSwimSpeedStatMultiplier=1.0
echo PerPlatformMaxStructuresMultiplier=3.0
echo PlayerCharacterFoodDrainMultiplier=0.5
echo PlayerCharacterHealthRecoveryMultiplier=1.0
echo PlayerCharacterStaminaDrainMultiplier=1.0
echo PlayerCharacterWaterDrainMultiplier=0.5
echo PlayerDamageMultiplier=1.0
echo PlayerResistanceMultiplier=1.0
echo PreventOfflinePvP=True
echo PreventOfflinePvPInterval=1800
echo ProximityChat=False
echo PvEAllowTribeWar=True
echo PvEAllowTribeWarCancel=False 1
echo PvEDinoDecayPeriodMultiplier=1.0
echo PvEStructureDecayDestructionPeriod=0.0
echo PvEStructureDecayPeriodMultiplier=1.0
echo PvPStructureDecay=False
echo RaidDinoCharacterFoodDrainMultiplier=1.0
echo RCONEnabled=True
echo RCONServerGameLogBuffer=600.0
echo ResourcesRespawnPeriodMultiplier=1.0
echo ServerAdminPassword=
echo ServerCrosshair=False
echo ServerForceNoHud=False
echo ServerGameLogIncludeTribeLogs=True
echo ServerHardcore=False
echo ServerPassword=
echo ServerPVE=True
echo ServerRCONOutputTribeLogs=True
echo ShowFloatingDamageText=True
echo ShowMapPlayerLocation=False
echo SpectatorPassword=
echo StructureDamageMultiplier=1.0
echo StructurePreventResourceRadiusMultiplier=1.0
echo StructureResistanceMultiplier=1.0
echo TamedDinoDamageMultiplier=1.0
echo TamedDinoResistanceMultiplier=1.0
echo TamingSpeedMultiplier=3.0
echo TributeCharacterExpirationSeconds=86400
echo TributeDinoExpirationSeconds=86400
echo TributeItemExpirationSeconds=86400
echo UseOptimizedHarvestingHealth=True
echo XPMultiplier=1.0
)

:: Wait Before Editing Game.ini for Server One
timeout /t 1 /nobreak > NUL

:: Edit Config Game.ini for Server One
>%ServerLocation%%ServerOneName%\%ServerOneName%Master\ShooterGame\Saved\Config\WindowsServer\Game.ini (
echo [/script/shootergame.shootergamemode]
echo AutoPvEStartTimeSeconds=0
echo AutoPvEStopTimeSeconds=43200
echo BabyCuddleGracePeriodMultiplier=1.0
echo BabyCuddleIntervalMultiplier=1.0
echo BabyCuddleLoseImprintQualitySpeedMultiplier=1.0
echo BabyFoodConsumptionSpeedMultiplier=1.0
echo BabyImprintingStatScaleMultiplier=1.0
echo BabyMatureSpeedMultiplier=2.0
echo bAutoPvETimer=False
echo bAutoPvEUseSystemTime=False
echo bDisableDinoRiding=False
echo bDisableDinoTaming=False
echo bDisableLootCrates=False
echo bFlyerPlatformAllowUnalignedDinoBasing=True
echo bIncreasePvPRespawnInterval=True
echo bOnlyAllowSpecifiedEngrams=True
echo bPassiveDefensesDamageRiderlessDinos=1.0
echo bPvEAllowTribeWar=True
echo bPvEAllowTribeWarCancel=False
echo bPvEDisableFriendlyFire=False
echo CropDecaySpeedMultiplier=1.0
echo CropGrowthSpeedMultiplier=1.0
echo CustomRecipeEffectivenessMultiplier=1.0
echo CustomRecipeSkillMultiplier=1.0
echo DinoHarvestingDamageMultiplier=1.0
echo DinoTurretDamageMultiplier=1.0
echo EggHatchSpeedMultiplier=2.0
echo GlobalCorpseDecompositionTimeMultiplier=1.0
echo GlobalItemDecompositionTimeMultiplier=1.0
echo GlobalSpoilingTimeMultiplier=1.5
echo HairGrowthSpeedMultiplier=1.0
echo IncreasePvPRespawnIntervalBaseAmount=60
echo IncreasePvPRespawnIntervalCheckPeriod=300
echo IncreasePvPRespawnIntervalMultiplier=2
echo KickIdlePlayersPeriod=3600
echo LayEggIntervalMultiplier=1.0
echo MatingIntervalMultiplier=1.0
echo MaxNumberOfPlayersInTribe=10
echo MaxTribeLogs=100
echo PlayerHarvestingDamageMultiplier=1.0
echo PoopIntervalMultiplier=1.0
echo PvPZoneStructureDamageMultiplier=1.0
echo ResourceNoReplenishRadiusPlayers=1.0
echo ResourceNoReplenishRadiusStructures=1.0
echo StructureDamageRepairCooldown=300
echo 
echo ConfigOverrideItemCraftingCosts=(ItemClassString="PrimalItemResource_SimpleTekElement_C",BaseCraftingResourceRequirements=((ResourceItemTypeString="PrimalItemArtifactGeneric_C",BaseResourceRequirement=1.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_Polymer_C",BaseResourceRequirement=60.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_Crystal_C",BaseResourceRequirement=10.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_Electronics_C",BaseResourceRequirement=30.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_BlackPearl_C",BaseResourceRequirement=30.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_MetalIngot_C",BaseResourceRequirement=150.0,bCraftingRequireExactResourceType=false^)^)^)
echo 
echo PerLevelStatsMultiplier_DinoTamed[1]=1.0
echo PerLevelStatsMultiplier_DinoTamed[2]=1.0
echo PerLevelStatsMultiplier_DinoTamed[3]=1.0
echo PerLevelStatsMultiplier_DinoTamed[4]=1.0
echo PerLevelStatsMultiplier_DinoTamed[5]=1.0
echo PerLevelStatsMultiplier_DinoTamed[6]=1.0
echo PerLevelStatsMultiplier_DinoTamed[7]=2.0
echo PerLevelStatsMultiplier_DinoTamed[8]=1.0
echo PerLevelStatsMultiplier_DinoTamed[9]=1.0
echo PerLevelStatsMultiplier_DinoTamed[0]=1.0
echo PerLevelStatsMultiplier_DinoTamed[10]=1.0
echo PerLevelStatsMultiplier_DinoTamed[11]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[1]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[2]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[3]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[4]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[5]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[6]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[7]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[8]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[9]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[10]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[11]=1.0
echo PerLevelStatsMultiplier_DinoWild[0]=1.0
echo PerLevelStatsMultiplier_DinoWild[1]=1.0
echo PerLevelStatsMultiplier_DinoWild[2]=1.0
echo PerLevelStatsMultiplier_DinoWild[3]=1.0
echo PerLevelStatsMultiplier_DinoWild[4]=1.0
echo PerLevelStatsMultiplier_DinoWild[5]=1.0
echo PerLevelStatsMultiplier_DinoWild[6]=1.0
echo PerLevelStatsMultiplier_DinoWild[7]=2.0
echo PerLevelStatsMultiplier_DinoWild[8]=1.0
echo PerLevelStatsMultiplier_DinoWild[9]=1.0
echo PerLevelStatsMultiplier_DinoWild[10]=1.0
echo PerLevelStatsMultiplier_DinoWild[11]=1.0
echo PerLevelStatsMultiplier_Player[0]=2.5
echo PerLevelStatsMultiplier_Player[1]=2.5
echo PerLevelStatsMultiplier_Player[2]=1.0
echo PerLevelStatsMultiplier_Player[3]=1.0
echo PerLevelStatsMultiplier_Player[4]=2.5
echo PerLevelStatsMultiplier_Player[5]=2.5
echo PerLevelStatsMultiplier_Player[6]=1.0
echo PerLevelStatsMultiplier_Player[7]=5.0
echo PerLevelStatsMultiplier_Player[8]=2.0
echo PerLevelStatsMultiplier_Player[9]=2.5
echo PerLevelStatsMultiplier_Player[10]=1.0
echo PerLevelStatsMultiplier_Player[11]=5.0
echo 
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Amarberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Azulberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Mejoberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Narcoberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Stimberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Tintoberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_JellyVenom_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_RawMeat_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_RawMeat_Fish_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_RawPrimeMeat_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_RawPrimeMeat_Fish_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_AmmoniteBlood_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_AnglerGel_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Argentavis_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Megalodon_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Rex_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Sauro_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Tuso_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_BlackPearl_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Chitin_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Crystal_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Fibers_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Flint_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Hair_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Hide_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Horn_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Keratin_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_KeratinSpike_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_LeechBlood_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Metal_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Obsidian_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Oil_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Pelt_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Polymer_Organic_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_RareFlower_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_RareMushroom_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_RawSalt_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Sap_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Silicon_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Silk_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_SquidOil_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Stone_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Sulfur_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Thatch_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Wood_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Wool_C",Multiplier=1^)
echo 
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Campfire_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneHatchet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneClub_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Spear_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_NotePaper_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Waterskin_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSign_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideSleepingBag_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Slingshot_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageBox_Small_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleBed_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Phiomia_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MortarAndPestle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Sparkpowder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BloodExtractor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Narcotic_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Paintbrush_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FlagSingle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Flag_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StandingTorch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodChair_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CookingPot_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinPaste_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Stimulant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gunpowder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FlareLauncher_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodShield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodCage_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Bola_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Compass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Spyglass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlot_Small_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gravestone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wardrums_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Para_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Dolphin_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeIntake_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeStraight_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeTap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RopeLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSpikeWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PaintingCanvas_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSign_Wall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TrainingDummy_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HidePants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Bow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ArrowStone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageBox_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodBench_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Furniture_WoodTable_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Raft_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Parachute_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BugRepel_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Pachy_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Raptor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Iguanodon_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeIntersection_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeInclined_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeVertical_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompostBin_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTank_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSign_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodRamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodGateway_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodGate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodPillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FeedingTrough_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ArrowTranq_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Toad_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TrophyWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CureLow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Forge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FishingRod_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Trike_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AlarmTrap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TrophyBase_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PreservingBin_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodCatwalk_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneGateWay_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneGate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MagnifyingGlass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Bookshelf_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AnvilBench_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Handcuffs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSpikeWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPick_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalHatchet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Pike_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Scissors_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_TerrorBird_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Equus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Crossbow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PoisonTrap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BearTrap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BearTrap_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_PachyRhino_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Direbear_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Scorpion_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Turtle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlot_Medium_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSign_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WallTorch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Radio_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GasGrenade_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BallistaTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BallistaArrow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneGateway_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneGateLarge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CatapultTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterJar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Fireplace_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TreePlatformWood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Stag_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalShield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Galli_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Sword_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Pistol_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Scope_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSickle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Stego_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Doed_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Paracer_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Grenade_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSign_Wall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Diplodocus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhilliePants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhillieShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhillieHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Manta_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TreeSapTap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BeerBarrel_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleRifle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleRifleBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlot_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Ptero_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Sarco_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleShotgun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleShotgunBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PoisonGrenade_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalRamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneCeilingWithTrapdoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneTrapdoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MiracleGro_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Lance_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Cannon_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CannonBall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhillieGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhillieBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Fabricator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Silencer_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Ankylo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Mammoth_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Spider_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Dunkle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Kaprosuchus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeIntake_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeStraight_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGateway_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Polymer_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Pela_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Electronics_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TripwireC4_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeIntersection_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeIncline_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeVertical_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeTap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTankMetal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Megalodon_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Baryonyx_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Saber_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Paracer_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Rhino_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Grill_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Flashlight_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GPS_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChainBola_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSign_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalCatwalk_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalCeilingWithTrapdoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalTrapdoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Thylaco_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Chalico_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Carno_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Tapejara_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Canteen_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GrapplingHook_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerGenerator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerCableStraight_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerOutlet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MachinedPistol_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MachinedShotgun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Keypad_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LamppostOmni_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Lamppost_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Camera_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WarMap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Allo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Arthro_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Procop_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerCableIncline_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerCableVertical_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerCableIntersection_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Basilosaurus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Argentavis_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Sauro_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IceBox_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AirConditioner_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WeaponC4_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_C4Ammo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MachinedRifle_C",EngramHidden=False,EngramPointsCost=0.,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedRifleBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Laser_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Beaver_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HoloScope_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGateway_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGate_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Therizino_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Rex_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Spino_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ModernBed_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TreePlatformMetal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SprayPainter_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TranqDart_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketLauncher_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketAmmo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Turret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Grinder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Quetz_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorTrack_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatformSmall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatformMedium_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatformLarge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MinersHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Tuso_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TransGPS_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TransGPSAmmo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageBox_Huge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Plesia_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MachinedSniper_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedSniperBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompoundBow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompoundArrow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Megalosaurus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Sauro_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotShield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ScubaShirt_SuitWithTank_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ScubaHelmet_Goggles_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ScubaBoots_Flippers_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ScubaPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SeaMine_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Mosa_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialCookingPot_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElectricProd_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Plesio_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Quetz_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialForge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MinigunTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Mosa_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Gigant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChemBench_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RefinedTranqDart_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SubstrateAbsorbent_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GasMask_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=90,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Titano_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_NightVisionGoggles_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=90,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AggroTranqDart_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=95,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PreservingSalt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Clay_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tent_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Boomerang_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WeaponWhip_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterWell_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Camelsaurus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Vessel_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Propellant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_OilJar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobePillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeRamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FlameArrow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeGateway_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeGate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothGooglesHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeCeilingWithDoorWay_Giant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeCeilingDoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Moth_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Mirror_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_SpineyLizard_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeGateway_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeGate_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChainSaw_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindTurbine_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Mantis_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClusterGrenade_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Flamethrower_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FlamethrowerAmmo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_OilPump_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_RockGolem_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketHommingAmmo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRifle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRexSaddle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekReplicator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekTransmitter_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekShield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tek_Gate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tek_Gate_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tek_Gategrame_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tek_Gategrame_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekCatwalk_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekGenerator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekTeleporter_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekMosaSaddle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekUnderwaterBase_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekUnderwaterBase_BottomEntry_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PlatformSmithy_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodPlatformWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodPlatformWedge_Large_Sloped_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWedgeOuter_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWedgeInner_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WedgeDoor_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPlatformWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPlatformWedge_Large_Sloped_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWedgeOuter_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWedgeInner_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WedgeDoor_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GlassMetalPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GlassMetalPlatformWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GlassMetalPlatformWedge_Large_Sloped_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GlassMetalOuterWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WedgeDoor_GlassMetal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPlatformWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPlatformWedge_Large_Sloped_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWedgeOuter_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWedgeInner_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableSpear_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableBola_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableFlareLauncher_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableParachute_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableGrapplingHook_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SuperSpyglass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=100,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SPlusCraftingStation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Thatch_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Thatch_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Wood_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Wood_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Catwalk_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Stone_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Stone_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Rope_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Metal_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Metal_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Catwalk_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Glass_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Glass_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Catwalk_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Greenhouse_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Greenhouse_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlotPlus_Small_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlotPlus_Medium_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlotPlus_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FabricatorPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGateway_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGateway_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeHorizontal_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIncline_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIntersection_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeVertical_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIntake_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTap_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeHorizontal_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIncline_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIntersection_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIntake_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeVertical_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTap_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Horizontal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Incline_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Intersection_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Vertical_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElectricalOutlet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Generator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorTrack_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatform_Small_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatform_Medium_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTank_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTank_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialCooker_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialForgePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialGrill_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AirConditionerPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChemBenchPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MortarPestlePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ForgePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmithyPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GrinderPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Adobe_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Adobe_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframe_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeTrapdoor_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframe_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLTrapdoor_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGateway_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TransparencyCycler_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ModelSelector_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ResourcePuller_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Staircase_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Staircase_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Staircase_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Staircase_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframe_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeTrapdoor_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframe_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeTrapdoor_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeTrapdoor_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframe_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLTrapdoor_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframe_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLTrapdoor_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLTrapdoor_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindTurbinePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MultiLamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InsulationNegator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TreeSapTapPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DemoGun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RepairGun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalPipe_Square_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalPipe_Wall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalWire_Square_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalWire_Wall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gardener_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframeSloped_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframeSloped_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframeSloped_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframeSloped_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframeSloped_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframeSloped_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AutoTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TurretConfigurator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FeedingTroughPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReplicatorPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StandingTorchPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WallTorchPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ItemCollector_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TransferGun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalPipe_Triangle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalWire_Triangle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BeerBarrelPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CampfirePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompostBinPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CookingPotPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FireplacePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PreservingBinPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FridgePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageSmall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageLarge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageMetal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_VaultPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SpikeWall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SpikeWall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeFlex_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeFlex_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Flex_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Catwalk_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGateway_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Tek_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Tek_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekForcefield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Sparkpowder2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Narcotic2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinPaste2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Stimulant2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gunpowder2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ArrowStone_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BugRepel2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ArrowTranq_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CureLow2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GasGrenade_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BallistaArrow_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Grenade_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleRifleBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleShotgunBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PoisonGrenade_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Polymer2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Electronics2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GrapplingHook_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_C4Ammo_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedRifleBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketAmmo_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TranqDart_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedSniperBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompoundArrow_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RefinedTranqDart_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SubstrateAbsorbent2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=95,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElementCraftingStation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo 
echo LevelExperienceRampOverrides=(ExperiencePointsForLevel[0]=5,ExperiencePointsForLevel[1]=20,ExperiencePointsForLevel[2]=45,ExperiencePointsForLevel[3]=80,ExperiencePointsForLevel[4]=125,ExperiencePointsForLevel[5]=180,ExperiencePointsForLevel[6]=245,ExperiencePointsForLevel[7]=320,ExperiencePointsForLevel[8]=405,ExperiencePointsForLevel[9]=510,ExperiencePointsForLevel[10]=635,ExperiencePointsForLevel[11]=780,ExperiencePointsForLevel[12]=945,ExperiencePointsForLevel[13]=1130,ExperiencePointsForLevel[14]=1335,ExperiencePointsForLevel[15]=1560,ExperiencePointsForLevel[16]=1805,ExperiencePointsForLevel[17]=2070,ExperiencePointsForLevel[18]=2355,ExperiencePointsForLevel[19]=2680,ExperiencePointsForLevel[20]=3045,ExperiencePointsForLevel[21]=3450,ExperiencePointsForLevel[22]=3895,ExperiencePointsForLevel[23]=4380,ExperiencePointsForLevel[24]=4905,ExperiencePointsForLevel[25]=5470,ExperiencePointsForLevel[26]=6075,ExperiencePointsForLevel[27]=6720,ExperiencePointsForLevel[28]=7405,ExperiencePointsForLevel[29]=8160,ExperiencePointsForLevel[30]=8985,ExperiencePointsForLevel[31]=9880,ExperiencePointsForLevel[32]=10845,ExperiencePointsForLevel[33]=11880,ExperiencePointsForLevel[34]=12985,ExperiencePointsForLevel[35]=14160,ExperiencePointsForLevel[36]=15405,ExperiencePointsForLevel[37]=16720,ExperiencePointsForLevel[38]=18105,ExperiencePointsForLevel[39]=19600,ExperiencePointsForLevel[40]=21205,ExperiencePointsForLevel[41]=22920,ExperiencePointsForLevel[42]=24745,ExperiencePointsForLevel[43]=26680,ExperiencePointsForLevel[44]=28725,ExperiencePointsForLevel[45]=30880,ExperiencePointsForLevel[46]=33145,ExperiencePointsForLevel[47]=35520,ExperiencePointsForLevel[48]=38005,ExperiencePointsForLevel[49]=40650,ExperiencePointsForLevel[50]=43455,ExperiencePointsForLevel[51]=46420,ExperiencePointsForLevel[52]=49545,ExperiencePointsForLevel[53]=52830,ExperiencePointsForLevel[54]=56275,ExperiencePointsForLevel[55]=59880,ExperiencePointsForLevel[56]=63645,ExperiencePointsForLevel[57]=67570,ExperiencePointsForLevel[58]=71655,ExperiencePointsForLevel[59]=75960,ExperiencePointsForLevel[60]=80485,ExperiencePointsForLevel[61]=85230,ExperiencePointsForLevel[62]=90195,ExperiencePointsForLevel[63]=95380,ExperiencePointsForLevel[64]=100785,ExperiencePointsForLevel[65]=106410,ExperiencePointsForLevel[66]=112255,ExperiencePointsForLevel[67]=118320,ExperiencePointsForLevel[68]=124605,ExperiencePointsForLevel[69]=131180,ExperiencePointsForLevel[70]=138045,ExperiencePointsForLevel[71]=145200,ExperiencePointsForLevel[72]=152645,ExperiencePointsForLevel[73]=160380,ExperiencePointsForLevel[74]=168405,ExperiencePointsForLevel[75]=176720,ExperiencePointsForLevel[76]=185325,ExperiencePointsForLevel[77]=194220,ExperiencePointsForLevel[78]=203405,ExperiencePointsForLevel[79]=212960,ExperiencePointsForLevel[80]=222885,ExperiencePointsForLevel[81]=233180,ExperiencePointsForLevel[82]=243845,ExperiencePointsForLevel[83]=254880,ExperiencePointsForLevel[84]=266285,ExperiencePointsForLevel[85]=278060,ExperiencePointsForLevel[86]=290205,ExperiencePointsForLevel[87]=302720,ExperiencePointsForLevel[88]=315605,ExperiencePointsForLevel[89]=328950,ExperiencePointsForLevel[90]=342755,ExperiencePointsForLevel[91]=357020,ExperiencePointsForLevel[92]=371745,ExperiencePointsForLevel[93]=386930,ExperiencePointsForLevel[94]=402575,ExperiencePointsForLevel[95]=418680,ExperiencePointsForLevel[96]=435245,ExperiencePointsForLevel[97]=452270,ExperiencePointsForLevel[98]=469755,ExperiencePointsForLevel[99]=487800,ExperiencePointsForLevel[100]=506405,ExperiencePointsForLevel[101]=525570,ExperiencePointsForLevel[102]=545295,ExperiencePointsForLevel[103]=565580,ExperiencePointsForLevel[104]=586425,ExperiencePointsForLevel[105]=607830,ExperiencePointsForLevel[106]=629795,ExperiencePointsForLevel[107]=652320,ExperiencePointsForLevel[108]=675405,ExperiencePointsForLevel[109]=699160,ExperiencePointsForLevel[110]=723585,ExperiencePointsForLevel[111]=748680,ExperiencePointsForLevel[112]=774445,ExperiencePointsForLevel[113]=800880,ExperiencePointsForLevel[114]=827985,ExperiencePointsForLevel[115]=855760,ExperiencePointsForLevel[116]=884205,ExperiencePointsForLevel[117]=913320,ExperiencePointsForLevel[118]=943105,ExperiencePointsForLevel[119]=973680,ExperiencePointsForLevel[120]=1005045,ExperiencePointsForLevel[121]=1037200,ExperiencePointsForLevel[122]=1070145,ExperiencePointsForLevel[123]=1103880,ExperiencePointsForLevel[124]=1138405,ExperiencePointsForLevel[125]=1173720,ExperiencePointsForLevel[126]=1209825,ExperiencePointsForLevel[127]=1246720,ExperiencePointsForLevel[128]=1284405,ExperiencePointsForLevel[129]=1323010,ExperiencePointsForLevel[130]=1362535,ExperiencePointsForLevel[131]=1402980,ExperiencePointsForLevel[132]=1444345,ExperiencePointsForLevel[133]=1486630,ExperiencePointsForLevel[134]=1529835,ExperiencePointsForLevel[135]=1573960,ExperiencePointsForLevel[136]=1619005,ExperiencePointsForLevel[137]=1664970,ExperiencePointsForLevel[138]=1711855,ExperiencePointsForLevel[139]=1759800,ExperiencePointsForLevel[140]=1808805,ExperiencePointsForLevel[141]=1858870,ExperiencePointsForLevel[142]=1909995,ExperiencePointsForLevel[143]=1962180,ExperiencePointsForLevel[144]=2015425,ExperiencePointsForLevel[145]=2069730,ExperiencePointsForLevel[146]=2125095,ExperiencePointsForLevel[147]=2181520,ExperiencePointsForLevel[148]=2239005^)
echo LevelExperienceRampOverrides=(ExperiencePointsForLevel[0]=5,ExperiencePointsForLevel[1]=20,ExperiencePointsForLevel[2]=45,ExperiencePointsForLevel[3]=80,ExperiencePointsForLevel[4]=125,ExperiencePointsForLevel[5]=180,ExperiencePointsForLevel[6]=245,ExperiencePointsForLevel[7]=320,ExperiencePointsForLevel[8]=405,ExperiencePointsForLevel[9]=500,ExperiencePointsForLevel[10]=605,ExperiencePointsForLevel[11]=720,ExperiencePointsForLevel[12]=845,ExperiencePointsForLevel[13]=980,ExperiencePointsForLevel[14]=1125,ExperiencePointsForLevel[15]=1280,ExperiencePointsForLevel[16]=1445,ExperiencePointsForLevel[17]=1620,ExperiencePointsForLevel[18]=1805,ExperiencePointsForLevel[19]=2000,ExperiencePointsForLevel[20]=2205,ExperiencePointsForLevel[21]=2420,ExperiencePointsForLevel[22]=2645,ExperiencePointsForLevel[23]=2880,ExperiencePointsForLevel[24]=3125,ExperiencePointsForLevel[25]=3380,ExperiencePointsForLevel[26]=3645,ExperiencePointsForLevel[27]=3920,ExperiencePointsForLevel[28]=4205,ExperiencePointsForLevel[29]=4500,ExperiencePointsForLevel[30]=4805,ExperiencePointsForLevel[31]=5120,ExperiencePointsForLevel[32]=5445,ExperiencePointsForLevel[33]=5780,ExperiencePointsForLevel[34]=6125,ExperiencePointsForLevel[35]=6480,ExperiencePointsForLevel[36]=6845,ExperiencePointsForLevel[37]=7220,ExperiencePointsForLevel[38]=7605,ExperiencePointsForLevel[39]=8000,ExperiencePointsForLevel[40]=8405,ExperiencePointsForLevel[41]=8820,ExperiencePointsForLevel[42]=9245,ExperiencePointsForLevel[43]=9680,ExperiencePointsForLevel[44]=10125,ExperiencePointsForLevel[45]=10580,ExperiencePointsForLevel[46]=11045,ExperiencePointsForLevel[47]=11520,ExperiencePointsForLevel[48]=12005,ExperiencePointsForLevel[49]=12500,ExperiencePointsForLevel[50]=13005,ExperiencePointsForLevel[51]=13520,ExperiencePointsForLevel[52]=14045,ExperiencePointsForLevel[53]=14580,ExperiencePointsForLevel[54]=15125,ExperiencePointsForLevel[55]=15680,ExperiencePointsForLevel[56]=16245,ExperiencePointsForLevel[57]=16820,ExperiencePointsForLevel[58]=17405,ExperiencePointsForLevel[59]=18000,ExperiencePointsForLevel[60]=18605,ExperiencePointsForLevel[61]=19220,ExperiencePointsForLevel[62]=19845,ExperiencePointsForLevel[63]=20480,ExperiencePointsForLevel[64]=21125,ExperiencePointsForLevel[65]=21780,ExperiencePointsForLevel[66]=22445,ExperiencePointsForLevel[67]=23120,ExperiencePointsForLevel[68]=23805,ExperiencePointsForLevel[69]=24500,ExperiencePointsForLevel[70]=25205,ExperiencePointsForLevel[71]=25920,ExperiencePointsForLevel[72]=26645,ExperiencePointsForLevel[73]=27380,ExperiencePointsForLevel[74]=28125,ExperiencePointsForLevel[75]=28880,ExperiencePointsForLevel[76]=29645,ExperiencePointsForLevel[77]=30420,ExperiencePointsForLevel[78]=31205,ExperiencePointsForLevel[79]=32000,ExperiencePointsForLevel[80]=32805,ExperiencePointsForLevel[81]=33620,ExperiencePointsForLevel[82]=34445,ExperiencePointsForLevel[83]=35280,ExperiencePointsForLevel[84]=36125,ExperiencePointsForLevel[85]=36980,ExperiencePointsForLevel[86]=37845,ExperiencePointsForLevel[87]=38720,ExperiencePointsForLevel[88]=39605,ExperiencePointsForLevel[89]=40500,ExperiencePointsForLevel[90]=41405,ExperiencePointsForLevel[91]=42320,ExperiencePointsForLevel[92]=43245,ExperiencePointsForLevel[93]=44180,ExperiencePointsForLevel[94]=45125,ExperiencePointsForLevel[95]=46080,ExperiencePointsForLevel[96]=47045,ExperiencePointsForLevel[97]=48020,ExperiencePointsForLevel[98]=49005,ExperiencePointsForLevel[99]=50000,ExperiencePointsForLevel[100]=51005,ExperiencePointsForLevel[101]=52020,ExperiencePointsForLevel[102]=53045,ExperiencePointsForLevel[103]=54080,ExperiencePointsForLevel[104]=55125,ExperiencePointsForLevel[105]=56180,ExperiencePointsForLevel[106]=57245,ExperiencePointsForLevel[107]=58320,ExperiencePointsForLevel[108]=59405,ExperiencePointsForLevel[109]=60500,ExperiencePointsForLevel[110]=61605,ExperiencePointsForLevel[111]=62720,ExperiencePointsForLevel[112]=63845,ExperiencePointsForLevel[113]=64980,ExperiencePointsForLevel[114]=66125,ExperiencePointsForLevel[115]=67280,ExperiencePointsForLevel[116]=68445,ExperiencePointsForLevel[117]=69620,ExperiencePointsForLevel[118]=70805,ExperiencePointsForLevel[119]=72000,ExperiencePointsForLevel[120]=73205,ExperiencePointsForLevel[121]=74420,ExperiencePointsForLevel[122]=75645,ExperiencePointsForLevel[123]=76880,ExperiencePointsForLevel[124]=78125,ExperiencePointsForLevel[125]=79380,ExperiencePointsForLevel[126]=80645,ExperiencePointsForLevel[127]=81920,ExperiencePointsForLevel[128]=83205,ExperiencePointsForLevel[129]=84500,ExperiencePointsForLevel[130]=85805,ExperiencePointsForLevel[131]=87120,ExperiencePointsForLevel[132]=88445,ExperiencePointsForLevel[133]=89780,ExperiencePointsForLevel[134]=91125,ExperiencePointsForLevel[135]=92480,ExperiencePointsForLevel[136]=93845,ExperiencePointsForLevel[137]=95220,ExperiencePointsForLevel[138]=96605,ExperiencePointsForLevel[139]=98000,ExperiencePointsForLevel[140]=99405,ExperiencePointsForLevel[141]=100820,ExperiencePointsForLevel[142]=102245,ExperiencePointsForLevel[143]=103680,ExperiencePointsForLevel[144]=105125,ExperiencePointsForLevel[145]=106580,ExperiencePointsForLevel[146]=108045,ExperiencePointsForLevel[147]=109520,ExperiencePointsForLevel[148]=111005,ExperiencePointsForLevel[149]=112500^)
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverrideMaxExperiencePointsPlayer=2240000
echo OverrideMaxExperiencePointsDino=126000
)

:: Prompt Before Editing Configs for Server Two
echo.
echo	---------------------------------------------------------------------------
echo	***                       Server Two Config Files                       ***
echo	---------------------------------------------------------------------------
echo.

:: Wait Before Editing Configs for Server Two
timeout /t 5 /nobreak > NUL

>%ServerLocation%%ServerTwoName%\%ServerTwoName%Master\ShooterGame\Binaries\Win64\ServerCommandLine.bat (
echo start ShooterGameServer.exe ScorchedEarth_P?GameModIds=558079412,859041479,793605978,871075928,731604991,719928795,693416678,637517143?Port=7779?queryport=27002?maxplayers=20?SessionName="uDi PvP | 3xT 2.5xG | Scorched Earth | Cluster | Few Mods"?RCONEnabled=True?PreventDownloadSurvivors=False?PreventDownloadItems=False?PreventDownloadDinos=False?PreventUploadSurvivors=False?PreventUploadItems=False?PreventUploadDinos=False?RCONPort=27021 -automanagedmods -console -UseBattlEye -ClusterDirOverride=C:\Servers\ -clusterid=100 -culture=en -servergamelog -webalarms
echo exit
)

:: Create Folder Location since it doesn't exist
if not exist %ServerLocation%%ServerTwoName%\%ServerTwoName%Master\ShooterGame\Saved\Config\WindowsServer\ mkdir %ServerLocation%%ServerTwoName%\%ServerTwoName%Master\ShooterGame\Saved\Config\WindowsServer\
timeout /t 1 /nobreak > NUL

:: Wait Before Editing GameUserSettings.ini for Server One
timeout /t 1 /nobreak > NUL

:: Edit Config GameUserSettings.ini for Server Two
>%ServerLocation%%ServerTwoName%\%ServerTwoName%Master\ShooterGame\Saved\Config\WindowsServer\GameUserSettings.ini (
echo [/Script/ShooterGame.ShooterGameUserSettings]
echo MasterAudioVolume=1.000000
echo MusicAudioVolume=1.000000
echo SFXAudioVolume=1.000000
echo VoiceAudioVolume=1.000000
echo UIScaling=1.000000
echo UIQuickbarScaling=1.000000
echo CameraShakeScale=1.000000
echo bFirstPersonRiding=False
echo bThirdPersonPlayer=False
echo bShowStatusNotificationMessages=True
echo TrueSkyQuality=0.700000
echo FOVMultiplier=1.000000
echo GroundClutterDensity=1.000000
echo bFilmGrain=False
echo bMotionBlur=False
echo bUseDFAO=False
echo bUseSSAO=True
echo bShowChatBox=True
echo bCameraViewBob=True
echo bInvertLookY=False
echo bFloatingNames=True
echo bChatBubbles=True
echo bHideServerInfo=False
echo bJoinNotifications=False
echo bCraftablesShowAllItems=False
echo bLocalInventoryShowAllItems=False
echo bRemoteInventoryShowAllItems=False
echo bRemoteInventoryShowEngrams=False
echo LookLeftRightSensitivity=1.000000
echo LookUpDownSensitivity=1.000000
echo GraphicsQuality=1
echo ActiveLingeringWorldTiles=7
echo ClientNetQuality=3
echo LastServerSearchType=0
echo LastDLCTypeSearchType=-1
echo LastServerSearchHideFull=False
echo LastServerSearchProtected=False
echo HideItemTextOverlay=True
echo bDistanceFieldShadowing=True
echo LODScalar=1.000000
echo bToggleToTalk=False
echo HighQualityMaterials=True
echo HighQualitySurfaces=True
echo bTemperatureF=False
echo bDisableTorporEffect=False
echo bChatShowSteamName=False
echo bChatShowTribeName=True
echo EmoteKeyBind1=0
echo EmoteKeyBind2=0
echo bNoBloodEffects=False
echo bLowQualityVFX=False
echo bSpectatorManualFloatingNames=False
echo bSuppressAdminIcon=False
echo bUseSimpleDistanceMovement=False
echo bDisableMeleeCameraSwingAnims=False
echo bHighQualityAnisotropicFiltering=False
echo bUseLowQualityLevelStreaming=True
echo bPreventInventoryOpeningSounds=False
echo bPreventItemCraftingSounds=False
echo bPreventHitMarkers=False
echo bPreventCrosshair=False
echo bPreventColorizedItemNames=False
echo bHighQualityLODs=False
echo bExtraLevelStreamingDistance=False
echo bEnableColorGrading=True
echo DOFSettingInterpTime=0.000000
echo bDisableBloom=False
echo bDisableLightShafts=False
echo bDisableMenuTransitions=False
echo bEnableInventoryItemTooltips=True
echo LastPVESearchType=-1
echo VersionMetaTag=1
echo bUseVSync=False
echo MacroCtrl0=
echo MacroCtrl1=
echo MacroCtrl2=
echo MacroCtrl3=
echo MacroCtrl4=
echo MacroCtrl5=
echo MacroCtrl6=
echo MacroCtrl7=
echo MacroCtrl8=
echo MacroCtrl9=
echo ResolutionSizeX=1280
echo ResolutionSizeY=720
echo LastUserConfirmedResolutionSizeX=1280
echo LastUserConfirmedResolutionSizeY=720
echo WindowPosX=-1
echo WindowPosY=-1
echo bUseDesktopResolutionForFullscreen=False
echo FullscreenMode=2
echo LastConfirmedFullscreenMode=2
echo Version=5
echo 
echo [ServerSettings]
echo AdminLogging=False
echo AllowAnyoneBabyImprintCuddle=True
echo AllowCaveBuildingPvE=True
echo AllowCrateSpawnsOnTopOfStructures=False
echo AllowFlyerCarryPvE=True
echo AllowFlyingStaminaRecovery=True
echo AllowHitMarkers=True
echo AllowMultipleAttachedC4=True
echo AllowRaidDinoFeeding=True
echo AllowThirdPersonPlayer=True
echo AlwaysNotifyPlayerJoined=False
echo AlwaysNotifyPlayerLeft=False
echo AutoDestroyDecayedDinos=true
echo AutoSavePeriodMinutes=15.0
echo BanlistURL=http:/playark.com/banlist.txt
echo ClampItemSpoilingTimes=False
echo DayCycleSpeedScale=0.28571432
echo DayTimeSpeedScale=0.6
echo DestroyUnconnectedWaterPipes=True
echo DifficultyOffset=1.0
echo DinoCharacterFoodDrainMultiplier=1.0
echo DinoCharacterHealthRecoveryMultiplier=1.0
echo DinoCharacterStaminaDrainMultiplier=1.0
echo DinoCountMultiplier=1.0
echo DinoDamageMultiplier=1.0
echo DinoResistanceMultiplier=1.0
echo DisableDinoDecayPvE=True
echo DisableImprintDinoBuff=True
echo DisableStructureDecayPvE=True
echo DontAlwaysNotifyPlayerJoined=True
echo EnableExtraStructurePreventionVolumes=True
echo EnablePVEGamma=True
echo EnablePvPGamma=False
echo GlobalVoiceChat=False
echo HarvestAmountMultiplier=2.5
echo KickIdlePlayersPeriod=3600
echo ListenServerTetherDistanceMultiplier=1.0
echo MaxPlatformSaddleStructureLimit=25
echo MaxStructuresInRange=10000
echo MaxTamedDinos=1000.0
echo NightTimeSpeedScale=3.0
echo NonPermanentDiseases=True
echo NoTributeDownloads=True
echo OverideStructurePlatformPrevention=True
echo OxygenSwimSpeedStatMultiplier=1.0
echo PerPlatformMaxStructuresMultiplier=3.0
echo PlayerCharacterFoodDrainMultiplier=0.5
echo PlayerCharacterHealthRecoveryMultiplier=1.0
echo PlayerCharacterStaminaDrainMultiplier=1.0
echo PlayerCharacterWaterDrainMultiplier=0.5
echo PlayerDamageMultiplier=1.0
echo PlayerResistanceMultiplier=1.0
echo PreventOfflinePvP=True
echo PreventOfflinePvPInterval=1800
echo ProximityChat=False
echo PvEAllowTribeWar=True
echo PvEAllowTribeWarCancel=False 1
echo PvEDinoDecayPeriodMultiplier=1.0
echo PvEStructureDecayDestructionPeriod=0.0
echo PvEStructureDecayPeriodMultiplier=1.0
echo PvPStructureDecay=False
echo RaidDinoCharacterFoodDrainMultiplier=1.0
echo RCONEnabled=True
echo RCONServerGameLogBuffer=600.0
echo ResourcesRespawnPeriodMultiplier=1.0
echo ServerAdminPassword=
echo ServerCrosshair=False
echo ServerForceNoHud=False
echo ServerGameLogIncludeTribeLogs=True
echo ServerHardcore=False
echo ServerPassword=
echo ServerPVE=False
echo ServerRCONOutputTribeLogs=True
echo ShowFloatingDamageText=True
echo ShowMapPlayerLocation=False
echo SpectatorPassword=
echo StructureDamageMultiplier=1.0
echo StructurePreventResourceRadiusMultiplier=1.0
echo StructureResistanceMultiplier=1.0
echo TamedDinoDamageMultiplier=1.0
echo TamedDinoResistanceMultiplier=1.0
echo TamingSpeedMultiplier=3.0
echo TributeCharacterExpirationSeconds=86400
echo TributeDinoExpirationSeconds=86400
echo TributeItemExpirationSeconds=86400
echo UseOptimizedHarvestingHealth=True
echo XPMultiplier=1.0
)

:: Wait Before Editing Game.ini for Server Two
timeout /t 1 /nobreak > NUL

:: Edit Config Game.ini for Server Two
>%ServerLocation%%ServerTwoName%\%ServerTwoName%Master\ShooterGame\Saved\Config\WindowsServer\Game.ini (
echo [/script/shootergame.shootergamemode]
echo AutoPvEStartTimeSeconds=0
echo AutoPvEStopTimeSeconds=43200
echo BabyCuddleGracePeriodMultiplier=1.0
echo BabyCuddleIntervalMultiplier=1.0
echo BabyCuddleLoseImprintQualitySpeedMultiplier=1.0
echo BabyFoodConsumptionSpeedMultiplier=1.0
echo BabyImprintingStatScaleMultiplier=1.0
echo BabyMatureSpeedMultiplier=2.0
echo bAutoPvETimer=False
echo bAutoPvEUseSystemTime=False
echo bDisableDinoRiding=False
echo bDisableDinoTaming=False
echo bDisableLootCrates=False
echo bFlyerPlatformAllowUnalignedDinoBasing=True
echo bIncreasePvPRespawnInterval=True
echo bOnlyAllowSpecifiedEngrams=True
echo bPassiveDefensesDamageRiderlessDinos=1.0
echo bPvEAllowTribeWar=True
echo bPvEAllowTribeWarCancel=False
echo bPvEDisableFriendlyFire=False
echo CropDecaySpeedMultiplier=1.0
echo CropGrowthSpeedMultiplier=1.0
echo CustomRecipeEffectivenessMultiplier=1.0
echo CustomRecipeSkillMultiplier=1.0
echo DinoHarvestingDamageMultiplier=1.0
echo DinoTurretDamageMultiplier=1.0
echo EggHatchSpeedMultiplier=2.0
echo GlobalCorpseDecompositionTimeMultiplier=1.0
echo GlobalItemDecompositionTimeMultiplier=1.0
echo GlobalSpoilingTimeMultiplier=1.5
echo HairGrowthSpeedMultiplier=1.0
echo IncreasePvPRespawnIntervalBaseAmount=60
echo IncreasePvPRespawnIntervalCheckPeriod=300
echo IncreasePvPRespawnIntervalMultiplier=2
echo KickIdlePlayersPeriod=3600
echo LayEggIntervalMultiplier=1.0
echo MatingIntervalMultiplier=1.0
echo MaxNumberOfPlayersInTribe=10
echo MaxTribeLogs=100
echo PlayerHarvestingDamageMultiplier=1.0
echo PoopIntervalMultiplier=1.0
echo PvPZoneStructureDamageMultiplier=1.0
echo ResourceNoReplenishRadiusPlayers=1.0
echo ResourceNoReplenishRadiusStructures=1.0
echo StructureDamageRepairCooldown=300
echo 
echo ConfigOverrideItemCraftingCosts=(ItemClassString="PrimalItemResource_SimpleTekElement_C",BaseCraftingResourceRequirements=((ResourceItemTypeString="PrimalItemArtifactGeneric_C",BaseResourceRequirement=1.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_Polymer_C",BaseResourceRequirement=60.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_Crystal_C",BaseResourceRequirement=10.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_Electronics_C",BaseResourceRequirement=30.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_BlackPearl_C",BaseResourceRequirement=30.0,bCraftingRequireExactResourceType=false^),(ResourceItemTypeString="PrimalItemResource_MetalIngot_C",BaseResourceRequirement=150.0,bCraftingRequireExactResourceType=false^)^)^)
echo 
echo PerLevelStatsMultiplier_DinoTamed[1]=1.0
echo PerLevelStatsMultiplier_DinoTamed[2]=1.0
echo PerLevelStatsMultiplier_DinoTamed[3]=1.0
echo PerLevelStatsMultiplier_DinoTamed[4]=1.0
echo PerLevelStatsMultiplier_DinoTamed[5]=1.0
echo PerLevelStatsMultiplier_DinoTamed[6]=1.0
echo PerLevelStatsMultiplier_DinoTamed[7]=2.0
echo PerLevelStatsMultiplier_DinoTamed[8]=1.0
echo PerLevelStatsMultiplier_DinoTamed[9]=1.0
echo PerLevelStatsMultiplier_DinoTamed[0]=1.0
echo PerLevelStatsMultiplier_DinoTamed[10]=1.0
echo PerLevelStatsMultiplier_DinoTamed[11]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[1]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[2]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[3]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[4]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[5]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[6]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[7]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[8]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[9]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[10]=1.0
echo PerLevelStatsMultiplier_DinoTamed_Affinity[11]=1.0
echo PerLevelStatsMultiplier_DinoWild[0]=1.0
echo PerLevelStatsMultiplier_DinoWild[1]=1.0
echo PerLevelStatsMultiplier_DinoWild[2]=1.0
echo PerLevelStatsMultiplier_DinoWild[3]=1.0
echo PerLevelStatsMultiplier_DinoWild[4]=1.0
echo PerLevelStatsMultiplier_DinoWild[5]=1.0
echo PerLevelStatsMultiplier_DinoWild[6]=1.0
echo PerLevelStatsMultiplier_DinoWild[7]=2.0
echo PerLevelStatsMultiplier_DinoWild[8]=1.0
echo PerLevelStatsMultiplier_DinoWild[9]=1.0
echo PerLevelStatsMultiplier_DinoWild[10]=1.0
echo PerLevelStatsMultiplier_DinoWild[11]=1.0
echo PerLevelStatsMultiplier_Player[0]=2.5
echo PerLevelStatsMultiplier_Player[1]=2.5
echo PerLevelStatsMultiplier_Player[2]=1.0
echo PerLevelStatsMultiplier_Player[3]=1.0
echo PerLevelStatsMultiplier_Player[4]=2.5
echo PerLevelStatsMultiplier_Player[5]=2.5
echo PerLevelStatsMultiplier_Player[6]=1.0
echo PerLevelStatsMultiplier_Player[7]=5.0
echo PerLevelStatsMultiplier_Player[8]=2.0
echo PerLevelStatsMultiplier_Player[9]=2.5
echo PerLevelStatsMultiplier_Player[10]=1.0
echo PerLevelStatsMultiplier_Player[11]=5.0
echo 
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Amarberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Azulberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Mejoberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Narcoberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Stimberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_Berry_Tintoberry_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_JellyVenom_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_RawMeat_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_RawMeat_Fish_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_RawPrimeMeat_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemConsumable_RawPrimeMeat_Fish_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_AmmoniteBlood_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_AnglerGel_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Argentavis_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Megalodon_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Rex_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Sauro_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_ApexDrop_Tuso_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_BlackPearl_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Chitin_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Crystal_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Fibers_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Flint_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Hair_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Hide_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Horn_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Keratin_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_KeratinSpike_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_LeechBlood_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Metal_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Obsidian_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Oil_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Pelt_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Polymer_Organic_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_RareFlower_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_RareMushroom_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_RawSalt_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Sap_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Silicon_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Silk_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_SquidOil_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Stone_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Sulfur_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Thatch_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Wood_C",Multiplier=1^)
echo HarvestResourceItemAmountClassMultipliers=(ClassName = "PrimalItemResource_Wool_C",Multiplier=1^)
echo 
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Campfire_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneHatchet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneClub_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Spear_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_NotePaper_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Waterskin_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClothHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSign_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideSleepingBag_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=3,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Slingshot_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageBox_Small_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleBed_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Phiomia_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MortarAndPestle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Sparkpowder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BloodExtractor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Narcotic_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Paintbrush_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FlagSingle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Flag_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StandingTorch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ThatchRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodChair_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CookingPot_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinPaste_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Stimulant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gunpowder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FlareLauncher_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodShield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodCage_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Bola_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Compass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Spyglass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlot_Small_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gravestone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wardrums_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Para_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Dolphin_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeIntake_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeStraight_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeTap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RopeLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSpikeWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PaintingCanvas_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSign_Wall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TrainingDummy_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HidePants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Bow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ArrowStone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageBox_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodBench_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Furniture_WoodTable_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Raft_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Parachute_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BugRepel_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Pachy_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Raptor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Iguanodon_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeIntersection_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeInclined_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePipeVertical_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompostBin_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTank_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodSign_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodRamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodGateway_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodGate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodPillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FeedingTrough_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HideHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ArrowTranq_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Toad_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TrophyWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CureLow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Forge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FishingRod_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Trike_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AlarmTrap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TrophyBase_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PreservingBin_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodCatwalk_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneGateWay_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneGate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MagnifyingGlass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Bookshelf_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AnvilBench_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Handcuffs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSpikeWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPick_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalHatchet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Pike_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Scissors_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_TerrorBird_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Equus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FurShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Crossbow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PoisonTrap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BearTrap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BearTrap_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_PachyRhino_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Direbear_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Scorpion_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Turtle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlot_Medium_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSign_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WallTorch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StonePillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Radio_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GasGrenade_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BallistaTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BallistaArrow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneGateway_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneGateLarge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CatapultTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterJar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Fireplace_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TreePlatformWood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Stag_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalShield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Galli_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Sword_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Pistol_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Scope_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSickle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Stego_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Doed_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Paracer_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Grenade_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSign_Wall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Diplodocus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhilliePants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhillieShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhillieHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Manta_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TreeSapTap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BeerBarrel_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleRifle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleRifleBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlot_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Ptero_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Sarco_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleShotgun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleShotgunBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PoisonGrenade_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalRamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneCeilingWithTrapdoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StoneTrapdoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MiracleGro_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Lance_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Cannon_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CannonBall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhillieGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GhillieBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Fabricator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Silencer_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Ankylo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Mammoth_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Spider_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Dunkle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Kaprosuchus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeIntake_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeStraight_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGateway_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Polymer_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Pela_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Electronics_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TripwireC4_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeIntersection_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeIncline_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeVertical_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPipeTap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTankMetal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Megalodon_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Baryonyx_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Saber_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Paracer_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Rhino_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Grill_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Flashlight_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GPS_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChainBola_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalSign_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalCatwalk_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GreenhouseWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalCeilingWithTrapdoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalTrapdoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Thylaco_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Chalico_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Carno_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Tapejara_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Canteen_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GrapplingHook_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerGenerator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerCableStraight_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerOutlet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MachinedPistol_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MachinedShotgun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Keypad_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LamppostOmni_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Lamppost_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Camera_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WarMap_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Allo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Arthro_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Procop_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerCableIncline_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerCableVertical_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PowerCableIntersection_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Basilosaurus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Argentavis_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Sauro_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IceBox_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AirConditioner_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WeaponC4_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_C4Ammo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MachinedRifle_C",EngramHidden=False,EngramPointsCost=0.,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedRifleBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Laser_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Beaver_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_HoloScope_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGateway_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalGate_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Therizino_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Rex_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Spino_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ModernBed_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TreePlatformMetal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SprayPainter_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TranqDart_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketLauncher_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketAmmo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Turret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Grinder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Quetz_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorTrack_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatformSmall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatformMedium_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatformLarge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MinersHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Tuso_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TransGPS_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TransGPSAmmo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageBox_Huge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Plesia_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MachinedSniper_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedSniperBullet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompoundBow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompoundArrow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Megalosaurus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Sauro_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotShield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ScubaShirt_SuitWithTank_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ScubaHelmet_Goggles_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ScubaBoots_Flippers_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ScubaPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SeaMine_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Mosa_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialCookingPot_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElectricProd_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Plesio_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Quetz_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RiotHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=80,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialForge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MinigunTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Mosa_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Gigant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChemBench_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RefinedTranqDart_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SubstrateAbsorbent_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GasMask_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=90,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Titano_Platform_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_NightVisionGoggles_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=90,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AggroTranqDart_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=95,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PreservingSalt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Clay_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tent_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Boomerang_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WeaponWhip_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterWell_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Camelsaurus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Vessel_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Propellant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_OilJar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobePillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeRamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FlameArrow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeGateway_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeGate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothGooglesHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DesertClothBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeCeilingWithDoorWay_Giant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeCeilingDoorGiant_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Moth_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Mirror_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_SpineyLizard_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeGateway_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdobeGate_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChainSaw_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindTurbine_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=45,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_Mantis_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ClusterGrenade_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Flamethrower_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FlamethrowerAmmo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_OilPump_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Saddle_RockGolem_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketHommingAmmo_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=75,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekBoots_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekGloves_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekHelmet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPants_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekShirt_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRifle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRexSaddle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekReplicator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekTransmitter_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekShield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tek_Gate_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tek_Gate_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tek_Gategrame_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Tek_Gategrame_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekCatwalk_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekCeiling_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekCeilingWithTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekFloor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekLadder_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPillar_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekTrapdoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWallWithDoor_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWallWithWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWindow_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekSlopedWall_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekSlopedWall_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekStairs_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRoof_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekRailing_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekFenceFoundation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekGenerator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekTeleporter_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekMosaSaddle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekUnderwaterBase_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekUnderwaterBase_BottomEntry_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PlatformSmithy_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodPlatformWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodPlatformWedge_Large_Sloped_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWedgeOuter_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WoodWedgeInner_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WedgeDoor_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPlatformWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalPlatformWedge_Large_Sloped_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWedgeOuter_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MetalWedgeInner_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WedgeDoor_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GlassMetalPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GlassMetalPlatformWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GlassMetalPlatformWedge_Large_Sloped_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GlassMetalOuterWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WedgeDoor_GlassMetal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPlatformWedge_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekPlatformWedge_Large_Sloped_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWedgeOuter_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekWedgeInner_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableSpear_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=2,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableBola_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableFlareLauncher_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableParachute_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReusableGrapplingHook_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SuperSpyglass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=100,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SPlusCraftingStation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Thatch_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Thatch_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Thatch_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Wood_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Wood_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Catwalk_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Stone_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Stone_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Rope_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Metal_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Metal_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Catwalk_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Glass_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Glass_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Catwalk_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Greenhouse_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Greenhouse_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlotPlus_Small_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlotPlus_Medium_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CropPlotPlus_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FabricatorPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGateway_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGateway_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeHorizontal_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIncline_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIntersection_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeVertical_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIntake_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTap_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeHorizontal_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIncline_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIntersection_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeIntake_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeVertical_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTap_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Horizontal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Incline_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Intersection_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Vertical_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElectricalOutlet_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Generator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorTrack_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatform_Small_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatform_Medium_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElevatorPlatform_Large_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTank_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WaterTank_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialCooker_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialForgePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_IndustrialGrill_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AirConditionerPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChemBenchPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MortarPestlePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ForgePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmithyPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GrinderPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Adobe_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Adobe_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframe_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeTrapdoor_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframe_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLTrapdoor_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGateway_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TransparencyCycler_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ModelSelector_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ResourcePuller_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Staircase_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Staircase_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Staircase_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Staircase_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframe_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeTrapdoor_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframe_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeTrapdoor_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeTrapdoor_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframe_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLTrapdoor_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframe_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLTrapdoor_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLTrapdoor_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindTurbinePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MultiLamp_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InsulationNegator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TreeSapTapPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_DemoGun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RepairGun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeWall_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLWall_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalPipe_Square_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalPipe_Wall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalWire_Square_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalWire_Wall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriFoundation_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriCeiling_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gardener_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframeSloped_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframeSloped_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeHatchframeSloped_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframeSloped_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframeSloped_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_XLHatchframeSloped_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Greenhouse_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Glass_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TriRoof_Adobe_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AutoTurret_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TurretConfigurator_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FeedingTroughPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ReplicatorPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StandingTorchPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WallTorchPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ItemCollector_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TransferGun_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalPipe_Triangle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_InternalWire_Triangle_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BeerBarrelPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CampfirePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompostBinPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CookingPotPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FireplacePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PreservingBinPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FridgePlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageSmall_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageLarge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_StorageMetal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_VaultPlus_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SpikeWall_Wood_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SpikeWall_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeFlex_Stone_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PipeFlex_Metal_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wire_Flex_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Foundation_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Wall_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ceiling_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_WindowWall_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Window_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Hatchframe_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Trapdoor_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Catwalk_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gateway_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gate_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGateway_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargeGate_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Doorframe_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Door_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceFoundation_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_FenceSupport_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ladder_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SmallPillar_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_MediumPillar_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_LargePillar_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Railing_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Ramp_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Roof_Tek_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Tek_Left_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SlopedWall_Tek_Right_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TekForcefield_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Sparkpowder2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Narcotic2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=5,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ChitinPaste2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Stimulant2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Gunpowder2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=10,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ArrowStone_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BugRepel2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=15,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ArrowTranq_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CureLow2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=20,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GasGrenade_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_BallistaArrow_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=25,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Grenade_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=30,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleRifleBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SimpleShotgunBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=35,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_PoisonGrenade_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Polymer2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_Electronics2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=40,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_GrapplingHook_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=50,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_C4Ammo_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedRifleBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=55,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RocketAmmo_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=60,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_TranqDart_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=65,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_AdvancedSniperBullet_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_CompoundArrow_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=70,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_RefinedTranqDart_Child_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=85,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_SubstrateAbsorbent2_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=95,RemoveEngramPreReq=False^)
echo OverrideNamedEngramEntries=(EngramClassName="EngramEntry_ElementCraftingStation_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=150,RemoveEngramPreReq=False^)
echo 
echo LevelExperienceRampOverrides=(ExperiencePointsForLevel[0]=5,ExperiencePointsForLevel[1]=20,ExperiencePointsForLevel[2]=45,ExperiencePointsForLevel[3]=80,ExperiencePointsForLevel[4]=125,ExperiencePointsForLevel[5]=180,ExperiencePointsForLevel[6]=245,ExperiencePointsForLevel[7]=320,ExperiencePointsForLevel[8]=405,ExperiencePointsForLevel[9]=510,ExperiencePointsForLevel[10]=635,ExperiencePointsForLevel[11]=780,ExperiencePointsForLevel[12]=945,ExperiencePointsForLevel[13]=1130,ExperiencePointsForLevel[14]=1335,ExperiencePointsForLevel[15]=1560,ExperiencePointsForLevel[16]=1805,ExperiencePointsForLevel[17]=2070,ExperiencePointsForLevel[18]=2355,ExperiencePointsForLevel[19]=2680,ExperiencePointsForLevel[20]=3045,ExperiencePointsForLevel[21]=3450,ExperiencePointsForLevel[22]=3895,ExperiencePointsForLevel[23]=4380,ExperiencePointsForLevel[24]=4905,ExperiencePointsForLevel[25]=5470,ExperiencePointsForLevel[26]=6075,ExperiencePointsForLevel[27]=6720,ExperiencePointsForLevel[28]=7405,ExperiencePointsForLevel[29]=8160,ExperiencePointsForLevel[30]=8985,ExperiencePointsForLevel[31]=9880,ExperiencePointsForLevel[32]=10845,ExperiencePointsForLevel[33]=11880,ExperiencePointsForLevel[34]=12985,ExperiencePointsForLevel[35]=14160,ExperiencePointsForLevel[36]=15405,ExperiencePointsForLevel[37]=16720,ExperiencePointsForLevel[38]=18105,ExperiencePointsForLevel[39]=19600,ExperiencePointsForLevel[40]=21205,ExperiencePointsForLevel[41]=22920,ExperiencePointsForLevel[42]=24745,ExperiencePointsForLevel[43]=26680,ExperiencePointsForLevel[44]=28725,ExperiencePointsForLevel[45]=30880,ExperiencePointsForLevel[46]=33145,ExperiencePointsForLevel[47]=35520,ExperiencePointsForLevel[48]=38005,ExperiencePointsForLevel[49]=40650,ExperiencePointsForLevel[50]=43455,ExperiencePointsForLevel[51]=46420,ExperiencePointsForLevel[52]=49545,ExperiencePointsForLevel[53]=52830,ExperiencePointsForLevel[54]=56275,ExperiencePointsForLevel[55]=59880,ExperiencePointsForLevel[56]=63645,ExperiencePointsForLevel[57]=67570,ExperiencePointsForLevel[58]=71655,ExperiencePointsForLevel[59]=75960,ExperiencePointsForLevel[60]=80485,ExperiencePointsForLevel[61]=85230,ExperiencePointsForLevel[62]=90195,ExperiencePointsForLevel[63]=95380,ExperiencePointsForLevel[64]=100785,ExperiencePointsForLevel[65]=106410,ExperiencePointsForLevel[66]=112255,ExperiencePointsForLevel[67]=118320,ExperiencePointsForLevel[68]=124605,ExperiencePointsForLevel[69]=131180,ExperiencePointsForLevel[70]=138045,ExperiencePointsForLevel[71]=145200,ExperiencePointsForLevel[72]=152645,ExperiencePointsForLevel[73]=160380,ExperiencePointsForLevel[74]=168405,ExperiencePointsForLevel[75]=176720,ExperiencePointsForLevel[76]=185325,ExperiencePointsForLevel[77]=194220,ExperiencePointsForLevel[78]=203405,ExperiencePointsForLevel[79]=212960,ExperiencePointsForLevel[80]=222885,ExperiencePointsForLevel[81]=233180,ExperiencePointsForLevel[82]=243845,ExperiencePointsForLevel[83]=254880,ExperiencePointsForLevel[84]=266285,ExperiencePointsForLevel[85]=278060,ExperiencePointsForLevel[86]=290205,ExperiencePointsForLevel[87]=302720,ExperiencePointsForLevel[88]=315605,ExperiencePointsForLevel[89]=328950,ExperiencePointsForLevel[90]=342755,ExperiencePointsForLevel[91]=357020,ExperiencePointsForLevel[92]=371745,ExperiencePointsForLevel[93]=386930,ExperiencePointsForLevel[94]=402575,ExperiencePointsForLevel[95]=418680,ExperiencePointsForLevel[96]=435245,ExperiencePointsForLevel[97]=452270,ExperiencePointsForLevel[98]=469755,ExperiencePointsForLevel[99]=487800,ExperiencePointsForLevel[100]=506405,ExperiencePointsForLevel[101]=525570,ExperiencePointsForLevel[102]=545295,ExperiencePointsForLevel[103]=565580,ExperiencePointsForLevel[104]=586425,ExperiencePointsForLevel[105]=607830,ExperiencePointsForLevel[106]=629795,ExperiencePointsForLevel[107]=652320,ExperiencePointsForLevel[108]=675405,ExperiencePointsForLevel[109]=699160,ExperiencePointsForLevel[110]=723585,ExperiencePointsForLevel[111]=748680,ExperiencePointsForLevel[112]=774445,ExperiencePointsForLevel[113]=800880,ExperiencePointsForLevel[114]=827985,ExperiencePointsForLevel[115]=855760,ExperiencePointsForLevel[116]=884205,ExperiencePointsForLevel[117]=913320,ExperiencePointsForLevel[118]=943105,ExperiencePointsForLevel[119]=973680,ExperiencePointsForLevel[120]=1005045,ExperiencePointsForLevel[121]=1037200,ExperiencePointsForLevel[122]=1070145,ExperiencePointsForLevel[123]=1103880,ExperiencePointsForLevel[124]=1138405,ExperiencePointsForLevel[125]=1173720,ExperiencePointsForLevel[126]=1209825,ExperiencePointsForLevel[127]=1246720,ExperiencePointsForLevel[128]=1284405,ExperiencePointsForLevel[129]=1323010,ExperiencePointsForLevel[130]=1362535,ExperiencePointsForLevel[131]=1402980,ExperiencePointsForLevel[132]=1444345,ExperiencePointsForLevel[133]=1486630,ExperiencePointsForLevel[134]=1529835,ExperiencePointsForLevel[135]=1573960,ExperiencePointsForLevel[136]=1619005,ExperiencePointsForLevel[137]=1664970,ExperiencePointsForLevel[138]=1711855,ExperiencePointsForLevel[139]=1759800,ExperiencePointsForLevel[140]=1808805,ExperiencePointsForLevel[141]=1858870,ExperiencePointsForLevel[142]=1909995,ExperiencePointsForLevel[143]=1962180,ExperiencePointsForLevel[144]=2015425,ExperiencePointsForLevel[145]=2069730,ExperiencePointsForLevel[146]=2125095,ExperiencePointsForLevel[147]=2181520,ExperiencePointsForLevel[148]=2239005^)
echo LevelExperienceRampOverrides=(ExperiencePointsForLevel[0]=5,ExperiencePointsForLevel[1]=20,ExperiencePointsForLevel[2]=45,ExperiencePointsForLevel[3]=80,ExperiencePointsForLevel[4]=125,ExperiencePointsForLevel[5]=180,ExperiencePointsForLevel[6]=245,ExperiencePointsForLevel[7]=320,ExperiencePointsForLevel[8]=405,ExperiencePointsForLevel[9]=500,ExperiencePointsForLevel[10]=605,ExperiencePointsForLevel[11]=720,ExperiencePointsForLevel[12]=845,ExperiencePointsForLevel[13]=980,ExperiencePointsForLevel[14]=1125,ExperiencePointsForLevel[15]=1280,ExperiencePointsForLevel[16]=1445,ExperiencePointsForLevel[17]=1620,ExperiencePointsForLevel[18]=1805,ExperiencePointsForLevel[19]=2000,ExperiencePointsForLevel[20]=2205,ExperiencePointsForLevel[21]=2420,ExperiencePointsForLevel[22]=2645,ExperiencePointsForLevel[23]=2880,ExperiencePointsForLevel[24]=3125,ExperiencePointsForLevel[25]=3380,ExperiencePointsForLevel[26]=3645,ExperiencePointsForLevel[27]=3920,ExperiencePointsForLevel[28]=4205,ExperiencePointsForLevel[29]=4500,ExperiencePointsForLevel[30]=4805,ExperiencePointsForLevel[31]=5120,ExperiencePointsForLevel[32]=5445,ExperiencePointsForLevel[33]=5780,ExperiencePointsForLevel[34]=6125,ExperiencePointsForLevel[35]=6480,ExperiencePointsForLevel[36]=6845,ExperiencePointsForLevel[37]=7220,ExperiencePointsForLevel[38]=7605,ExperiencePointsForLevel[39]=8000,ExperiencePointsForLevel[40]=8405,ExperiencePointsForLevel[41]=8820,ExperiencePointsForLevel[42]=9245,ExperiencePointsForLevel[43]=9680,ExperiencePointsForLevel[44]=10125,ExperiencePointsForLevel[45]=10580,ExperiencePointsForLevel[46]=11045,ExperiencePointsForLevel[47]=11520,ExperiencePointsForLevel[48]=12005,ExperiencePointsForLevel[49]=12500,ExperiencePointsForLevel[50]=13005,ExperiencePointsForLevel[51]=13520,ExperiencePointsForLevel[52]=14045,ExperiencePointsForLevel[53]=14580,ExperiencePointsForLevel[54]=15125,ExperiencePointsForLevel[55]=15680,ExperiencePointsForLevel[56]=16245,ExperiencePointsForLevel[57]=16820,ExperiencePointsForLevel[58]=17405,ExperiencePointsForLevel[59]=18000,ExperiencePointsForLevel[60]=18605,ExperiencePointsForLevel[61]=19220,ExperiencePointsForLevel[62]=19845,ExperiencePointsForLevel[63]=20480,ExperiencePointsForLevel[64]=21125,ExperiencePointsForLevel[65]=21780,ExperiencePointsForLevel[66]=22445,ExperiencePointsForLevel[67]=23120,ExperiencePointsForLevel[68]=23805,ExperiencePointsForLevel[69]=24500,ExperiencePointsForLevel[70]=25205,ExperiencePointsForLevel[71]=25920,ExperiencePointsForLevel[72]=26645,ExperiencePointsForLevel[73]=27380,ExperiencePointsForLevel[74]=28125,ExperiencePointsForLevel[75]=28880,ExperiencePointsForLevel[76]=29645,ExperiencePointsForLevel[77]=30420,ExperiencePointsForLevel[78]=31205,ExperiencePointsForLevel[79]=32000,ExperiencePointsForLevel[80]=32805,ExperiencePointsForLevel[81]=33620,ExperiencePointsForLevel[82]=34445,ExperiencePointsForLevel[83]=35280,ExperiencePointsForLevel[84]=36125,ExperiencePointsForLevel[85]=36980,ExperiencePointsForLevel[86]=37845,ExperiencePointsForLevel[87]=38720,ExperiencePointsForLevel[88]=39605,ExperiencePointsForLevel[89]=40500,ExperiencePointsForLevel[90]=41405,ExperiencePointsForLevel[91]=42320,ExperiencePointsForLevel[92]=43245,ExperiencePointsForLevel[93]=44180,ExperiencePointsForLevel[94]=45125,ExperiencePointsForLevel[95]=46080,ExperiencePointsForLevel[96]=47045,ExperiencePointsForLevel[97]=48020,ExperiencePointsForLevel[98]=49005,ExperiencePointsForLevel[99]=50000,ExperiencePointsForLevel[100]=51005,ExperiencePointsForLevel[101]=52020,ExperiencePointsForLevel[102]=53045,ExperiencePointsForLevel[103]=54080,ExperiencePointsForLevel[104]=55125,ExperiencePointsForLevel[105]=56180,ExperiencePointsForLevel[106]=57245,ExperiencePointsForLevel[107]=58320,ExperiencePointsForLevel[108]=59405,ExperiencePointsForLevel[109]=60500,ExperiencePointsForLevel[110]=61605,ExperiencePointsForLevel[111]=62720,ExperiencePointsForLevel[112]=63845,ExperiencePointsForLevel[113]=64980,ExperiencePointsForLevel[114]=66125,ExperiencePointsForLevel[115]=67280,ExperiencePointsForLevel[116]=68445,ExperiencePointsForLevel[117]=69620,ExperiencePointsForLevel[118]=70805,ExperiencePointsForLevel[119]=72000,ExperiencePointsForLevel[120]=73205,ExperiencePointsForLevel[121]=74420,ExperiencePointsForLevel[122]=75645,ExperiencePointsForLevel[123]=76880,ExperiencePointsForLevel[124]=78125,ExperiencePointsForLevel[125]=79380,ExperiencePointsForLevel[126]=80645,ExperiencePointsForLevel[127]=81920,ExperiencePointsForLevel[128]=83205,ExperiencePointsForLevel[129]=84500,ExperiencePointsForLevel[130]=85805,ExperiencePointsForLevel[131]=87120,ExperiencePointsForLevel[132]=88445,ExperiencePointsForLevel[133]=89780,ExperiencePointsForLevel[134]=91125,ExperiencePointsForLevel[135]=92480,ExperiencePointsForLevel[136]=93845,ExperiencePointsForLevel[137]=95220,ExperiencePointsForLevel[138]=96605,ExperiencePointsForLevel[139]=98000,ExperiencePointsForLevel[140]=99405,ExperiencePointsForLevel[141]=100820,ExperiencePointsForLevel[142]=102245,ExperiencePointsForLevel[143]=103680,ExperiencePointsForLevel[144]=105125,ExperiencePointsForLevel[145]=106580,ExperiencePointsForLevel[146]=108045,ExperiencePointsForLevel[147]=109520,ExperiencePointsForLevel[148]=111005,ExperiencePointsForLevel[149]=112500^)
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverridePlayerLevelEngramPoints=0
echo OverrideMaxExperiencePointsPlayer=2240000
echo OverrideMaxExperiencePointsDino=126000
)

:: Create Admin Whitelisting Documents
timeout /t 1 /nobreak > NUL

:: Create Server One Admin Whitelist 
>%ServerLocation%%ServerOneName%\%ServerOneName%Master\ShooterGame\Saved\AllowedCheaterSteamIDs.txt (
echo 
)

:: Create Server Two Admin Whitelist 
>%ServerLocation%%ServerTwoName%\%ServerTwoName%Master\ShooterGame\Saved\AllowedCheaterSteamIDs.txt (
echo 
)

:: Wait After Configuration Files Completed
timeout /t 1 /nobreak > NUL

:: Prompt After Configuration Files Completed
echo.
echo	---------------------------------------------------------------------------
echo	***         Configured Launch Parameters and Configuration Files        ***
echo	---------------------------------------------------------------------------
echo.

:: Wait Before Shortcut Creation
timeout /t 5 /nobreak > NUL

::Clear Screen After Configuring Parameters
test&cls

:: Prompt Before Shortcut Creation
echo	---------------------------------------------------------------------------
echo	***                      Create Shortcut Directory                      ***
echo	---------------------------------------------------------------------------
echo.
pause

:: Script to Create a Shortcut
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

:: Server One Start Shortcut
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Server 1 Start.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%ServerLocation%%ServerOneName%\%ServerOneName%Master\ShooterGame\Binaries\Win64\ServerCommandLine.bat" >> %SCRIPT%
echo oLink.WorkingDirectory = "%ServerLocation%%ServerOneName%\%ServerOneName%Master\ShooterGame\Binaries\Win64\" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%

:: Server One Config File Shortcut
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Server 1 Config Files.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%ServerLocation%%ServerOneName%\%ServerOneName%Master\ShooterGame\Saved\Config\WindowsServer\" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%

:: Server One Updater
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Server 1 Updater.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%ServerLocation%%ServerOneName%\%ServerOneName%Files\ARK_Server_Update_.bat" >> %SCRIPT%
echo oLink.WorkingDirectory = "%ServerLocation%%ServerOneName%\%ServerOneName%Files" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%

:: Server Two Start Shortcut
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Server 2 Start.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%ServerLocation%%ServerTwoName%\%ServerTwoName%Master\ShooterGame\Binaries\Win64\ServerCommandLine.bat" >> %SCRIPT%
echo oLink.WorkingDirectory = "%ServerLocation%%ServerTwoName%\%ServerTwoName%Master\ShooterGame\Binaries\Win64\" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%

:: Server Two Config File Shortcut
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Server 2 Config Files.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%ServerLocation%%ServerTwoName%\%ServerTwoName%Master\ShooterGame\Saved\Config\WindowsServer\" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%

:: Server One Updater
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Server 2 Updater.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%ServerLocation%%ServerTwoName%\%ServerTwoName%Files\ARK_Server_Update_.bat" >> %SCRIPT%
echo oLink.WorkingDirectory = "%ServerLocation%%ServerTwoName%\%ServerOneName%Files" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%

:: Ending Shortcut Creation Script
del %SCRIPT%

:: Wait After Shortcut Creation Script
timeout /t 1 /nobreak > NUL

:: Prompt Before Shortcut Creation
echo.
echo	---------------------------------------------------------------------------
echo	***                 Created Shortcut Directory Complete                 ***
echo	---------------------------------------------------------------------------
echo.

:: Wait Before Shortcut Creation
timeout /t 5 /nobreak > NUL

::Clear Screen Before Server Starts
test&cls

:: Prompt Before Starting Servers
echo	---------------------------------------------------------------------------
echo	***       Start Both Servers, Install Mods and Close this Program       ***
echo	---------------------------------------------------------------------------
echo.
pause

:: Wait Before Starting Servers
timeout /t 1 /nobreak > NUL

:: Starting Server One and Installing Mods
start "" "%USERPROFILE%\Desktop\Server 1 Start.lnk"

:: Wait Between Server One and Server Two Start
timeout /t 1 /nobreak > NUL

:: Starting Server Two and Installing Mods
start "" "%USERPROFILE%\Desktop\Server 2 Start.lnk"

:: Prompt Before Starting Servers
echo.
echo	---------------------------------------------------------------------------
echo	***      Both Servers Started and Installing Mods, Closing Program      ***
echo	---------------------------------------------------------------------------
echo.

echo	Program will Close when Time Runs Out.
:: Time until Program Terminates itself.
timeout /t 10

:: End of File