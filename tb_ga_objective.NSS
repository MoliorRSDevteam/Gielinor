#include "tb_objectives"
/*
	objType "killcreature"	tb_mobdeath
			"acquireitem"	tb_itemacquire
*/
void main(string idTag, int objNum, string objType, string tag, int quantity)
{
	object oPC = GetPCSpeaker();
	//oPC = GetLocalObject(OBJECT_SELF, "LASTPC");
	SplitString(idTag);
	SetObjective(oPC, idTag, objType, objNum, tag, quantity); //subS1 idTag
	//SetLocalString(oPC, subS1+"obj"+IntToString(objNum)+"objinfo", objInfo);//subS2 tagExt
	//SendMessageToPC(oPC, "pr-numb " + IntToString(GetLocalInt(oPC, idTag+"TBobjectives")) );
	//SendMessageToPC(oPC, "af-numb " + IntToString(GetLocalInt(oPC, idTag+"TBobjectives")) );
	//SendMessageToPC(oPC, "token " + GetLocalString(oPC, idTag+"obj"+IntToString(objNum)) );
}