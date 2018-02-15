#include "table_farming"

void CheckPlant(object oPLANT, object oPC)
{
	int nSKILL = GetSkillRank(SKILL_FARMING, oPC);
	int nREQ = GetLocalInt(oPLANT, "PLANT_REQ");
	int nCHANCE = 49 - (nSKILL - nREQ);
	if (Random(100) > nCHANCE) HarvestPlant(oPC, oPLANT);
	else 
	{
		FloatingTextStringOnCreature("This plant is ill. You will need to use a Plant Cure to harvest it.", oPC, FALSE);
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