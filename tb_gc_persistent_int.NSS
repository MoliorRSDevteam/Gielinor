/* Get a persistent variable
 * WARNING: Use sparringly, meant for quests. 
 	-Overusing the database can reduce the games performance.
	
	sVariable - string variable
	sCheck - integer number we're checking
	sTarget - target stored on (defaults to PC Speaker)
*/

#include "leg_all_masterinclude"
#include "ginc_var_ops"
#include "ginc_param_const"

int StartingConditional(string sVariable, string sCheck, string sTarget = "$PC")
{
    object oTarg = GetTarget(sTarget, TARGET_OBJECT_SELF);
	if (GetIsObjectValid(oTarg) == FALSE) PrintString("gc_local_int: " + sTarget + " is invalid");
    
    string sTable = LEG_COMMON_GetPC2Table(oTarg);
	int nValue = GetLocalInt(oTarg, sVariable);
	if (nValue == 0)
	{ //don't access db if we don't have to
		nValue = LEG_COMMON_GetPersistentInt("NWNX", oTarg, sVariable, sTable);
		SetLocalInt(oTarg, sVariable, nValue); //sync with db
	}
	//GetLocalInt(oTarg, sVariable);
    int iRet = CompareInts(nValue, sCheck);

    PrintString ("tb_gc_persistent_int: nValue = " + IntToString(nValue) + ",  sCheck = " + sCheck + " -- return val: " + IntToString(iRet));
    return (iRet);
}