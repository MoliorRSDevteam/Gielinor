/*
*	Objectives system stores local on player, a unique tag
		-an objective goes 1,2,3,4 etc until it runs out	
	SetObjective from tb_ga_objective resets to objective 1
	CheckObjective from tb_gc_objective returns if there's any data in current objective
		-ran out is complete
		-can also return which objective we're on
		
			Pseudu-code for the objectives system
			objectives script setobjective (questtag, objtype, obj#, objecttag + strng quantity)
			setlocal string questtag+obj# = objtype,objecttag,quantity
			setlocal int	questtag+"objectives" = 1;
			
			objectives script getobjective getlocalstring(questTag+obj# ==) "objcomplete"
			
			//unique checks on mobs and all
			string (questtag+int(questtag+"objectives")) = objtype,objecttag,quantity
			objtype == kill
			objtag == mytag
			quantity > 0
			quantity = 0 {setlocalstring(questTag+obj#, "objcomplete"); setlocalstring questTag+"objectives" ++;}
*/
			
			
#include "leg_all_masterinclude"
#include "tb_include"
#include "tb_persistents"

const string OBJECTIVE_TAGS = "objectiveslist";

void RunInfo(object oPC, string idTag, int objNum);
int ExistsObjectiveID(object oPC, string objTag)
{
	string results = LEG_COMMON_GetArrayElement(oPC, OBJECTIVE_TAGS, LEG_COMMON_SearchArrayElement(oPC, OBJECTIVE_TAGS, objTag));
	return (results == objTag);
}
void AddObjectiveID(object oPC, string objTag)
{
	LEG_COMMON_AddArrayElement(oPC, OBJECTIVE_TAGS, objTag);
}
void RemoveObjectiveID(object oPC, string objTag)
{
	LEG_COMMON_DeleteArrayElement(oPC, OBJECTIVE_TAGS, LEG_COMMON_SearchArrayElement(oPC, OBJECTIVE_TAGS, objTag));
	int ix;
}
void CleanObjectives(object oPC, string idTag)
{
	//DeleteLocalInt(oPC, idTag+"TBobjectives");
	int ix;
	for (ix = 0; ix < 30; ix++)
	{
		DeleteLocalString(oPC, idTag+"obj"+IntToString(ix));
		DeleteLocalString(oPC, idTag+"objinfo"+IntToString(ix));
	}
	//do some cleanup in the array, 1 tag per customer
	while (ExistsObjectiveID(oPC, idTag))
	{
		RemoveObjectiveID(oPC, idTag);
	}
	AddObjectiveID(oPC, idTag);
}
int RemainingObjective(object oPC, string idTag, int objNum)
{
	string detes = GetLocalString(oPC, idTag+"obj"+IntToString(objNum));
	//SendMessageToPC(oPC, "RemainingQObjective "+idTag);
	SplitString(detes);
	return StringToInt(subS3);
	SplitString("");
	//objectives script getobjective getlocalstring(idTag+obj# ==) "objcomplete"
}
void ProgressObjective(object oPC, string idTag, string objType, string targetTag)
{
	oPC = oPC;
	int curObj = GetLocalInt(oPC, idTag+"TBobjectives");
	string detes = GetLocalString(oPC, idTag+"obj"+IntToString(curObj));
	//SendMessageToPC(oPC, "ProgresQObjective "+detes);
	SplitString(detes); //see tb_include
	string type = subS1;
	string tag = subS2;
	if (type != objType || tag != targetTag) {return;}
	int quantity = StringToInt(subS3)-1; //the progression
	SetLocalString(oPC, idTag+"obj"+IntToString(curObj), objType+","+targetTag+","+IntToString(quantity));
	if (quantity <= 0)
	{
		//completed; move on to next objective
		SetLocalInt(oPC, idTag+"TBobjectives", GetLocalInt(oPC, idTag+"TBobjectives")+1);
		RunInfo(oPC, idTag, curObj);
		PlaySound("gui_journaladd");
	}
	SplitString("");
}
void ProgressObjectiveAll(object oPC, string objType, string targetTag)
{
	oPC = oPC;
	//WHEN TRANSFERED CHANGE 200 to ARRAY LENGTH
	//SendMessageToPC(oPC, objType + " received "+ targetTag + " to "+ GetName(oPC));
	int count = LEG_COMMON_GetArrayElementCount(oPC, OBJECTIVE_TAGS);
	//SendMessageToPC(oPC, "sifting count "+ IntToString(count));
	int ix;
	string idTag;
	for (ix = 0; ix <= count; ix++)
	{
		idTag = LEG_COMMON_GetArrayElement(oPC, OBJECTIVE_TAGS, ix);
		//SendMessageToPC(oPC, "sifting to "+ idTag);
		if (idTag == "#OUTOFBOUNDS#") break;
		ProgressObjective(oPC, idTag, objType, targetTag);
	}
}
void SetObjective(object oPC, string idTag, string objType, int objNum, string targetTag, int quantity)
{
	oPC = oPC;
	if (GetLocalInt(oPC, idTag+"TBobjectives") != 1){CleanObjectives(oPC, idTag);} //clear all objective info if any
	SetLocalInt(oPC, idTag+"TBobjectives", 1); //start first objective
	//TBSetPersistentInt(oPC, idTag+"TBobjectives", 1); //start first objective
	//incomplete objType+","+tag+","+IntToString(quantity)
	//complete	 "objcomplete"
	SetLocalString(oPC, idTag+"obj"+IntToString(objNum), objType+","+targetTag+","+IntToString(quantity));
	//SendMessageToPC(oPC, "SetQObjective "+GetLocalString(oPC, idTag+"obj"+IntToString(objNum)));
	SetLocalInt(oPC, idTag+"TBobjectives", 1);
	//SendMessageToPC(oPC, "reset objectives to "+ IntToString(GetLocalInt(oPC, idTag+"TBobjectives")));
}
int CurrentObjective(object oPC, string idTag)
{
	//SendMessageToPC(oPC, "curobj "+IntToString(GetLocalInt(oPC, idTag+"TBobjectives")));
	return GetLocalInt(oPC, idTag+"TBobjectives");
}
void RunInfo(object oPC, string idTag, int objNum)
{
	string info;//white text // = GetLocalString(oPC, idTag+"objinfo"+IntToString(curObj));
	string info1;//red text // = GetLocalString(oPC, idTag+"objinfo1"+IntToString(curObj));
	string info2;//popup box
	switch (objNum)
	{
		case 1:
			if (idTag == "qtutorialislandexpert"){info2 = "You successfully cut some logs from a tree stump.\n\nYou can find many types of tree stumps around Molior. The higher tier stumps, the higher Woodcutting level you will need. The better quality axe, will also help improve the speed rate of which you cut at.\n\nTake a tinderbox from the crate.";}
			if (idTag == "qtutorialislandminer"){info2 = "Mine some tin ore.";}
			if (idTag == "qtutorialislandcombat"){info2 = "Kill 3 giant rats";}
			break;
		case 2:
			if (idTag == "qtutorialislandexpert"){info2 = "Right click the tinderbox and use it on some logs. Then collect ashes from the fire.";}
			if (idTag == "qtutorialislandminer"){info2 = "Use the ore on the furnace to produce a bronze bar.";}
			if (idTag == "qtutorialislandcombat"){info2 = "Talk to Vannaka";}
			break;
		case 3:
			if (idTag == "qtutorialislandexpert"){info2 = "Fires are a great way to cook food on the spot, rather than finding an oven.\n\nFires won't last forever, so it's best to bring a few logs if you're going out somewhere far from tree stumps. The better quality log you burn, the longer they will last.\n\nCollect a small net from the fishing equipment.";}
			if (idTag == "qtutorialislandexpert"){info2 = "Right click the tinderbox and use it on some logs. Then collect ashes from the fire.";}
			if (idTag == "qtutorialislandminer"){info2 = "Well done! You can use ore on a furnace to produce a metal bar.\n\nFurnaces can also be used to produce jewelry.\n\nTake a hammer from the crate";}
			//
			break;
		case 4:
			if (idTag == "qtutorialislandexpert"){info2 = "Fish for some shrimp in the pond.";}
			if (idTag == "qtutorialislandminer"){info2 = "Now use the bar on the anvil to produce a bronze dagger.";}
			//
			break;
		case 5:
			if (idTag == "qtutorialislandexpert"){info2 = "Well done! You can find many fishing spots in Molior. You will notice them by seeing splashes in the water.\n\nThe higher your Fishing level is, the faster you will gather fish.\n\nHigher tier fish might require different types of tools, or even bait.\n\nTry to cook your fish.";}
			if (idTag == "qtutorialislandminer"){info2 = "Excellent! You have a future in smithing I see. You should take that dagger and head over to the instructor.";}
			//
			break;
		case 6:
			if (idTag == "qtutorialislandexpert"){info2 = "Congratulations! You've successfully cooked from raw shrimp and completed your training. Cooking raw food is very important, as healing is essential for combat. You will have a chance to burn food and lose it.\n\nThe higher your cooking is though, the less chance you'll burn the food.";}
			//
			//
	}
	//SendMessageToPC(oPC, info+" \n1:"+info1+" \n2:"+info2);
	info1 = "Objectives Updated";
	if (info != ""){LEG_COMMON_DisplayInfoBox(oPC, info, 0, 0, 0);}
	if (info1 != ""){LEG_COMMON_DisplayInfoBox(oPC, info1, 0, 0, 1);}
	if (info2 != ""){LEG_COMMON_DisplayInfoBox(oPC, info2, 0, 0, 2);}
}