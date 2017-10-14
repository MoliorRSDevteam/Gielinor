//called from leg_all_mastermod_itemacquired
#include "tb_objectives"
void main()
{
     object oItem = GetModuleItemAcquired();
	 object oPC = GetModuleItemAcquiredBy();
	 //Objectives
	 ProgressObjectiveAll(oPC, "acquireitem", GetTag(oItem));
}