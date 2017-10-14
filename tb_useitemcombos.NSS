#include "tb_firemaking"
#include "tb_shearsheep"

void UseItem(object oPC, object item, object oTarget)
{
	string tag = GetTag(item);
	string tag1 = GetTag(oTarget);
	int iteminv = GetIsObjectValid(GetItemPossessedBy(oPC,tag));
	int otarginv = GetIsObjectValid(GetItemPossessedBy(oPC,tag1));
	SendMessageToPC(oPC, "<color=white>" + GetName(item) + " :usedon: " + GetName(oTarget));
	
	if (tag == "tinderbox" && (tag1 == "unlittorch" || tag1 == "logs" || tag1 == "oaklogs"
	|| tag1 == "willowlogs" || tag1 ==  "maplelogs" || tag1 == "yewlogs" 
	|| tag1 == "magiclogs" ))
		{
			//string convo = GetLocalString(item, "convo");
			//AssignCommand(oPC, ActionStartConversation(oPC, convo, TRUE, FALSE));
			StartFire(oPC, oTarget);
		} else 
	if (tag == "shears" && tag1 == "sheep")
	{
		StartShearing(oPC, oTarget);
	}
}