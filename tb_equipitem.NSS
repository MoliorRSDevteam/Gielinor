//::///////////////////////////////////////////////
//:: Example XP2 OnItemEquipped
//:: x2_mod_def_equ
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnEquip Event
*/
//:://////////////////////////////////////////////
//#include "x2_inc_switches"
//#include "x2_inc_intweapon"
void main()
{
    object oItem = GetPCItemLastEquipped();
    object oPC   = GetPCItemLastEquippedBy();
	
	int levelreq = GetLocalInt(oItem, "level");
	string sClass = GetLocalString(oItem, "class");
	string sClass1 = GetLocalString(oItem, "class1");
	string sClass2 = GetLocalString(oItem, "class2");
	int mylevel, mylevel1, mylevel2;
	int class = -1, class1 = -1, class2 = -1;
	class = (sClass == "fighter") ? CLASS_TYPE_FIGHTER : class;
	class = (sClass == "ranger") ? CLASS_TYPE_RANGER : class;
	class = (sClass == "wizard") ? CLASS_TYPE_WIZARD : class;
	class = (sClass == "rogue") ? CLASS_TYPE_ROGUE : class;
	class1 = (sClass1 == "fighter") ? CLASS_TYPE_FIGHTER : class1;
	class1 = (sClass1 == "ranger") ? CLASS_TYPE_RANGER : class1;
	class1 = (sClass1 == "wizard") ? CLASS_TYPE_WIZARD : class1;
	class1 = (sClass1 == "rogue") ? CLASS_TYPE_ROGUE : class1;
	class2 = (sClass2 == "fighter") ? CLASS_TYPE_FIGHTER : class2;
	class2 = (sClass2 == "ranger") ? CLASS_TYPE_RANGER : class2;
	class2 = (sClass2 == "wizard") ? CLASS_TYPE_WIZARD : class2;
	class2 = (sClass2 == "rogue") ? CLASS_TYPE_ROGUE : class2;
	
	if (levelreq > 0)
	{
		if (class == -1 && class1 == -1 && class2 == -1)
		{
			sClass = "total";
			mylevel = GetTotalLevels(oPC,0);
		} else
		{
			mylevel = GetLevelByClass(class, oPC);
			mylevel1 = GetLevelByClass(class1, oPC);
			mylevel2 = GetLevelByClass(class2, oPC);
		}
	}
	
	if (mylevel < levelreq && mylevel1 < levelreq && mylevel2 < levelreq)
	{
		string classfeedback = "";
		classfeedback = (sClass != "") ? sClass : classfeedback;
		classfeedback = (sClass1 != "") ? sClass+", or "+sClass1 : classfeedback;
		classfeedback = (sClass2 != "") ? sClass+", "+sClass1+", or "+sClass2 : classfeedback;
		SendMessageToPC(oPC, "<color=white>"+"You need to reach " + classfeedback + " level " + IntToString(levelreq) + " to equip that.");
		DelayCommand(0.2, AssignCommand(oPC, ActionUnequipItem(oItem)));
	}
}