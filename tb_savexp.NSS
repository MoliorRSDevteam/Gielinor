#include "leg_all_masterinclude"
#include "tb_skillsandxp"


/* (12/04/15) Legends team made us persistent
 	-ModuleProperties>variables>LEG_CUSTOM_ONAREAEXIT
	/used in these scripts
	(leg_all_masteronexit)
	tb_skillsandxp
*/
object oPC = OBJECT_SELF;
string sTable = LEG_COMMON_GetPC2Table(oPC); 
void DoLoc(float quittime, float delay)
{
	float step = 1.0;
	object oArea = GetArea(oPC);
	if (GetName(oArea) != "")
	{
		if (delay <= 0.0)
		{
			DeleteLocalInt(oPC, "TBLocSavePending");
			LEG_COMMON_SetPersistentLocation("NWNX", oPC, "TB_Jobs_serverloc", GetLocation(oPC), sTable);
			
		}
		else DelayCommand(step, DoLoc(0.0, delay-step));
	}
	else 
	{
		if (quittime <= 0.0) {DeleteLocalInt(oPC, "TBLocSavePending");return;}
		DelayCommand(step, DoLoc(quittime-step, delay));
	}
}
void main()
{
	DeleteLocalInt(oPC, "TB_databaseaccess");
	DeleteLocalString(oPC, "activity"); //just throwing it in there incase someone's skills are bugged
	//SendMessageToPC(oPC, "<color=white>" + "Skills xp saved to server database table "+sTable+".");
	//making sure skills are at least 1
	if (GetSkillRank(SKILL_COOKING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_COOKING, 1, FALSE);}
	if (GetSkillRank(SKILL_FIREMAKING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_FIREMAKING, 1, FALSE);}
	if (GetSkillRank(SKILL_SMITHING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_SMITHING, 1, FALSE);}
	if (GetSkillRank(SKILL_WOODCUTTING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_WOODCUTTING, 1, FALSE);}
	if (GetSkillRank(SKILL_MINING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_MINING, 1, FALSE);}
	if (GetSkillRank(SKILL_RUNECRAFTING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_RUNECRAFTING, 1, FALSE);}
	if (GetSkillRank(SKILL_CRAFTING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_CRAFTING, 1, FALSE);}
	if (GetSkillRank(SKILL_PRAYER, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_PRAYER, 1, FALSE);}
	//Agility is Hide skill
	if (GetSkillRank(SKILL_AGILITY, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_AGILITY, 1, FALSE);}
	if (GetSkillRank(SKILL_FLETCHING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_FLETCHING, 1, FALSE);}
	if (GetSkillRank(SKILL_SLAYER, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_SLAYER, 1, FALSE);}
	if (GetSkillRank(SKILL_FARMING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_FARMING, 1, FALSE);}
	if (GetSkillRank(SKILL_THIEVING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_THIEVING, 1, FALSE);}
	if (GetSkillRank(SKILL_HUNTER, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_HUNTER, 1, FALSE);}
	if (GetSkillRank(SKILL_CONSTRUCTION, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_CONSTRUCTION, 1, FALSE);}
	//getting xp
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_fishingxp", GetLocalInt(oPC, "fishingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_cookingxp", GetLocalInt(oPC, "cookingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_firemakingxp", GetLocalInt(oPC, "firemakingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_smithingxp", GetLocalInt(oPC, "smithingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_woodcuttingxp", GetLocalInt(oPC, "woodcuttingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_miningxp", GetLocalInt(oPC, "miningxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_runecraftingxp", GetLocalInt(oPC, "runecraftingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_craftingxp", GetLocalInt(oPC, "craftingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_prayerxp", GetLocalInt(oPC, "prayerxp"), sTable);
	//ptp
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_agilityxp", GetLocalInt(oPC, "agilityxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_fletchingxp", GetLocalInt(oPC, "fletchingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_slayerxp", GetLocalInt(oPC, "slayerxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_farmingxp", GetLocalInt(oPC, "farmingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_thievingxp", GetLocalInt(oPC, "thievingxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_hunterxp", GetLocalInt(oPC, "hunterxp"), sTable);
	LEG_COMMON_SetPersistentInt("NWNX", oPC, "TB_SkillSystem_constructionxp", GetLocalInt(oPC, "constructionxp"), sTable);
	// Experimental server spawning players
	if (GetLocalInt(oPC, "TBLocSavePending") == 0)
	{
		SetLocalInt(oPC, "TBLocSavePending", 1);
		DoLoc(30.0, IntToFloat(10+Random(10)));
	} else {SendMessageToPC(oPC, "");}
}