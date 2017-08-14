/* Sets a persistent variable
 * WARNING: Use sparringly, meant for quests. 
 	-Overusing the database can reduce the games performance.
	
	sVariable - string variable
	sChange - integer number we're storing
	sTarget - target stored on (defaults to PC Speaker)
*/

#include "leg_all_masterinclude"
#include "ginc_param_const"
#include "ginc_var_ops"

void main(string sVariable, string sChange, string sTarget = "$PC")
{
    object oTarg = GetTarget(sTarget, TARGET_OBJECT_SELF);
	if (GetIsObjectValid(oTarg) == FALSE) 
		PrintString("ga_local_int: " + sTarget + " is invalid");

	int nOldValue = GetLocalInt(oTarg, sVariable);
	int nNewValue = CalcNewIntValue(nOldValue, sChange);
	
	string sTable = LEG_COMMON_GetPC2Table(oTarg);
	SetLocalInt(oTarg, sVariable, nNewValue); //set locality first
	LEG_COMMON_SetPersistentInt("NWNX", oTarg, sVariable, nNewValue, sTable);
	
    //PrintString(sTarget + "'s variable " + sVariable + " is now set to " + IntToString(nNewValue) );
}