/* Sets a persistent variable
 * WARNING: Use sparringly, meant for quests. 
 	-Overusing the database can reduce the games performance.
*/

#include "leg_all_masterinclude"
#include "ginc_param_const"
#include "ginc_var_ops"

//Gets
//TBGetPersistentFloat
int TBGetPersistentInt(object oTarg, string sVariable, int uselocal = 0)
{
	string sTable = LEG_COMMON_GetPC2Table(oTarg);
	int ret;
	ret = (uselocal) ? GetLocalInt(oTarg, sVariable) : ret;
	ret = (ret == 0) ? LEG_COMMON_GetPersistentInt("NWNX", oTarg, sVariable, sTable) : ret; //change to persist
	return ret;
}
//TBGetPersistentLocation
//TBGetPersistentObject
string TBGetPersistentString(object oTarg, string sVariable, int uselocal = 0)
{
	string sTable = LEG_COMMON_GetPC2Table(oTarg);
	string ret;
	ret = (uselocal) ? GetLocalString(oTarg, sVariable) : ret;
	ret = (ret == "")? LEG_COMMON_GetPersistentString("NWNX", oTarg, sVariable, sTable) : ret; //change to persist
	return ret;
}

//Sets
//TBSetPersistentFloat
void TBSetPersistentInt(object oTarg, string sVariable, int nNewValue)
{
	string sTable = LEG_COMMON_GetPC2Table(oTarg);
	SetLocalInt(oTarg, sVariable, nNewValue);
	LEG_COMMON_SetPersistentInt("NWNX", oTarg, sVariable, nNewValue, sTable);
}
//TBSetPersistentLocation
//TBSetPersistentObject
void TBSetPersistentString(object oTarg, string sVariable, string sValue)
{
	string sTable = LEG_COMMON_GetPC2Table(oTarg);
	SetLocalString(oTarg, sVariable, sValue);
	LEG_COMMON_SetPersistentString("NWNX", oTarg, sVariable, sValue, sTable);
}