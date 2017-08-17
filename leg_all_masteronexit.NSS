/*
    Script:			This is the MASTER on exit script.  It is called on by an existing On Area Exit event script or
					by simply placing it in the event itself.  This script will check for active plugins and run any 
					that require an exit routine when a player leaves the area.
	Version:		1.8
	Plugin Version: 1.93
	Author:			Marshall Vyper
	Parameters:		N/A

	Change Log:		11/26/2010 - 1.00 MV - Initial Release
					11/28/2010 - 1.01 MV - Bug fix in the event this script is called by another.
					10/16/2011 - 1.60 MV - Fixed major bug with area de-spawning call.
					10/11/2012 - 1.7 MV - Added support for MISC plugin
					05/16/2012 - 1.8 MV - Added support for WORLD plugin
*/

void AreaCleanup(object oAREA)
{
	DeleteLocalInt(oAREA, "CLEANUP");
	object oINVALID = OBJECT_INVALID;
	object oPC = GetFirstPC();
	while (oPC != oINVALID)
	{
		if (GetArea(oPC) == oAREA) return;
		oPC = GetNextPC();
	}
	int nTYPE;
	object oITEM = GetFirstObjectInArea(oAREA);
	while (oITEM != oINVALID)
	{
		nTYPE = GetObjectType(oITEM);
		if (nTYPE == OBJECT_TYPE_ITEM)
		{
			if (GetItemPossessor(oITEM) == oINVALID)
			{
				AssignCommand(oITEM, SetIsDestroyable(TRUE, FALSE));
				DestroyObject(oITEM);
			}
		}
		oITEM = GetNextObjectInArea(oAREA);
	}
}

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// This should be placed in the OnExit script field or called from there.  First we find out if
	// we were called via someone elses OnClientEnter script for the area or if we are the actual script for
	// that event.
	object oPC = GetExitingObject();
	object oArea = OBJECT_SELF;
	
	// Make sure we are the player and not some familiar
	object oMaster = GetMaster(oPC);
	if (oMaster != OBJECT_INVALID) oPC = oMaster;				
	if (GetIsPC(oPC) == FALSE) return;
	
	// Run World's custom Player exit script
	string sPlayerExitScript = GetLocalString(GetModule(), "LEG_CUSTOM_ONAREAEXIT");
	if (sPlayerExitScript != "") ExecuteScript(sPlayerExitScript, oPC);
		
	// Check for the Legends SPAWN Module (also used in various other modules such as LOOT)
	if (GetLocalInt(GetModule(), "LEG_SPAWN_ACTIVE"))
	{
		AddScriptParameterObject(oArea);
		ExecuteScriptEnhanced("leg_spawn_onexit", oPC);					
	}

	// Check for the Legends MISC Module
	//if (GetLocalInt(GetModule(), "LEG_MISC_ACTIVE"))
	//{
	//	AddScriptParameterObject(oArea);
	//	ExecuteScriptEnhanced("leg_misc_onexit", oPC);					
	//}

	// Check for the Legends WORLD Module
	if (GetLocalInt(GetModule(), "LEG_WORLD_ACTIVE"))
	{
		AddScriptParameterObject(oArea);
		ExecuteScriptEnhanced("leg_world_onexit", oPC);					
	}		
		
	// Check for the Legends HOUSING Module
	if (GetLocalInt(GetModule(), "LEG_HOUSING_ACTIVE"))
	{
		AddScriptParameterObject(oArea);
		ExecuteScriptEnhanced("leg_housing_onexit", oPC);					
	}
		
	//Area Cleanup
	if (GetLocalInt(oArea, "CLEANUP") == TRUE) return;
	SetLocalInt(oArea, "CLEANUP", TRUE);
	DelayCommand(30.0f, AreaCleanup(oArea));
}