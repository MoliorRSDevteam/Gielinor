#include "tb_include"
#include "tb_questinclude"
#include "tb_objectives"
//inherited
#include "ginc_item"
#include "nw_i0_plot"
#include "ginc_var_ops"
#include "ginc_param_const"
#include "tb_legjournal"

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// QUEST CONSTS
// /////////////////////////////////////////////////////////////////////////////////////////////////////

const string QUEST_BOOK = "TBquestbook";
const string TUTORIAL_ISLAND_TAG = "qtutorialisland";
const string COOKS_ASSISTANT_TAG = "qcooksassistant";
const string RESTLESS_GHOST_TAG = "qrestlessghost";
const string BLOOD_RITUAL_TAG = "qbloodritual";
const string IMP_CATCHER_TAG = "qimpcatcher";
const string SHEEP_SHEARER_TAG = "qsheepshearer";
const string DORICS_QUEST_TAG = "qdoricsquest";
const string WITCHS_POTION_TAG = "qwitchspotion";
const string ERNEST_THE_CHICKEN_TAG = "qernestthechicken";
const string GOBLIN_DIPLOMACY_TAG = "qgoblindiplomacy";
const string RUNE_MYSTERIES_TAG = "qrunemysteries";
const string PRINCE_ALIS_RESCUE_TAG = "qprinceali";
const string PIRATES_TREASURE_TAG = "qpiratestreasure";
const string VAMPIRE_SLAYER_TAG = "qvampireslayer";
const string DEMON_SLAYER_TAG = "qdemonslayer";
//customs
//const string TEST_TAG = "qtest";

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// QUEST BUILDS
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void UseLegendsQuest(int legQID);
string LegIDToQTag(int legQID)
{
	string qtag;
	if (legQID == 1007) {qtag = BLOOD_RITUAL_TAG;}
	return qtag;
}
void SetObjVars(string extTag = "")
{
	tagExt = extTag;
	obj1 = RemainingObjective(oPC, questTag+tagExt, 1);
	//SendMessageToPC(oPC, "text "+ IntToString(obj1));
	obj2 = RemainingObjective(oPC, questTag+tagExt, 2);
	obj3 = RemainingObjective(oPC, questTag+tagExt, 3);
	obj4 = RemainingObjective(oPC, questTag+tagExt, 4);
	obj5 = RemainingObjective(oPC, questTag+tagExt, 5);
	obj6 = RemainingObjective(oPC, questTag+tagExt, 6);
	obj7 = RemainingObjective(oPC, questTag+tagExt, 7);
	curObj = GetLocalInt(oPC, questTag+tagExt+"TBobjectives");
}
/*
void QTest()
{
	questTag = TEST_TAG;
	sTitle = "Objectives Test";
	//questPoints = 0;
	SetDifficulty("novice");
	//objectives
	int obj1 = RemainingObjective(oPC, questTag, 1);
	int obj2 = RemainingObjective(oPC, questTag, 2);
	int curObj = GetLocalInt(oPC, questTag+"objectives");
	//SendMessageToPC(oPC , "cur obj:"+IntToString(curObj)+", 1rem:"+IntToString(RemainingQObjective(1)) + ", 2rem:" + IntToString(RemainingQObjective(2)));
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "Talk to objectives tester";
			break;
//finished journal
		case 999: 
			sJournalText = "complete";
			break;
//offer
		case -2: 
			//"offer";
			sObjectives += CYellow("Kill 2 rats ");
			sMainText += "Kill 3 rats and acquire 5 wool";
			break;
		case -1:
			//"finish";
			sMainText += "Good work! Rats killed. Wool found.";
			break;
		case 1:
			if ((curObj >= 1)){sObjectives += CYellow("Kill 2 rats: ") + ( (obj1==0) ? CGreen("(DONE)") : IntToString(obj1)+" to go" ) + "\n";}
			if ((curObj >= 2)){sObjectives += CYellow("Get 5 wool: ") + ( (obj2==0) ? CGreen("(DONE)") : IntToString(obj2) ) + "\n";}
			sMainText += "Kill those rats and get the 5 wool please";
			sJournalText = "killing rats now, yesh the 5 wool";
			break;
	}
}
*/
void QTutorialIsland()
{
	questTag = TUTORIAL_ISLAND_TAG;
	sTitle = "Tutorial Island";
	//questPoints = 0;
	SetDifficulty("novice");
	
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to guide.";
			questReqs += "I need a can do attitude to start playing Molior RS";
			break;
//finished journal
		case 999: 
			sJournalText = "I was a newbie so the tutors showed me how to play.";
			questReqs += "I was given my starter equipment and went to Lumbridge.";
			break;
//offer
		case -2: //guide tutor
			//"offer";
			sObjectives += CYellow("Talk to Expert outside");
			sMainText += "Hello there adventurer, I believe you are new here?\n\nNo worries, we will teach you all you would need to know! Starting off with movement. You can move by clicking your mouse, but please do not use WASD, as Neverwinter Nights 2 does not support this feature correctly, and can result in bugs.";
			sMainText += "\n\nAlso, when you press accept, press J to pull up your journal with your current progress on the island.";
			break;
		case -1:
			sMainText = "Spells are located on your spellbook, by pressing B. To cast a spell click it and it will be put it in your memorized spells, then drag your memorized spell into your action bar down below on your screen.\n\nThe amount of spells you can cast will increase with your level. Practice casting some spells on these chickens. Be wary, you can only cast spells on hostile opponents. If an opponent isn't hostile, give them a good whack "
			+"around the head first with your staff.\n\nWhen you’re ready to leave just choose finish and I’ll teleport you to the mainland of Lumbridge.";
			sRewards += COLOUR_CYAN+"Newbie equipment</color>\n";
			//"finisher";
			break;
		case 1: //guide tutor & expert
			//Info: You can check out your quest progress, by pressing 'J'.
			SetObjVars("expert");
			sMainText = "Please talk to the Expert, who is waiting for you outside.\n\nYou can move by clicking your mouse.";
			sJournalText = "The guide told me to talk to the Expert outside. I can move by clicking my mouse.";
			sObjectives = CYellow("Talk to Expert outside");
			//if ((curObj >= 1)){sObjectives = CYellow("Collect the axe from the log ") + ( (obj1==0) ? CGreen("(DONE)") : "" ) + "\n";
			sMainText = "Hello there, I'll be teaching you all about skills. First off, you can press C to bring up your character sheet. Along the top, you can see the skills page. Here you can keep track of your skill levels and clicking them will bring up information about the skill. Make sure to check your journal by pressing J, if you ever get stuck.";
			sJournalText = "Press C to bring up the character sheet. Along the top, you can see the skills page.";
			if ((curObj >= 1)){sObjectives += CYellow("Cut a tree stump to gather a log ") + ( (obj1==0) ? CGreen("(DONE)") : "" ) + "\n";}
			if ((curObj >= 2)){sObjectives += CYellow("Collect a tinderbox from the crate ") + ( (obj2==0) ? CGreen("(DONE)") : "" ) + "\n";}
			if ((curObj >= 3)){sObjectives += CYellow("Collect the ashes from the fire ") + ( (obj3==0) ? CGreen("(DONE)") : "" ) + "\n";}
			if ((curObj >= 4)){sObjectives += CYellow("Collect a fishing net from the fishing box ") + ( (obj4==0) ? CGreen("(DONE)") : "" ) + "\n";}
			if ((curObj >= 5)){sObjectives += CYellow("Fish some raw shrimp ") + ( (obj5==0) ? CGreen("(DONE)") : "" ) + "\n";}
			if ((curObj >= 6)){sObjectives += CYellow("Cook the raw shrimp ") + ( (obj6==0) ? CGreen("(DONE)") : "" ) + "\n";}
			break;
		case 2: //fishing tutor
//250xp
//10gp
			break;
		case 3: //cook tutor
	//give 3 dough
			//sMainText = "Hello there!\n\nI believe you've learned a thing or two from the Expert, but I'll let you in on some more information about cooking and food.\n\nTo begin with, let's get you cooking some bread for me.\n\nTo cook bread, you need some bread dough, which can be made by mixing water with a pot of flour. I'll save you the hassle and prepare you some dough.\n\nNow go over to the oven and cook it into a nice loaf of bread.";
			//info: “Well done! Fish isn't the only food you can cook. Keen adventurers should gather certain incrediants, as they will find out that pies & pizzas are more experience, as well as a good healing source.”
			SetObjVars("cook");
			sJournalText = "Carry on the island to learn more.";
			if ((curObj >= 1)){sObjectives = CYellow("Cook your dough into bread ")  + ( (obj1==0) ? CGreen("(DONE)") : "" ) + "\n";
			sMainText = "Use my oven over there to try and cook a nice loaf of bread.";
			sJournalText = "Use the oven to cook a nice loaf of bread.";
			}
			//cook tutor; reluctance
			break;
		case 4: //quest guide; finish
//250xp
//10gp
			//sObjectives = CYellow("Talk to the quest guide");
			sMainText = "Some npcs offer quests as a way to level up your character while earning different types of perks.\n\nAs you've probably noticed a screen pops up when you talk to NPCs on the island, along with the quest’s title.\n\nWhen given the choice to accept a quest, or decline, the color of the title shows its difficulty. Green indicates it's easy and suitable for you. Yellow, orange or red means the quest may be hard for you.\n\nPressing J pulls up your journal. "
			+"When a quest updates, make sure you read your journal to find out what’s changed.\n\nYou will notice quests are a good way to get XP, or even valuable items and gold. Some quests might even allow you access to new content!";
			sJournalText = "After learning to make bread I was told to speak to the quests guide";
			break;
		case 5: //Expert Miner; offer
			//info: Mine some tin ore.
			//info: Use the ore on the furnace to produce a bronze bar.
			//info: Well done! You can use ore on a furnace to produce a metal bar.\n\nFurnaces can also be used to produce jewelry.
			//info: Now use the bar on the anvil to produce a bronze dagger.
			//info: Excellent! You have a future in smithing I see. You should take that dagger and head over to the combat instructor.
			SetObjVars("miner");
			sJournalText = "The quest guide told me all sorts of things about quests. I wonder who my next tutor will be.";
			if ((curObj >= 1)){sObjectives += CYellow("Mine some copper ore ") + ( (obj1==0) ? CGreen("(DONE)") : "" ) + "\n";
			sMainText = "Greetings, I'll be assisting you on learning all about mining & smithing. To begin with, take this pickaxe and mine some copper and tin.\n\nOnce that's done, I want you to try and smith a bronze dagger.";
			sJournalText = "I'm smithing a bronze dagger. First I should use my pickaxe to mine some copper and tin.\n\n";
			}
			if ((curObj >= 2)){sObjectives += CYellow("Mine some tin ore ") + ( (obj2==0) ? CGreen("(DONE)") : "" ) + "\n";
			}
			if ((curObj >= 3)){sObjectives += CYellow("Use the ore on the furnace ") + ( (obj3==0) ? CGreen("(DONE)") : "" ) + "\n";
			sJournalText += "Now that I have the copper and tin ore, I should bring it to the furnace and turn it into a bar.\n\n"; 
			}
			if ((curObj >= 4)){sObjectives += CYellow("Take a hammer from the crate ") + ( (obj4==0) ? CGreen("(DONE)") : "" ) + "\n";
			sJournalText += "I should take a hammer from the crate by the furnace before I take the bar to the anvil.\n\n";
			}
			if ((curObj >= 5)){sObjectives += CYellow("Smith a bronze dagger ") + ( (obj5==0) ? CGreen("(DONE)") : "" ) + "\n";
			}
			if (curObj == 6){sJournalText = "I should show my tutor what I've made.";
			}
			//Expert Miner; cont 
			break;
		case 6: //Vannaka; cont
			sJournalText = "I smithed myself a dagger, time to break this baby in!";
			//info: Kill 3 giant rats
			//info: Talk to Vannaka
			//sObjectives += CYellow("Loot the shield from the corpse");//“Kill 3 giant rats”
			//sObjectives += CYellow("Kill 3 giant rats");//“Talk to Vannaka”
			SetObjVars("combat");
			sMainText = "Sheesh, What's that guy been teaching you? I'm glad you can smith such a weak weapon, but I'm here to teach you how to defend yourself.\n\nUse this sword, and take that shield from the corpse over there. I want you to kill some rats for me. They're trained to not be so aggressive, so don't worry about dying.\n\nTo attack them, hold RIGHT-CLICK on them, and press attack.";
			//if ((curObj >= 1)){sObjectives += CYellow("Loot the shield from the corpse ") + ( (obj1==0) ? CGreen("(DONE)") : "" ) + "\n";
			//}	CYellow("")
			if ((curObj >= 1)){sObjectives += CYellow("Kill 3 giant rats ") + ( (obj1==0) ? CGreen("(DONE)") : IntToString(3-RemainingObjective(oPC, questTag+tagExt, 1))+" / 3" ) + "\n";
			sJournalText = "I was given stronger weapons by my instructor, time to do some combat.";
			}
			//if ((curObj >= 2)){sObjectives += CYellow("Talk to Vannaka ");
			//}
			break;
			//Vannaka; finish
//250xp
//10gp
			//sMainText = "Great work on killing those rats.\n\nKilling monsters is a great way to level up. Everytime you level up, your accuracy increases, as well as your attack speed.\n\nWhen leveling your character, you will notice feats. Feats are how you define your character from other players. Someone who levels their character in-depth, is the one who will become the best.\n\n";
			//sMainText +="Let's say for example, you're a fighter who uses a 2h sword. You want to specialize your character in greatswords. If you're level 10, and you start to use a longsword, you are pretty much having the statistics of a level 1, as you aren't using the weapon you specialized in.\n\nHere's a tip. Specialize your character to the end game content.";
			break;
		case 7: //Banker;
			//info: progress in the island
			sMainText = "Banks are very important to you. It's a dangerous world out there, so you don't want to be carrying your expensive items around with you all the time.\n\nThere's two different types of banking, gold and Items.\n\nTalk to any of the bankers and deposit your gold by typing how much of your gold you want to bank.\n\nOnce banked, your gold will be safe and redeemable from any other banker in the world.\n\nYou can store your items in any bank. Your items will stack in a bank "
			+"and it's still limited to a capacity, so try to keep it clean.\n\nBanks also offer noting service, to stack encumbersome items in a light-weight paper form for trade and transport. A noted item can be converted back to the real item by any player the game.\n\nYour gold and items will always be safe once they're deposited firmly in the bank. Oh how exciting. The dividends.. shares!\n\nSpeak to the financial adviser in the other room, he'll tell you more about keeping your valuables.";
			//Banker reluctance
			sMainText += "\n\nTalk to the finance officer in the next room.";
			sJournalText = "I've learned the basics of combat. Making progress!";
			break;
		case 8: //Finance Officer
			showObj = 2;
			sObjectives += CYellow("Talk to the finance officer");
			sMainText = "Well then, you look healthy.. for now.\n\nI'm the finance officer. So my job is to teach you all about your gold and items, as well as what happens when certain dangers overcome you..\n\nWhenever you meet death, you will lose a percentage of your gold stack, and you will lose EVERY item you are carrying.\n\nAll of your items will remain where you died and anyone can take them.\n\nIf even more unfortunate circumstances occur, and the server shuts down, your items will disappear.\n\n"
			+"That's all to it. You should head over to the monk, in the church nearby. I believe he will teach you about increasing your chances of survival through.. 'gods'.";
			sJournalText = "I should talk to the finance officer in the next room.";
			break;
		case 9: //Brother Brace; finish
//250 xp
//10gp
			showObj = 2;
			sObjectives += CYellow("Talk to the monk in the church");
			sMainText = "Well hello there, young’un. Saradomin has blessed me with the power of being able to judge the actions of those before thee.\n\nAs for you, I'm quite unable to see your history, though I suppose you are on this island after all. So allow me to give you some insight.\n\nWhen you adventurers do adventuring things, collecting the bones of the fallen is worthwhile.\n\nYou can bring them to an altar like the one you see beside me to exchange the bone remains for a prayer book.\n\nReading "
			+"prayer books will grant you with a stat boost.\n\nThe greater the bone type you bring, the longer, or even permanently lasting the buff will be.\n\nTry to use prayer books, as they will give you a great advantage in combat.\n\nThat is all I can teach you for now, so may Saradomin bless you and bring you good fortunes.";
			sJournalText = "Further on Brother Brace will teach me about the gods.";
			break;
		case 10: //Wizard;
			sJournalText = "Brother Brace taught me about the gods in a church. I can leave through the back door.";
			sMainText = "I see that you have potential to become a wizard.\n\nThere’s something you must know about classes and leveling.\n\nWhen you've earned enough experience points to level up, you can choose to add a new class to your character.\n\nPress C to open up your character sheet and level up. Add the wizard class to your character and speak to me when you're ready for training.";
			if (GetLocalInt(oPC, "tutmagebanter") == 1){
			sObjectives += CYellow("Finish up with wizardry "); //“Talk to the wizard”
			sJournalText = "Press C to open up the character sheet and level up. Adding the wizard class to my character will give me access to the wizard's training.";
			}
			if (GetLocalInt(oPC, "tutmagebanter") == 2){
			sJournalText = "Spells are located on your spellbook, by pressing B. To cast a spell click it and it will be put it in your memorized spells, then drag your memorized spell into your action bar down below on your screen.";
			}
			//Wizard; finish
			break;
	}
}
void QBloodRitual()
{
	UseLegendsQuest(1007);
	sTitle = "Blood Ritual";
	questPoints = 2;
	SetDifficulty("intermediate");
	
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Xenia in the Lumbridge Cemetery.";
			break;
		case 999: 
			sJournalText = "Xenia sent me to defeat a dark force in the crypts of Lumbridge.";
			break;
	}
}
void QCooksAssistant()
{
	questTag = COOKS_ASSISTANT_TAG;
	sTitle = "Cook's Assistant";
	questPoints = 1;
	SetDifficulty("novice");
	//actions
	TakeOnFinish(oPC, questTag, 1, "egg", 1);
	TakeOnFinish(oPC, questTag, 2, "potofflour", 1);
	TakeOnFinish(oPC, questTag, 3, "bucketofmilk", 1);
	
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Cook in the Kitchen on the ground floor of Lumbridge Castle.";
			questReqs = "There aren't any requirements for this quest.";
			break;
//finished journal
		case 999: 
			sJournalText = "It was the Duke of Lumbridge’s birthday, but his cook had forgotten to buy the ingredients he needed to make him a cake. I brought the cook an egg, a pot of flour and a bucket of milk and the cook made a delicious looking cake with them.";
			questReqs += "I gained 1 Quest Point 4 sardines and 300 Cooking XP. The cook now also lets me use his high quality range which lets me burn things less whenever I wish to cook there.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "Oh dear, oh dear, oh dear, I'm in a terrible, terrible mess! \nIt's the Duke's birthday today, and I should be making him a lovely, big birthday cake using special ingredients... \nbut I've forgotten to get the ingredients. I'll never get them in time now. He'll sack me! Whatever will I do? I have four children and a goat to look after. Would you help me? Please?";
			break;
		case -1:
			//"finish";
			sMainText += "You've brought me everything I need! I am saved! Thank you!\n";
			sRewards += COLOUR_LIGHT_GREY+"300 Cooking XP</color>\n";
			sRewards += COLOUR_CYAN+"4 sardines</color>\n";
			sRewards += COLOUR_LIGHT_PURPLE+"Access to the cook's high quality range</color>\n";
			break;
		case 1:
			sObjectives = CYellow("Get an egg ") + ((GetNumItems(oPC, "egg") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get a pot of flour ") + ((GetNumItems(oPC, "potofflour") >0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get a bucket of milk ") + ((GetNumItems(oPC, "bucketofmilk") >0) ? CGreen("(DONE)"): "") + "\n";
			sMainText += "You haven't got all the ingredients I need yet! Please hurry. The Duke will sack me if I don't make this cake in time!";
			sJournalText += "I have to get some ingredients for the Duke's Birthday cake.";
			break;
	}
}
void QRestlessGhost()
{
	questTag = RESTLESS_GHOST_TAG;
	sTitle = "Restless Ghost";
	questPoints = 1;
	SetDifficulty("novice");
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this by talking to Father Aereck in church next to Lumbridge Castle.";
			questReqs = "I must be unafraid of a level 3 skeleton.";
			break;
//finished journal
		case 999: 
			sJournalText = "Father Aereck wanted help with a ghost haunting the lumbridge mausoleum. I used my amulet of ghostspeak to communicate with it and helped solve its unfinished business.";
			
			questReqs += "I gained 1 Quest Point and 1125 Prayer XP.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "Help me deal with the Ghost in the graveyard next to the church.";
			break;
		case -1:
			//"finish";
			sMainText += "Release! Thank you Stranger!\n";
			sRewards += COLOUR_LIGHT_GREY+"1125 Prayer XP</color>\n";
			break;
		case 1:
			sObjectives += CYellow("Talk to Father Urhney");
			sMainText += "You'll need Father Urhney's help, he's an expert on ghosts. You'll find him in a shack in Lumbridge Swamp.";
			sJournalText = sMainText;
			break;
		case 2:
			sObjectives += CYellow("Communicate with the ghost");
			sMainText += "This Ghost Speaking Amulet will let you talk to the ghost. It's the best I can do right now.  ";
			sJournalText = "Communicate with it and find out why it's haunting the graveyard crypt.";
			break;
		case 3: case 4:
			curObj = GetLocalInt(oPC, questTag);
			sObjectives += CYellow("Find the missing skull ") + (((curObj > 3) || GetItemInInventory("restlessghostskull", oPC) != OBJECT_INVALID) ? CGreen("(DONE)") : "") + "\n";
			sObjectives += CYellow("Place the skull in the coffin ") + ((curObj > 3) ? CGreen("(DONE)") : "" ) + "\n";
			if ((curObj > 3)){sObjectives += CYellow("Speak to the ghost ");
			}
			sMainText += "My corpse is missing my skull, could you help me find it? The warlock that killed me may be from the tower south-west of here. When you find it put it in my coffin over there.";
			sJournalText = "I have to find the ghost's missing skull, which may in the tower south-west of here.";
			//sMainText += "Have you found my skull yet? The warlock that killed me may be from the tower south-west of here. Once you";
			sJournalText += "\n\nThe ghost wants me to put his skull in his coffin.";
			break;
	}
}
void QImpCatcher()
{
	questTag = IMP_CATCHER_TAG;
	sTitle = "Imp Catcher";
	questPoints = 1;
	SetDifficulty("novice");	
	
	TakeOnFinish(oPC, questTag, 1, "redbead", 1);
	TakeOnFinish(oPC, questTag, 2, "whitebead", 1);
	TakeOnFinish(oPC, questTag, 3, "yellowbead", 1);
	TakeOnFinish(oPC, questTag, 4, "blackbead", 1);
		
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Wizard Mizgog in the Wizards' Tower.";
			questReqs = "There aren't any requirements for this quest.";
			break;
			//"offer";
			sMainText += "Find my missing magic beads! Damn imps must of taken then!";
			break;
//finished journal
		case 999: 
			sJournalText = "I helped the Wizard Mizgog recover his lost beads from an army of imps.";
			questReqs += "I gained 1 Quest Point and an amulet of accuracy.";
			break;
//offer
		case -2: 
			//"offer";
			sObjectives += CYellow("White bead ") + ((GetNumItems(oPC, "whitebead") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Yellow bead ") + ((GetNumItems(oPC, "yellowbead") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Black bead ") + ((GetNumItems(oPC, "blackbead") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Red bead ") + ((GetNumItems(oPC, "redbead") > 0) ? CGreen("(DONE)"): "") + "\n";
			sMainText += "The Wizard Grayzag has summoned hundreds of little imps. They have stolen a lot of things belonging to the Wizard Mizgog, including his magic beads.";
			break;
		case -1:
			//"finish";
			sMainText += "Thank you for finding the beads for me. I can get back to my studies now.\n";
			sRewards += COLOUR_LIGHT_GREY+"875 Runecrafting XP</color>\n";
			sRewards += COLOUR_CYAN+"Amulet of Accuracy</color>\n";
			sRewards += "";
			break;
		case 1:
			sObjectives += CYellow("White bead ") + ((GetNumItems(oPC, "whitebead") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Yellow bead ") + ((GetNumItems(oPC, "yellowbead") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Black bead ") + ((GetNumItems(oPC, "blackbead") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Red bead ") + ((GetNumItems(oPC, "redbead") > 0) ? CGreen("(DONE)"): "") + "\n";
			sMainText += "Please, find my beads!";
			sJournalText = "Find Mizgog's beads!";
			break;
	}
}
void QSheepShearer()
{
	questTag = SHEEP_SHEARER_TAG;
	sTitle = "Sheep Shearer";
	questPoints = 1;
	SetDifficulty("novice");
	int itemCount;
	
	TakeOnFinish(oPC, questTag, 1, "ballofwool", 20);
	
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Farmer Fred at his farm just a little way North West of Lumbridge.";
			questReqs = "There aren't any requirements for this quest.";
			break;
//finished journal
		case 999: 
			sJournalText = "I wandered onto Farmer Fred's property and he hired me to shear his wooly sheep.";
			
			questReqs += "I gained 1 Quest Point 60 gold and 150 Crafting XP.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "Looking for work eh? My sheep are getting mighty woolly. I'd be much obliged if you could shear them. Spin me 20 balls of wool and I will sort you out some pay.";
			break;
		case -1:
			//"finish";
			sMainText += "That makes 20 balls of wool. I guess I'd better pay you then.\n";
			sRewards += COLOUR_YELLOW+"60 gold</color>\n";
			sRewards += COLOUR_LIGHT_GREY+"150 Crafting XP</color>\n";
			break;
		case 1:
				itemCount = GetNumItems(oPC, "ballofwool");
			sObjectives += CYellow("Get 20 balls of wool. ") + ((itemCount >= 20) ? CGreen("(DONE)") : (IntToString(itemCount)+" / 20"));
			sMainText += "Bring me those balls of wool, and sure I'll pay ya.";
			sJournalText = "I asked Farmer Fred for work. He said he'd pay me for shearing his sheep for him.";
			break;
	}
}
void QDoricsQuest()
{
	questTag = DORICS_QUEST_TAG;
	sTitle = "Doric's Quest";
	questPoints = 1;
	SetDifficulty("novice");
	int itemCount;
	
	TakeOnFinish(oPC, questTag, 1, "clay", 6);
	TakeOnFinish(oPC, questTag, 2, "copperore", 4);
	TakeOnFinish(oPC, questTag, 3, "ironore", 2);
	
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Doric who is North of Falador.";
			questReqs = "There aren't any requirements, but Level 15 Mining will help.";
			break;
//finished journal
		case 999: 
			sJournalText = "Doric the dwarf was happy to let me use his anvils, but first I had to run a few errand for him.";
			
			questReqs += "I gained 1 Quest Point 180 coins and 1800 Mining XP.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "I can teach you the Dwarven way if ya like. Go collect me 6 lumps of Clay, 4 copper ores and 2 iron ores.";
			break;
		case -1:
			//"finish";
			sMainText += "Thanks for the help! You should check out the Halls of Camdozaal sometime. They offer a great way to learn about mining and smithing.\n";
			sRewards += COLOUR_YELLOW+"180 coins</color>\n";
			sRewards += COLOUR_LIGHT_GREY+"1800 Mining XP</color>\n";
			break;
		case 1:
				itemCount = GetNumItems(oPC, "clay");
			sObjectives += CYellow("Get 6 Clay ") + ((itemCount >= 6) ? CGreen("(DONE)") : (IntToString(itemCount)+" / 6")) + "\n";
				itemCount = GetNumItems(oPC, "copperore");
			sObjectives += CYellow("Get 4 Copper Ore ") + ((itemCount >= 4) ? CGreen("(DONE)") : (IntToString(itemCount)+" / 4")) + "\n";
				itemCount = GetNumItems(oPC, "ironore");
			sObjectives += CYellow("Get 2 Iron Ore ") + ((itemCount >= 2) ? CGreen("(DONE)") : (IntToString(itemCount)+" / 2")) + "\n";
			sMainText += "Collect me 6 lumps of Clay, 4 copper ores and 2 iron ores.";
			sJournalText = "I need to collect 6 lumps of clay, 4 copper, and 2 iron ores for Doric.";
			break;
	}
}
void QWitchsPotion()
{
	questTag = WITCHS_POTION_TAG;
	sTitle = "Witch's Potion";
	questPoints = 1;
	SetDifficulty("novice");
	
	TakeOnFinish(oPC, questTag, 1, "burntmeat", 1);
	TakeOnFinish(oPC, questTag, 2, "eyeofnewt", 1);
	TakeOnFinish(oPC, questTag, 3, "rattail", 1);
	TakeOnFinish(oPC, questTag, 4, "onion", 1);
	
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Hetty in her house in Rimmington, West of Port Sarim";
			questReqs = "There aren't any requirements for this quest.";
			break;
//finished journal
		case 999: 
			sJournalText = "I helped Hetty the witch in Rimmington gather ingredients for a potion that helped me tap into my magical potential.";
			
			questReqs += "I gained 1 Quest Point and 325 Magic XP.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "Ah, so you want to know more about the black arts? Lets make a potion to bring out your darker side.";
			break;
		case -1:
			//"finish";
			sMainText += "You drink from the cauldron and gain your reward.\n";
			sRewards += COLOUR_LIGHT_GREY+"325 Runecrafting XP</color>\n";
			break;
		case 1:
			sObjectives += CYellow("Get an eye of newt ") + ((GetNumItems(oPC, "eyeofnewt") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get burnt meat ") + ((GetNumItems(oPC, "burntmeat") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get an onion ") + ((GetNumItems(oPC, "onion") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get a rat's tail ") + ((GetNumItems(oPC, "rattail") > 0) ? CGreen("(DONE)"): "") + "\n";
			sMainText += "We still need more ingredients for the potion!";
			sJournalText = "I should find these ingredients for Hetty's potion.";
			break;
	}
}
void QErnestTheChicken()
{
	questTag = ERNEST_THE_CHICKEN_TAG;
	sTitle = "Ernest the Chicken";
	questPoints = 4;
	SetDifficulty("intermediate");
	
	TakeOnFinish(oPC, questTag, 1, "rubbertube", 1);
	TakeOnFinish(oPC, questTag, 2, "pressuregauge", 1);
	TakeOnFinish(oPC, questTag, 3, "canofoil", 1);
	TakeOnFinish(oPC, questTag, 4, "spade", 1);
	
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Veronica who is outside Draynor Manor.";
			questReqs = "There aren't any requirements for this quest.";
			break;
//finished journal
		case 999: 
			sJournalText = "I helped Veronica rescue her husband from the mansion in Draynor.";
			
			questReqs += "I gained 4 Quest Points 3 eggs and a buncha feathers.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "Please find Ernest. He's been in that scarry mansion far too long!";
			break;
		case -1:
			//"finish";
			sMainText += "Ah now this should fix my machine. *tinkers* Ernest *bwuck* - changes back.\n";
			sRewards += COLOUR_CYAN+"3 Eggs</color>\n";
			sRewards += COLOUR_CYAN+"300 Feathers</color>\n";
			break;
		case 1:
			sMainText += "Please find Ernest. He's been in that scarry mansion far too long!";
			sJournalText = "I agreed to find Veronica's husband Ernest who went missing in the Draynor Manor.";
			break;
		case 2:
			sObjectives += CYellow("Get a spade") + ((GetNumItems(oPC, "spade") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get a rubber rubbertube ") + ((GetNumItems(oPC, "rubbertube") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get a pressure gauge ") + ((GetNumItems(oPC, "pressuregauge") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get a can of oil ") + ((GetNumItems(oPC, "canofoil") > 0) ? CGreen("(DONE)"): "") + "\n";
			sMainText += "Find a few things in the mansion to fix my machine!";
			sJournalText = "I will need to obtain some materials for Professor Oddenstein to save Ernest.";
			break;
	}
}
void QGoblinDiplomacy()
{
	questTag = GOBLIN_DIPLOMACY_TAG;
	sTitle = "Goblin Diplomacy";
	questPoints = 5;
	SetDifficulty("novice");
	
	TakeOnFinish(oPC, questTag, 1, "orangegoblinmail", 1);
	TakeOnFinish(oPC, questTag, 2, "bluegoblinmail", 1);
	TakeOnFinish(oPC, questTag, 3, "browngoblinmail", 1);
	
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Generals Wartface and Bentnoze in the Goblin Village.";
			questReqs = "There aren't any requirements for this quest.";
			break;
//finished journal
		case 999: 
			sJournalText = "I helped the goblins in the Goblin Camp decide which armour colour they will wear.";
			
			questReqs += "I gained 5 Quest Points a gold bar and 200 Crafting XP.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "There's a disturbance in the Goblin Camp. Help the goblins solve their dispute so the world doesn't have to worry about rioting goblins. Aim: to help the goblins decide which colour they will wear.";
			sJournalText = sMainText;
			break;
		case -1:
			//"finish";
			sMainText += "thanks for da armour hooman. We like brown armour now. Take this gold thing as reward.\n";
			sRewards += COLOUR_LIGHT_GREY+"200 Crafting XP</color>\n";
			sRewards += COLOUR_CYAN+"Gold Bar</color>\n";
			break;
		case 1:
			sObjectives += CYellow("Get some orange goblin mail ") + ((GetNumItems(oPC, "orangegoblinmail") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get some blue goblin mail ") + ((GetNumItems(oPC, "bluegoblinmail") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get some brown goblin mail ") + ((GetNumItems(oPC, "browngoblinmail") > 0) ? CGreen("(DONE)"): "") + "\n";
			sMainText += "Where da armour?";
			sJournalText = "The goblins of the Goblin Camp are disputing over armours. I have to help the goblins decide which colour they will wear.";
			break;
	}
}
void QRuneMysteries()
{
	questTag = RUNE_MYSTERIES_TAG;
	sTitle = "Rune Mysteries";
	questPoints = 1;
	SetDifficulty("novice");
	
	TakeOnFinish(oPC, questTag, 1, "researchnotes", 1);
	
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Duke Horacio of Lumbridge, upstairs in Lumbridge Castle.";
			questReqs = "There aren't any requirements for this quest.";
			break;
//finished journal
		case 999: 
			sJournalText = "The Duke Horacio gave me a strange talisman which was a huge find. With it I helped the Wizard Sedridor uncover the mysteries of Runecrafting.";
			
			questReqs += "I gained 1 Quest Point and the ability to Runecraft.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "Take this strange talisman to the head of the wizards tower. I believe his name is Sedridor.";
			break;
		case -1:
			//"finish";
			sMainText += "This is wonderful news! The talisman you brought me is used to travel to a rune altar. The one you brought me was an Air talisman. It's used to travel to the Air altar, where you can craft Air runes.\n\n";
			sMainText += "This is a great discovery! As you have helped, I'll teach you about Runecrafting.	The portal you see beside me, leads to the rune essence mine.\n\n";
			sMainText += "That's where you can mine rune essence rocks, which are used to craft runes. You can find other portals like this, by other great runecrafters. You would of seen  the one by Aubury.\n\n";
			sMainText += "Bring those essence rocks to an altar, and in exchange, you will get the runes dependant on what altar you are in.To my knowledge, other altars apart from air, would require a greater knowledge of Runecrafting.\n\n";
			sMainText += "Also, a small helpful hint. The more experienced you are at Runecrafting, the lower altars that are available to you, will start to offer more runes per rune essence rock.Again, thank you very much for your help.\n";
			sRewards += COLOUR_CYAN+"Air Talisman</color>\n";
			sRewards += COLOUR_LIGHT_PURPLE+"Runecrafting Skill</color>\n";
			break;
		case 1:
			sObjectives += CYellow("Deliver the strange talisman ");
			sJournalText = "The Duke Horacio has come accross a strange talisman and sent me to take it to the head of the Wizard's Tower. His name might be Sedridor.";
			break;
		case 2:
			sObjectives += CYellow("Deliver the research package ");
			sMainText += "Hmm.. Interesting. I'd like you to do me a favour if you would. Take this research package to Aubury in Varrock. I believe he runs a magic shop during the day.";
			sJournalText = "I have to deliver a package to Aubury, a magic seller in Varrock.";
			break;
		case 3:
			sObjectives += CYellow("Deliver the notes to Sedridor. ");
			sMainText += "Sedridor sent this? I'll do some research on it right away.*Aubury studies over the contents*Amazing! You should take these research notes back to Sedridor at once!";
			sJournalText = "I have to deliver Aubury's notes to the Wizard Sedridor.";
			break;
	}
}
void QPrinceAlisRescue()
{
	questTag = PRINCE_ALIS_RESCUE_TAG;
	sTitle = "Prince Ali's Rescue";
	questPoints = 3;
	SetDifficulty("intermediate");
	if (playerstep == 2 && GetLocalInt(oPC, questTag+"alt1") == 1){playerstep = 3;} //quest progress was weird
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Hassan, Chancellor to the Emir of Al-Kharid.";
			questReqs = "There aren't any requirements for this quest.";
			break;
//finished journal
		case 999: 
			sJournalText = "I served in the rescue of Ali, prince of the city of Al-Kharid.";
			questReqs += "I gained 3 Quest Points 700 gold and free passage into Al-Kharid.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "I need the services of someone, yes. If you are interested, see the spymaster, Osman. I manage the finances here. Come to me when you need payment.";
			break;
		case -1:
			//"finish";
			sMainText += "Thank you for your participation in rescusing Prince Ali. The guards will no longer charge you to enter our city. You are a friend of Al-Kharid.\n";
			sRewards += COLOUR_YELLOW+"700 gold</color>\n";
			sRewards += COLOUR_LIGHT_PURPLE+"Free passage into Al-Kharid</color>\n";
			break;
		case 1:
			sObjectives += CYellow("Speak to the Spymaster Osman ");
			sMainText = "Have you found the spymaster, Osman, yet? You cannot proceed in your task without reporting to him.";
			sJournalText += "I have taken interest in serving Al-Kharid, lets see what the spymaster Osman has in store for me.";
			break;
		case 2:
			sObjectives += CYellow("Talk to Leela in Draynor ");
			sMainText += "My daughter and top spy, Leela, can help you. She has sent word that she has discovered where they are keeping the prince.Go talk to Leela, see what information she has. She can be found close to the Draynor jail.";
			sJournalText = "Prince Ali has been kidnapped but luckily the spy Leela has found he is being held near Draynor Village. I will need to disguise the Prince and tie up his captor to free him from their clutches.";
			break;
		case 3:
			sObjectives += CYellow("Rope ") + ((GetNumItems(oPC, "rope") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("SkinPaste ") + ((GetNumItems(oPC, "skinpaste") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Blonde Wig ") + ((GetNumItems(oPC, "blondewig") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Skirt ") + ((GetNumItems(oPC, "pinkskirt") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Key to the cell ") + ((GetNumItems(oPC, "bronzekey") > 0) ? CGreen("(DONE)"): "") + "\n";
			sMainText += "Only the lady Keli, can wander about outside the jail. We need a disguise good enough to fool them at a distance.\n\nYou need a wig, maybe from wool. If you find someone who can work with wool ask them about it. There's a witch nearby who may be able to help you dye it.\n\n";
			sMainText += "You will need to get a pink skirt, same as Keli's.\n\nWe still need something to colour the Prince's skin lighter. There's a witch close to here. She knows about many things. She may know some way to make the skin lighter.\n\n";
			sMainText += "You will still need some rope to tie up Keli of course. I heard that there's a good rope maker around here.\n\nYou need a key to the prince's cell. There is no way you can get the real key. It is on a chain around Keli's neck. Almost impossible to steal. ";
			sMainText += "Get some soft clay and get her to show you the key somehow. Then take the print, with bronze, to my father.\n\nWhen you have the escape equipment we will rescue the prince\n\n";
			sJournalText = sMainText;
			break;
		case 4:
			sObjectives += CYellow("Deal with the guard ");
			sJournalText += "Now that I have the key I should find a way to deal with the guard. He's a talkative one, maybe I can find a weakness in him.";
			break;
		case 5:
			sObjectives += CYellow("Tie up lady Keli ");
			sJournalText += "I've dealt with the guard. Now I must us my rope to tie up lady keli.";
			break;
		case 6:
			sObjectives += CYellow("Rescue the prince ");
			sJournalText += "I've dealt with Lady Keli. Time to Rescue Prince Ali.";
			break;
		case 7:
			sObjectives += CYellow("Deliver the news to Hassan");
			sMainText += "We must hurry. Go on ahead and tell my father the news. I'll put this disguise on and head back.";
			sJournalText = "Prince Ali is disguised and freed. I must hurry and deliver the news!";
			break;
	}
}
void QPiratesTreasure()
{
	questTag = PIRATES_TREASURE_TAG;
	sTitle = "Pirate's Treasure";
	questPoints = 2;
	SetDifficulty("novice");
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Redbeard Frank who is at Port Sarim.";
			questReqs = "There aren't any requirements for this quest.";
			break;
//finished journal
		case 999: 
			sJournalText = "Arr, I helped me ol' mate Redbeard smuggle some karamja rum. In return he led me to treasure. Yarr!";
			
			questReqs += "I gained 2 Quest Points and One-Eyed Hector's Treasure.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "Arr, treasure you be after eh? Well I might be able to tell you where to find some... For a price... \n\nBring yer ol' mate Frank some karamja rum.\n\n";
			break;
		case -1:
			//"finish";
			sMainText += "You've found One-Eye'd Hector's Treasure!!";
			sRewards += COLOUR_CYAN+"One-Eye'd Hector's Treasure</color>\n";
			//sRewards += COLOUR_LIGHT_GREY+"325 Magic XP</color>\n";
			//sRewards += COLOUR_YELLOW+"GOLD COLOR</color>\n";
			//sRewards += COLOUR_LIGHT_GREY+"XP COLOR</color>\n";
			//sRewards += COLOUR_CYAN+"ITEM COLOR</color>\n";
			//sRewards += COLOUR_LIGHT_PURPLE+"NEW ACCESS COLOR</color>\n";
			break;
		case 1:
			sObjectives += CYellow("Smuggle karamja rum ") + (GetLocalInt(oPC, "smuggledrum") == 1 && (GetNumItems(oPC, "karamjarum") > 0) ? CGreen("(DONE)"): "") + "\n";
			sMainText = "Get yer old mate Frank some karamja rum. 'Tis no easy task to get it off Karamja.\n\nThe Customs office has been clampin' down on the export of spirits. You seem like a resourceful young lad, I'm sure ye'll be able to find a way to slip the stuff past them.\n\n";
			sJournalText = sMainText;
			break;
		case 2:
			sObjectives += CYellow("Find the treasure ");
			sMainText = "Now a deal's a deal, I'll tell ye about the treasure. \n\nI used to serve under a pirate captain called One-Eyed Hector. Hector were very successful and became very rich. But about a year ago we were boarded by the Customs and Excise Agents. Hector were killed along with many of the crew, I were one of the few to escape and I escaped with this. \n\n";
			sJournalText = sMainText;
			break;
	}
}
void QVampireSlayer()
{
	questTag = VAMPIRE_SLAYER_TAG;
	sTitle = "Vampire Slayer";
	questPoints = 3;
	SetDifficulty("intermediate");
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to Morgan in a house in Draynor.";
			questReqs = "I must be able to defeat a level 34 vampire.";
			break;
//finished journal
		case 999: 
			sJournalText = "I slayed the Vampire that was terrorizing Draynor! Man I'm cool!";
			
			questReqs += "I gained 3 Quest Points and 4825 combat xp.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "Our little village has been dreadfully ravaged by an evil vampyre! He lives in the basement of the manor to the north, we need someone to get rid of him once and for all!";
			//sMainText += CGreen("Cook's Assistant");
			//sMainText += CYellow("Cook's Assistant");
			//sMainText += COrange("Cook's Assistant");
			//sMainText += CRed("Cook's Assistant");
			//sMainText += CPurple("Cook's Assistant");
			break;
		case -1:
			//"finish";
			sMainText += "You've found One-Eye'd Hector's Treasure!!";
			sRewards += COLOUR_CYAN+"One-Eye'd Hector's Treasure</color>\n";
			//sRewards += COLOUR_LIGHT_GREY+"325 Magic XP</color>\n";
			//sRewards += COLOUR_YELLOW+"GOLD COLOR</color>\n";
			//sRewards += COLOUR_LIGHT_GREY+"XP COLOR</color>\n";
			//sRewards += COLOUR_CYAN+"ITEM COLOR</color>\n";
			//sRewards += COLOUR_LIGHT_PURPLE+"NEW ACCESS COLOR</color>\n";
			break;
		case 1:
			sObjectives += CYellow("Talk to Dr. Harlow ");
			sMainText = "You should talk to Dr. Harlow, he is a retired vampire slayer. He may be able to give you some tips.He spends his time at the Blue Moon inn, located in Varrock.";
			sJournalText = sMainText;
			break;
		case 2:
			sJournalText = "Morgan was right, how am I gonna get through to this drunk?";
			sJournalText += CYellow("Buy Harlow a beer ");
			break;
		case 3:
			sObjectives += CYellow("Get a hammer ") + ((GetNumItems(oPC, "hammer") > 0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Get a stake ") + ((GetNumItems(oPC, "stake") >0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Arm yourself with garlic ") + ((GetNumItems(oPC, "garlic") >0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Slay Count Draynor ");
			sMainText = "Yesh yesh vampires. I was very good at killing ‘em once...You're gonna need a stake, otherwise he'll just reginerate. Yes, you must have a stake to finish it off and a stake to drive it in. ";
			sJournalText = sMainText;
			break;
		case 4:
			sObjectives += CYellow("Tell Morgan the news ");
			sJournalText = "I've done it! The vampire is dead. I must bring the news to Morgan.";
			break;
	}
}
void QDemonSlayer()
{
	questTag = DEMON_SLAYER_TAG;
	sTitle = "Demon Slayer";
	questPoints = 3;
	SetDifficulty("intermediate");
	int itemCount;
	switch (playerstep)
	{
//not started journal
		case 0: 
			sJournalText = "I can start this quest by speaking to the Gypsy in the tent in Varrock's main square.";
			questReqs = "I must be able to defeat a level 9 demon!";
			break;
//finished journal
		case 999: 
			sJournalText = "I slayed an apocalyptic demon named Delrith!";
			
			questReqs += "I gained 3 Quest Points and the Silverlight.";
			break;
//offer
		case -2: 
			//"offer";
			sMainText += "Cross my palm with silver and the future will be revealed to you.";
			break;
		case -1:
			//"finisher";
			break;
		case 1:
			sObjectives += CYellow("Talk to Sir Prysin ");
			sMainText = "A mighty demon is being summoned to destroy the city of Varrock. You are the one destined to stop him. Silverlight has been passed down through Wally's descendants. I believe it is currently in the care of the one of the King's knights called Sir Prysin.\nHe shouldn't be too hard to find. He lives in the royal palace in this city. Tell him Gypsy Aris sent you.";
			sJournalText = sMainText;
			break;
		case 2:
			sObjectives += CYellow("Sir Prysin's Key ") + ((GetNumItems(oPC, "demonslayerkey1") >0) ? CGreen("(DONE)"): "") + "\n";
			sObjectives += CYellow("Captain Rovin's Key ") + ((GetNumItems(oPC, "demonslayerkey2") >0) ? CGreen("(DONE)"): "") + "\n";
				itemCount = GetNumItems(oPC, "bones");
				//((GetNumItems(oPC, "demonslayerkey3") >0) ? (( GetLocalInt(oPC, "traibornbones") == 1) ? CGreen("(DONE)") : ("; Bones: " + ((itemCount < 25 && GetLocalInt(oPC, "traibornbones")) ? (IntToString(itemCount)+" / 25") : (CGreen("25")+" / 25")) ) : "" ) )
			//((GetNumItems(oPC, "demonslayerkey3") >0) ? CGreen("(DONE)"): "")
			//((GetLocalInt(oPC, "traibornbones") == 1) ? () : "")
			//("; Bones: " + ((itemCount < 25 && GetLocalInt(oPC, "traibornbones")) ? (IntToString(itemCount)+" / 25") : (CGreen("25")+" / 25")))
			sObjectives += CYellow("Wizard Traiborn's Key ") + ((GetNumItems(oPC, "demonslayerkey3") >0) ? CGreen("(DONE)") : ((GetLocalInt(oPC, "traibornbones") == 1) ? ("; Bones: " + ((itemCount < 25 && GetLocalInt(oPC, "traibornbones")) ? (IntToString(itemCount)+" / 25") : (CGreen("25")+" / 25"))) : "")) + "\n";
			sJournalText = "Sir Prysin kept Silverlight hidden because of it being so powerful. I must find the three keys to obtain it.";
			sJournalText += "Sir Prysin kept one of the keys, and gave the others to two other people for safe keeping.\nOne to Rovin, the captain of the palace guard. And the other to the wizard Trailborn.";
			break;
		case 3:
			sObjectives += CYellow("Slay Delrith ");
			sMainText = "May silverlight aid you in slaying the demon, the unpure, the snarling savage. *Beat drops* Delrith.";
			sJournalText = "I now have silverlight and am equipt to slay the demon.";
			break;
	}
}
// /////////////////////////////////////////////////////////////////////////////////////////////////////
// JOURNAL FUNCTIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////
int QTagToID(string qTag){return LEG_COMMON_SearchArrayElement(oPC, QUEST_BOOK, qTag);}
string QIDToTag(int qID){return LEG_COMMON_GetArrayElement(oPC, QUEST_BOOK, qID);}
void SetupQuestBook()
{
/*	
//customs
const string TUTORIAL_ISLAND_TAG = "QTutorialIsland";
const string BLOOD_RITUAL_TAG = "qbloodritual";
const string KINSHRA_TAG = "qkinshra";
const string WHITE_KNIGHTS_TAG = "qwhiteknights";
const string HELPING_HAND_TAG = "qhelpinghand";
const string PATRIARCH_TAG = "qpatriarch";
*/
	LEG_COMMON_ClearArray(oPC, QUEST_BOOK);
	//LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, TEST_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, TUTORIAL_ISLAND_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, COOKS_ASSISTANT_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, RESTLESS_GHOST_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, BLOOD_RITUAL_TAG);            
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, IMP_CATCHER_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, SHEEP_SHEARER_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, DORICS_QUEST_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, DEMON_SLAYER_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, WITCHS_POTION_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, ERNEST_THE_CHICKEN_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, RUNE_MYSTERIES_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, GOBLIN_DIPLOMACY_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, PRINCE_ALIS_RESCUE_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, PIRATES_TREASURE_TAG);
	LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, VAMPIRE_SLAYER_TAG);                              
	//LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, KINSHRA_TAG);
	//LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, WHITE_KNIGHTS_TAG);
	//LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, HELPING_HAND_TAG);
	//LEG_COMMON_AddArrayElement(oPC, QUEST_BOOK, PATRIARCH_TAG);
}
void RunQBook(string qTag)
{
	//if (qTag == TEST_TAG){QTest();}
	if (qTag == TUTORIAL_ISLAND_TAG){QTutorialIsland();}
	if (qTag == BLOOD_RITUAL_TAG){QBloodRitual();}
	if (qTag == COOKS_ASSISTANT_TAG){QCooksAssistant();}
	if (qTag == RESTLESS_GHOST_TAG){QRestlessGhost();}
	if (qTag == IMP_CATCHER_TAG){QImpCatcher();}
	if (qTag == SHEEP_SHEARER_TAG){QSheepShearer();}
	if (qTag == DORICS_QUEST_TAG){QDoricsQuest();}
	if (qTag == DEMON_SLAYER_TAG){QDemonSlayer();}
	if (qTag == WITCHS_POTION_TAG){QWitchsPotion();}
	if (qTag == ERNEST_THE_CHICKEN_TAG){QErnestTheChicken();}
	if (qTag == RUNE_MYSTERIES_TAG){QRuneMysteries();}
	if (qTag == GOBLIN_DIPLOMACY_TAG){QGoblinDiplomacy();}
	if (qTag == PRINCE_ALIS_RESCUE_TAG){QPrinceAlisRescue();}
	if (qTag == PIRATES_TREASURE_TAG){QPiratesTreasure();}
	if (qTag == VAMPIRE_SLAYER_TAG){QVampireSlayer();}

	/*
	if (qID == 4){QDragonSlayer();}
	*/
}
void UseLegendsQuest(int legQID)
{
	/*
	SetGUIObjectText(OBJECT_SELF, sGUI, "title", -1, sColor + sTitle + "</color>");
	SetGUIObjectText(OBJECT_SELF, sGUI, "questdetails", -1, sMainText);
	SetGUIObjectText(OBJECT_SELF, sGUI, "REWARDS", -1, sRewards);
	SetGUIObjectText(OBJECT_SELF, sGUI, "OFFER_REWARDS1", -1, sDescription1);
	SetGUIObjectText(OBJECT_SELF, sGUI, "OFFER_REWARDS2", -1, sDescription2);
	SetGUIObjectText(OBJECT_SELF, sGUI, "OFFER_REWARDS3", -1, sDescription3);
	SetGUITexture(OBJECT_SELF, sGUI, "OFFERED_ICON1", sIcon1);
	SetGUITexture(OBJECT_SELF, sGUI, "OFFERED_ICON2", sIcon2);			
	SetGUITexture(OBJECT_SELF, sGUI, "OFFERED_ICON3", sIcon3);						
	SetGUITexture(OBJECT_SELF, sGUI, "TYPE1", sTypeIcon);						
	SetGUITexture(OBJECT_SELF, sGUI, "TYPE2", sTypeIcon);	
	*/
	questTag = LegIDToQTag(legQID);
	QueryLegQuest(legQID);
	sJournalText = GetLocalString(oPC, "LEGquestdetails");
	sObjectives = GetLocalString(oPC, "LEGREWARDS");
	playerstep = TBGetPersistentInt(oPC, "QuestID_" + IntToString(legQID) + "_NPC", 1);
	//SendMessageToPC(oPC, "Leg questdetails: " + sJournalText);
}
// /////////////////////////////////////////////////////////////////////////////////////////////////////
// QUEST PROGRESS TRACKING FUNCTIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////
/*
	Pseudu objectives system
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