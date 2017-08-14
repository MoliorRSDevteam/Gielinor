// tb_checkskill
/*
    This script checks to see if the PC has an item in their inventory
	
        skill   = The skill
			0 = "fishing"
			1 = "cooking"
			2 = "firemaking"
			3 = "woodcutting"
			4 = "smithing"
			5 = "mining"
			6 = "prayer"
			7 = "runecrafting"
			8 = "crafting"
			9 = "fletching"
        bCheckParty = TRUE if you want to check the entire party for possession of the item
*/
#include "tb_skillsandxp"

int StartingConditional(int skill, int level)
{
	object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	int skillnum;
	skillnum = (skill == 0) ? SKILL_FISHING : skillnum;
	skillnum = (skill == 1) ? SKILL_COOKING : skillnum;
	skillnum = (skill == 2) ? SKILL_FIREMAKING : skillnum;
	skillnum = (skill == 3) ? SKILL_WOODCUTTING : skillnum;
	skillnum = (skill == 4) ? SKILL_SMITHING : skillnum;
	skillnum = (skill == 5) ? SKILL_MINING : skillnum;
	skillnum = (skill == 6) ? SKILL_PRAYER : skillnum;
	skillnum = (skill == 7) ? SKILL_RUNECRAFTING : skillnum;
	skillnum = (skill == 8) ? SKILL_CRAFTING : skillnum;
	skillnum = (skill == 9) ? SKILL_FLETCHING : skillnum;
	skillnum = (skill == 10) ? SKILL_SLAYER : skillnum;
	skillnum = (skill == 11) ? SKILL_FARMING : skillnum;
	skillnum = (skill == 12) ? SKILL_THIEVING : skillnum;
	skillnum = (skill == 13) ? SKILL_HUNTER : skillnum;
	skillnum = (skill == 14) ? SKILL_CONSTRUCTION : skillnum;
	
	//SendMessageToPC(oPC, "<color=white>" + IntToString(skill) + "skill : match" + IntToString(skillnum) + " myLevel: " + IntToString(GetSkillRank(skillnum, oPC)) + " at least " + IntToString(level));
	return (GetSkillRank(skillnum, oPC) >= level);
}