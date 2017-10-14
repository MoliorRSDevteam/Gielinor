#include "profession_include"

void DestroyFire(object oFIRE)
{
	object oINVALID = OBJECT_INVALID;
	object oITEM = GetFirstItemInInventory(oFIRE);
	while (oITEM != oINVALID)
	{
		DestroyObject(oITEM);
		oITEM = GetNextItemInInventory(oFIRE);
	}
	AssignCommand(oFIRE, SetIsDestroyable(TRUE, FALSE));
	DestroyObject(oFIRE);
}

void main()
{
	object oFIRE = OBJECT_SELF;
	if (GetHasSpellEffect(-10, oFIRE) == TRUE) return;
	if (GetLocalInt(oFIRE, "EXTINCT") == TRUE) return;
	SetLocalInt(oFIRE, "EXTINCT", TRUE);
	SetLocked(oFIRE, FALSE);
	object oPC = GetLocalObject(oFIRE, "FIRE_OWNER");
	if (GetLocalInt(oPC, "PROF_SKILL") == SKILL_COOKING) ExecuteScript("gui_prof_loop", oPC);
	DelayCommand(60.0, DestroyFire(oFIRE));
}