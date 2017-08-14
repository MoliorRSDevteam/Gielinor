/* The position we are in a leg quest
 * string convChoice - name of quest event we're checking for
 		offer
		reluctance
		continue (_playerstep is used. defaults to 1)
		finisher
		finished
	int questNum - number of quest on npc
	int playerstep - step the player is on for 'continue' event (default 1)
 */

#include "leg_quest_include"

int StartingConditional(string convChoice, int questNum, int playerstep = 1)
{
	object oNPC = OBJECT_SELF;
	object oPC = GetLastSpeaker();
	//playerstep = (playerstep < 1) ? 1 : playerstep;
	// The usual, am I a PC?  If not.. punt.
	if (!GetIsPC(oPC))
	{
		oPC = GetLocalObject(OBJECT_SELF, "LASTPC");
		if (!GetIsPC(oPC))
			return 0;
	}
	// Create a name for the table structure for this player.  In this case, we're looking at
	// the "quests" table for this PC.
	string sTableID = LEG_COMMON_GetPC2Table(oPC);

	// Set up some vars.
	int iPlayerStep, iTotalQuests, iCount, iNPCPosition, iNextNPC, iFireOneliner, iQuestStarter, iQuestFinisher, iFirePostLiner, iFireFailure;
	string sQuestID, sRequirement, sQuestStarted, sCount;
	
	// Figure out if this NPC has any quests.
	iTotalQuests = GetLocalInt(oNPC, "LEG_QUEST_TotalQuests");
	
	// Loop through each quest and find ours.
	for (iCount=1; iCount<=iTotalQuests; iCount++)
	{
		if (questNum == iCount)
		{
			// Get the string value of the counter so we can use it in *_ variables.
			sCount = IntToString(iCount);
			// Grab the Quest ID for this quest.
			sQuestID = GetLocalString(oNPC, "LEG_QUEST_QuestID_" + sCount);
		}
	}
	// See where the Player stands in this quest.
	iPlayerStep = GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC");
								
	// Find out which position along the quest line this NPC is.
	iNPCPosition = GetLocalInt(oNPC, "LEG_QUEST_NPCID_" + sCount);
	
	// Find out who the Next NPC is going to be (if there is one)
	iNextNPC = GetLocalInt(oNPC, "LEG_QUEST_NextNPC_" + sCount);
	
	// Find out if there is a previous requirement before an offer can take place.
	sRequirement = GetLocalString(oNPC, "LEG_QUEST_Requirement_" + sCount);
	sQuestStarted = GetLocalString(oNPC, "LEG_QUEST_QuestStarted_" + sCount);

	// Am I the quest starter?
	iQuestStarter = GetLocalInt(oNPC, "LEG_QUEST_Starter_" + sCount);
	
	// Am I the quest finisher?
	iQuestFinisher = GetLocalInt(oNPC, "LEG_QUEST_Finisher_" + sCount);
	
	// Am I reluctant?
	int iReluctance = GetLocalInt(oNPC, "LEG_QUEST_Reluctant_" + sCount);
	int iReluctantPassed = GetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iPlayerStep) + "_ReluctantPassed");
	
	// Before I move along on a quest, I must see if talking to me is actually an
	// objective for the player.
	int iTalktoNPC = GetLocalInt(oNPC, "LEG_QUEST_IsObjective_" + sCount);
	int iNPCObjective = GetLocalInt(oNPC, "LEG_QUEST_ObjectiveFor_" + sCount);

	// Check to see if the PC has completed this quest previously and if they are allowed to repeat.
	int iTimeSystem = GetLocalInt(GetModule(), "LEG_TIME_ACTIVE");
	if (GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC") == 998)
	{
		int iPCStamp = GetLocalInt(oPC, "QuestID_" + sQuestID + "_NextRepeat");
		if (iPCStamp == 0 && iTimeSystem == TRUE)
		{
			iPCStamp = GetPersistentInt(oPC, "QuestID_" + sQuestID + "_NextRepeat", sTableID);
		}
		// If the timer has not passed, then fire the oneliner.
		if (iPCStamp > LEG_COMMON_TimeStamp())
		{
			iFireOneliner = TRUE;
		}
		else
		{
			iPlayerStep = 0;
		}
	}
	
	// The following section ONLY applies if the player is switching NPC's where the current NPC is
	// an objective for another NPC.  If this NPC is the same one the player is already on, this 
	// section is skipped.
	// iNPCPosition = CURRENT NPC
	// iNPCObjective = WHICH NPC WOULD HAVE SENT PLAYER TO ME
	// iPlayerStep = WHICH NPC IS THE PLAYER ACTUALLY ON, NOT CURRENT NPC.
	// iTalkToNPC = THE OBJECTIVE NUMBER THAT I AM FOR THE PREVIOUS NPC.
	int iJustSpokeToNPC = 0;
	if (iTalktoNPC && iPlayerStep == iNPCObjective)
	{
		// Looks like I AM an objective.  Does the player need this objective?
		// The iTalktoNPC is actually an objective Number from 1-10
		// We pull that objective from the row for the NPC that asked us to talk to this guy
		// and if it matches this NPC's ID, then we advance the Player's Step.
		// If the player's step is advanced, the original guy will always spew his
		// oneliner, otherwise, the original guy will fire a continue until we talk to this
		// NPC.
		SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_mainquests` AS t1, `" + QUESTPREFIX + "_questheader` AS t2 WHERE t1.`QuestID`=t2.`QuestID` AND t1.`QuestID` = " + sQuestID + " AND t1.`QuestNPC` = " + IntToString(iPlayerStep));
		SQLFetch();
		int iObjective = StringToInt(SQLGetData(13 + iTalktoNPC));

		if (iObjective == iNPCPosition)
		{
			// Set the current player step in the event the PC hits "Later" on
			// the finish button in the finish dialogue.  This is used in the
			// laterquest gui script.
			
			// Check and see if this NPC requires all OTHER NPC -1 objectives are complete first.
			// This is useful if NPC #1 says, kill me a mob, THEN talk to NPC #2.  It will cause
			// NPC #2 NOT to talk to the player until the first and any OTHER objectives are
			// complete.
			
			// iTalktoNPC is the objective ID (1-10) this NPC is, so we don't mind if this
			// one is not complete.  We do this by calling a special CheckObjectives function
			// passing the one objective (the NPC) that we don't need to come back as TRUE.  As
			// long as the rest are True, we are good to proceed, otherwise we simply skip this section.
			if ((GetLocalInt(oNPC, "LEG_QUEST_OtherObjectivesDone_" + sCount) && LEG_QUEST_CheckOtherObjectives(oPC, sQuestID, iPlayerStep, iTalktoNPC, 1)) || !GetLocalInt(oNPC, "LEG_QUEST_OtherObjectivesDone_" + sCount))
			{
				// If this objective is currently active and available for a PC to perform
				if (LEG_QUEST_GetOBJ(oPC, sQuestID, iPlayerStep, iTalktoNPC, "OBJInactive") != "1")
				{
					// Put this in here to catch the "Required Items" message when a PC speaks to an NPC objective.
					//TRISTON iJustSpokeToNPC = 1;
				}
			}
		}
	}

	// Check to see if the PC has messed things up by failing a skill check and now has to wait.
	if (iReluctance)
	{
		int iPCStamp = GetLocalInt(oPC, "QuestID_" + sQuestID + "_FailTime");
		if (iPCStamp == 0 && iTimeSystem == TRUE)
		{
			iPCStamp = GetPersistentInt(oPC, "QuestID_" + sQuestID + "_FailTime", sTableID);

		}
		
		// If the timer has not passed, then fire the failure.
		if (iPCStamp > LEG_COMMON_TimeStamp())
		{
			iFireFailure = TRUE;
		}
		else
		{
			
		}
	}
	
	if (iFireFailure)
	{
		// We've had a failure in skill so let's wait and inform.
		string sFailSkillMessage;
		SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_skills` WHERE `QuestID` = '" + sQuestID + "' AND `NPCID` = '" + IntToString(iPlayerStep) + "';");
		while(SQLFetch())
		{
			sFailSkillMessage = SQLGetData(5);
		}
		return 0;
	}		
	
	if (GetLocalInt(oPC, "QuestID_" + sQuestID + "_NPC") != 999)
	{
		// I have not completed a quest this guys has.
		iFirePostLiner = FALSE;
		
		//if (iFireOneliner == FALSE)
		//{
			// Let's see where the PC is with respect to this quest.
			if ((GetLocalInt(oPC, "QuestID_" + sRequirement + "_NPC") == 999 || sRequirement == "") && (GetLocalInt(oPC, "QuestID_" + sQuestStarted + "_NPC") != 0 || sQuestStarted == ""))
			{
				// Check other requiremnts				
				if (LEG_QUEST_CheckQuestRequirements(oPC, oNPC, sCount))
				{
			
					// If the player is on step 0, they do not have the quest, however this NPC
					// may not be the quest starting person, just a member of the quest, so how
					// do we tell if this NPC is the starter?
					//__TRISTON
					if (iPlayerStep == 0 && iQuestStarter)
					{
						SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + " Offer Found;" + IntToString(playerstep) + "-"+IntToString(iPlayerStep)+convChoice);
						if (convChoice == "offer")
						{
							return 1;
						}
						//iFireOneliner = FALSE;
						//iCount = iTotalQuests;
						//LEG_QUEST_FireQuestGUI("leg_quest_offer", "leg_quest_offer.xml", oPC, iNPCPosition, sQuestID);
					}
					else if (iPlayerStep == iNPCPosition)
					{
						iFireOneliner = FALSE;
						// Looks like you're already on this quest and you need to talk to this NPC
						// But do you have the objectives complete?
						// There can be 10 objectives stored in the database.  if the PC has all 10, then
						// we can show the Finish Box.  If not, we show the continue Box.
						
						// Note, NPC # 999 is always the last one in the quest.  Anyone other NPC in the quest chain
						// will always pop up a continue Box even if objectives are complete.  The key is that
						// if the player completed the objectives, then the quest step advances to the next NPC.
						
						// Now the big IF
						if (!LEG_QUEST_CheckObjectives(oPC, sQuestID, iPlayerStep, iJustSpokeToNPC))
						{
							// The player has not completed ALL the objectives - show the Continue Box without
							// advancement.
							iCount = iTotalQuests;
							int iReluctantPassed;
							
							// Find out if PC has already resolved any reluctance issues.
							if (iReluctance)
							{
								if (!iReluctantPassed)
								{
									// Check database just in case.
									iReluctantPassed = GetLocalInt(oPC, "QuestID_" + sQuestID + "_" + IntToString(iPlayerStep) + "_ReluctantPassed");
								}
							}
							
							if (!iReluctance || iReluctantPassed)
							{
								//TRISTON
								if (convChoice == "continue")
								{
									if (playerstep ==  iPlayerStep)
									{
										return 1;
									}
								}
								//LEG_QUEST_FireQuestGUI("leg_quest_continue", "leg_quest_continue.xml", oPC, iNPCPosition, sQuestID);
								if (!iReluctance)
								{
									
								
								}
							}
							else
							{
								SQLExecDirect("SELECT * FROM `" + QUESTPREFIX + "_skills` WHERE `QuestID` = '" + sQuestID + "' AND `NPCID` = '" + IntToString(iPlayerStep) + "';");
								SQLFetch();
								int iBribe = StringToInt(SQLGetData(6));
								int iSkill1 = StringToInt(SQLGetData(9));
								int iSkill2 = StringToInt(SQLGetData(10));
								string sGUI, sGUIFile;
								if (iBribe)
								{
									SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + "Continue-Bribe Found;" + IntToString(playerstep) + "-"+IntToString(iPlayerStep)+convChoice);
									if (convChoice == "continue-bribe")
									{
										return 1;
									}
									//sGUI = "leg_quest_continue_bribe"; 
									//sGUIFile = "leg_quest_continue_bribe.xml"; 
								}
								if (iBribe && iSkill1 != -1)
								{
									SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + "Continue-Bribe-Skill Found;" + IntToString(playerstep) + "-"+IntToString(iPlayerStep)+convChoice);
									if (convChoice == "continue-bribe-skill")
									{
										return 1;
									}
									//sGUI = "leg_quest_continue_bribe_skill"; 
									//sGUIFile = "leg_quest_continue_bribe_skill.xml"; 
								}
								if (iBribe && iSkill1 != -1 && iSkill2 != -1)
								{
									SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + "Continue-All Found;" + IntToString(playerstep) + "-"+IntToString(iPlayerStep)+convChoice);
									if (convChoice == "continue-all")
									{
										return 1;
									}
									//sGUI = "leg_quest_continue_all"; 
									//sGUIFile = "leg_quest_continue_all.xml"; 
								}
								if (!iBribe && iSkill1 != -1 && iSkill2 == -1)
								{
									SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + "Continue-skill1 Found;" + IntToString(playerstep) + "-"+IntToString(iPlayerStep)+convChoice);
									if (convChoice == "continue-skill1")
									{
										return 1;
									}
									//sGUI = "leg_quest_continue_skill1"; 
									//sGUIFile = "leg_quest_continue_skill1.xml"; 
								}	
								if (!iBribe && iSkill1 != -1 && iSkill2 != -1)
								{
									SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + "Continue-skills Found;" + IntToString(playerstep) + "-"+IntToString(iPlayerStep)+convChoice);
									if (convChoice == "continue-skills")
									{
										return 1;
									}
									//sGUI = "leg_quest_continue_skills"; 
									//sGUIFile = "leg_quest_continue_skills.xml"; 
								}
								if (!iBribe && iSkill1 == -1 && iSkill2 == -1)
								{
									SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + "Continue2 Found;" + IntToString(playerstep) + "-"+IntToString(iPlayerStep)+convChoice);
									if (convChoice == "continue")
									{
										return 1;
									}
									//sGUI = "leg_quest_continue"; 
									//sGUIFile = "leg_quest_continue.xml"; 
								}
								//LEG_QUEST_FireQuestGUI(sGUI, sGUIFile, oPC, iNPCPosition, sQuestID);									
							}
							

						}
						else
						{
							// The player has completed all objectives, see if this NPC is the last.  If he/she
							// is, then popup the finish box, otherwise, advance to the next NPC.
							if (iQuestFinisher)
							{
								//TRISTON
								iCount = iTotalQuests;
								SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + " Finisher Found;" + IntToString(playerstep) + "-"+IntToString(iPlayerStep)+convChoice);
								if (convChoice == "finisher") 
								{
									return 1;
								}
								//LEG_QUEST_FireQuestGUI("leg_quest_finish", "leg_quest_finish.xml", oPC, iNPCPosition, sQuestID);
							}	
							else
							{
								iCount = iTotalQuests;
								SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + " Continue3 Found;" + IntToString(playerstep) + "-"+IntToString(iPlayerStep)+convChoice);
								if (convChoice == "continue")
								{
									return 1;
								}
								//LEG_QUEST_FireQuestGUI("leg_quest_continue", "leg_quest_continue.xml", oPC, iNPCPosition, sQuestID);
							}
						}
					}
					else
					{
						// I don't equal 0 and am not talking to the quest starter. (I'll match if an objective is to talk to this one
						// from someone elses request.
						// I don't Match this guy's NPC ID
						SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + "Continue Odd Found;_(" + IntToString(playerstep) + " == " + IntToString(iPlayerStep) + " but " + IntToString(iNPCPosition) + ")" +convChoice);
						if (convChoice == "continue")
						{
							if (playerstep ==  iPlayerStep)
							{
								return 1;
							}
						}
						iFireOneliner = TRUE;
					}
				
				}
				else
					iFireOneliner = TRUE;	
			}
			else
				iFireOneliner = TRUE;	
		//}	Post 1 Liner = True
	}
	else
	{
		//post 1 liner
		SendMessageToPC(oPC, "<color=white>" + "TB: Quest" + sCount + " already finished;");
		if (convChoice == "finished")
		{
			return 1;
		}
	}
	SendMessageToPC(oPC, "<color=white>" + "TB: Quest Script, null end." + sCount);
	return 0;
}