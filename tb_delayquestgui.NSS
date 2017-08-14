object oPC = GetPCSpeaker();
void main(string questTag, string popup, float delay, int popupID = 0)
{
	DelayCommand(0.6, SetCommandable(1, oPC));
	SetCommandable(0, oPC);
	AddScriptParameterString(questTag);
	AddScriptParameterString(popup);
	AddScriptParameterInt(popupID);
	//SendMessageToPC(oPC, GetName(OBJECT_SELF));
	SetLocalFloat(OBJECT_SELF, "delayopenquest", delay);
	ExecuteScriptEnhanced("tb_questgui", OBJECT_SELF, TRUE);
}

/*
object oPC = GetPCSpeaker();
string qt;
string pop;
int popid;
//int selectint;
void FireGUI()
{
	AddScriptParameterString(qt);
	AddScriptParameterString(pop);
	AddScriptParameterInt(popid);
	//AddScriptParameterInt(onSelectInt);
	ExecuteScriptEnhanced("tb_questgui", OBJECT_SELF, TRUE);
	SetCommandable(1, oPC);
}
void main(string questTag, string popup, int popupID = 0, int onSelectInt = 0)
{
	qt = questTag;
	pop = popup;
	popid = popupID;
	SetCommandable(0, oPC);
	DelayCommand(0.6, AssignCommand(OBJECT_SELF, FireGUI()));
}
*/