/*
*	returns if PC is on the given objective
*/

#include "tb_objectives"
/*
	objType - killcreature/acquireitem
*/
int StartingConditional(string idTag, string sCheck)
{
	object oPC = GetPCSpeaker();
	//SendMessageToPC(oPC, "objectives " + IntToString(CurrentObjective(oPC, idTag)));
	return CompareInts(CurrentObjective(oPC, idTag), sCheck);
}