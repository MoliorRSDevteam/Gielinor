#include "profession_include"

void CheckPlant(object oPLANT, object oPC)
{
	if (Random(100) > 49)
	{
		int nXP = GetLocalInt(oPLANT, "PLANT_XP");
		string sITEM = GetTag(oPLANT);
		GiveCraftXP(oPC, SKILL_FARMING, nXP);
		CreateItemOnObject(sITEM, oPC);
		DestroyObject(oPLANT);
	}
	else 
	{
		FloatingTextStringOnCreature("This plant is ill. You will need a Plant Cure to harvest it.", oPC, FALSE);
		SetLocalInt(oPLANT, "PLANT_STAGE", 4);
	}
}

void main()
{
	object oPLANT = OBJECT_SELF;
	object oPC = GetLastUsedBy();
	if (GetIsPC(oPC) == FALSE) return;
	int nSTAGE = GetLocalInt(oPLANT, "PLANT_STAGE");
	switch (nSTAGE)
	{
		case 1: FloatingTextStringOnCreature("This plant has been recently planted. Compost is needed to make it grow.", oPC, FALSE); break;
		case 2: FloatingTextStringOnCreature("This plant is growing.", oPC, FALSE); break;
		case 3: CheckPlant(oPLANT, oPC); break;
		case 4: FloatingTextStringOnCreature("This plant is ill. You will need to use a Plant Cure to harvest it.", oPC, FALSE); break;
	}
}