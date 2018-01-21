void main()
{
	object oPC = OBJECT_SELF;
	object oCONTROL = GetControlledCharacter(oPC);
	string sSCREEN = "SCREEN_INVENTORY";
	SetGUIObjectText(oPC, sSCREEN, "FISHING", 		-1, IntToString(GetSkillRank(30, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "COOKING", 		-1, IntToString(GetSkillRank(31, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "FIREMAKING", 	-1, IntToString(GetSkillRank(32, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "SMITHING", 		-1, IntToString(GetSkillRank(33, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "WOODCUTTING", 	-1, IntToString(GetSkillRank(34, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "MINING", 		-1, IntToString(GetSkillRank(35, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "RUNECRAFTING", 	-1, IntToString(GetSkillRank(36, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "CRAFTING", 		-1, IntToString(GetSkillRank(37, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "PRAYER", 		-1, IntToString(GetSkillRank(38, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "HERBLORE", 		-1, IntToString(GetSkillRank(41, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "THIEVING", 		-1, IntToString(GetSkillRank(42, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "FLETCHING", 	-1, IntToString(GetSkillRank(43, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "SLAYER", 		-1, IntToString(GetSkillRank(44, oCONTROL, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "FARMING", 		-1, IntToString(GetSkillRank(46, oCONTROL, TRUE)));
}