#include "tb_objectives"
#include "tb_persistents"

const string DEFAULT_ANIM = "kneeltalk";
const string NOTHING_MESSAGE = "Nothing interesting happens.";
object oPC = GetLastUsedBy();
object placeable = OBJECT_SELF;
string sdefaultmessage = GetLocalString(placeable, "observation");
string smessage;
string questTag;
string objectiveTag;
string feedback;
string failmessage;
string actVar;
int questInt;
int objectiveInt;
int ret = 0;
int usethe = 1;
void Loot(string itemTag, int justone = 1);
void Place(string itemTag);
void IncAct(int num = 1)
{
	SetLocalInt(oPC, actVar, GetLocalInt(oPC, actVar)+num);
}
void main()
{
	string name;
	int act;
	int id;
	int ix;
	string anim = GetLocalString(placeable, "anim");
	sdefaultmessage = (sdefaultmessage == "") ? NOTHING_MESSAGE : sdefaultmessage;
	smessage = sdefaultmessage;
	anim = (anim == "") ? DEFAULT_ANIM : anim;
		//string index = (ix == 0) ? "" : IntToString(ix);
		questTag = GetLocalString(placeable, "questtag");//+index
		questInt = GetLocalInt(placeable, "questint");//+index
		objectiveTag = GetLocalString(placeable, "objectivetag");//+index
		objectiveInt = GetLocalInt(placeable, "objectiveint");//+index
		if (questInt != 0 && GetLocalInt(oPC, questTag) != questInt) {SendMessageToPC(oPC, smessage);return;}//
		if (objectiveInt != 0 && CurrentObjective(oPC, objectiveTag) < objectiveInt) {SendMessageToPC(oPC, smessage);return;}//SendMessageToPC(oPC, smessage);
		name = GetName(placeable);
		actVar = "qplaceable"+name+questTag;//GetLocalString(placeable, "action");
		act = GetLocalInt(oPC, actVar);
		id = GetLocalInt(placeable, "id");
		switch (id)
		{
			case 1: //id
				switch (act)
				{
					case 0: //act 1.2..3..etc
						if (objectiveTag == "qtutorialislandexpert") {Loot("bronzeaxe");TBSetPersistentInt(oPC, questTag, questInt+1);feedback = "Tutorial Island quest updated";}
						if (objectiveTag == "qtutorialislandminer") {Loot("hammer");}
						if (objectiveTag == "qtutorialislandcombat") {usethe=0;Loot("woodenshield");}
						if (questTag == "qrestlessghost") {Loot("restlessghostskull");}
						if (questTag == "qernestthechicken") {Loot("canofoil");}
						if (questTag == "qernestthechicken") {Loot("spade");}
						if (questTag == "qpiratestreasure") {anim="shoveling";smessage = "You dig a hole in the ground...\nand find a little chest of treasure.";}
						if (questTag == "qdemonslayer"){if(GetItemPossessedBy(oPC, "bucketofwater") != OBJECT_INVALID && !GetLocalInt(oPC, "demonslayerdrain")){DestroyItems(oPC, "bucketofwater", 1);CreateItemOnObject("emptybucket", oPC, 1);smessage = "*You poor the water down the drain.. *clacking*";SetLocalInt(oPC, "demonslayerdrain", 1);}}
						break;
					default:
						break;
				}
				break;
			case 2: //id
				switch (act)
				{
					case 0: //act 1.2..3..etc
						if (objectiveTag == "qtutorialislandexpert") {Loot("tinderbox");}
						if (questTag == "qrestlessghost") {Place("restlessghostskull");if (ret == 1){return;}TBSetPersistentInt(oPC, questTag, questInt+1);feedback = "Restless Ghost Updated";IncAct();}
						if (questTag == "qernestthechicken") {anim="Cooking02";Place("poisonousfishfood");if (ret == 1){return;}smessage="The piranas die and float to the surface.";IncAct();}
						if (questTag == "qdemonslayer" && GetLocalInt(oPC, "demonslayerdrain") == 1){usethe=0;Loot("demonslayerkey1");}
						break;
					case 1:
						if (questTag == "qernestthechicken") {Loot("pressuregauge");}
					default:
						break;
				}		
				break;
			case 3: //id
				switch (act)
				{
					case 0: //act 1.2..3..etc
						if (objectiveTag == "qtutorialislandexpert") {Loot("smallnet");}
						break;
					default:
						break;
				}
				break;
			case 4: //id
				switch (act)
				{
					case 0: //act 1.2..3..etc
						//
						break;
					default:
						break;
				}
				break;
			case 5: //id
				switch (act)
				{
					case 0: //act 1.2..3..etc
						//
						break;
					default:
						break;
				}
				break;
			case 6: //id
				switch (act)
				{
					case 0: //act 1.2..3..etc
						//
						break;
					default:
						break;
				}
				break;
			default:
				break;
		}
	SendMessageToPC(oPC, smessage);
	if (smessage == sdefaultmessage) {return;}
	LEG_COMMON_DisplayInfoBox(oPC, feedback);
	AssignCommand(oPC, ClearAllActions());
	PlayCustomAnimation(oPC, "%", FALSE);
	PlayCustomAnimation(oPC, anim, FALSE);
	SetLocalString(oPC, "actionConv", questTag); //when calling conv_actionConv
	ActionStartConversation(oPC, "conv_questaction");
}
void Place(string itemTag)
{
	object oItem = GetItemPossessedBy(oPC, itemTag);
	if (oItem == OBJECT_INVALID) {return;}//SendMessageToPC(oPC, smessage);
	DestroyItems(oPC, itemTag, 1);
	smessage = "You place " + (!usethe?"the ":"") + GetName(oItem) + " about the " + GetName(OBJECT_SELF);
}
void Loot(string itemTag, int justone)
{
	if (ListInventory(oPC) >= 128)
	{
		smessage = "You don't have enough space for that.";
		return;
	}
	if (justone == 1 && GetItemPossessedBy(oPC, itemTag) != OBJECT_INVALID)
	{
		return;
	}
	object oItem = CreateItemOnObject(itemTag, oPC, 1, "", 1);
	smessage = "You grab " + (!usethe?"the ":"")  + GetName(oItem) + " from the " + GetName(OBJECT_SELF);
}