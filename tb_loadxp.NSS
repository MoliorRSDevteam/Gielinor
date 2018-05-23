#include "leg_all_masterinclude"
#include "tb_skillsandxp"


/* (12/04/15) Legends team made us persistent
 	/-ModuleProperties>variables>LEG_CUSTOM_PCINIT (leg_all_masteronenter)
*/
object oPC = OBJECT_SELF;
string sTable = LEG_COMMON_GetPC2Table(oPC);
void ActionSpam(float duration)
{
	if (duration <= 0.0) {return;}
	float step = 0.1;
	//body
	// All skills should be at least level one.
	if (GetSkillRank(SKILL_FISHING, oPC) == 0) {SetBaseSkillRank(oPC, SKILL_FISHING, 1, FALSE);
	}
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
	//repeater
	DelayCommand(step, ActionSpam(duration-step));
}
void main()
{
	//SendMessageToPC(oPC, "<color=white>" + "Welcome to Molior RS.");
	//TRISTON temporary boots for testing
	//SendMessageToPC(oPC, "<color=white>" + "'tb_loadxp'Some temporary boots for testing");
	//CreateItemOnObject("leatherboots", oPC, 1);
	// Load each skill onto the player as a local variable
	SetLocalInt(oPC, "fishingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_fishingxp", sTable));
	SetLocalInt(oPC, "cookingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_cookingxp", sTable));
	SetLocalInt(oPC, "firemakingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_firemakingxp", sTable));
	SetLocalInt(oPC, "smithingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_smithingxp", sTable));
	SetLocalInt(oPC, "woodcuttingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_woodcuttingxp", sTable));
	SetLocalInt(oPC, "miningxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_miningxp", sTable));
	SetLocalInt(oPC, "runecraftingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_runecraftingxp", sTable));
	SetLocalInt(oPC, "craftingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_craftingxp", sTable));
	SetLocalInt(oPC, "prayerxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_prayerxp", sTable));
	SetLocalInt(oPC, "agilityxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_agilityxp", sTable));
	SetLocalInt(oPC, "fletchingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_fletchingxp", sTable));
	SetLocalInt(oPC, "slayerxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_slayerxp", sTable));
	SetLocalInt(oPC, "farmingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_farmingxp", sTable));
	SetLocalInt(oPC, "thievingxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_thievingxp", sTable));
	SetLocalInt(oPC, "hunterxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_hunterxp", sTable));
	SetLocalInt(oPC, "constructionxp", LEG_COMMON_GetPersistentInt("NWNX", oPC, "TB_SkillSystem_constructionxp", sTable));
	 // and so on for each skill you have.
	//AssignCommand(oPC, ClearAllActions());
	ActionSpam(2.0); //incase we have to fight lag
	//Functional location jumper
	location loc = LEG_COMMON_GetPersistentLocation("NWNX", oPC, "TB_Jobs_serverloc", sTable);
	SendMessageToPC(oPC, "debug "+GetName(oPC) + " : "+IntToString(GetSkillRank(SKILL_CRAFTING, oPC)) + " : " + LocationToString(loc));
	AssignCommand(oPC, JumpToLocation(loc));
	SendMessageToPC(oPC, "<color=white>" + "Welcome to Molior RS");
}