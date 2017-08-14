/* tb_firemaking	@Triston Barker 10/24/15
	oPC = playing character
	_logs = template resref of logs

*/
#include "tb_loops"
#include "ginc_param_const"
#include "ginc_actions"
#include "tb_spawndespawn"
#include "tb_skillsandxp"

void StartFire(object oPC, object logs);
void StrikeTinder(float delay, float curtime, float dist);
void BurnLogs();
void LoopSound(object obj, string sound, float curtime);
void ReallyPlayCustomAnimation(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0f)
{
	PlayAnimation(0, 1.0f, 0.01f);
 	PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
}

const float BACKUP_DISTANCE = 0.5f;
const string STRIKE_SOUND = "tinderbox";
const string BURN_SOUND = "burnlogs";

const string FIRE_ANIM = "disableground";//"fire";
//string temp;
//tags
const string UNLITTORCH_TAG = "unlittorch";
const string TORCH_TAG = "torch";
const string NORMAL_TAG = "logs";
const string OAK_TAG = "oaklogs";
const string WILLOW_TAG = "willowlogs";
const string MAPLE_TAG = "maplelogs";
const string YEW_TAG = "yewlogs";
const string MAGIC_TAG = "magiclogs";
const string MAGIC_LIGHT_TAG = "bonfire1";
const string MAGIC_VFX_TAG = "fx_nshore_torch";

//Level
const int NORMAL_LEVEL = 0;
const int OAK_LEVEL = 15;
const int TORCH_LEVEL = 20;
const int WILLOW_LEVEL = 30;
const int MAPLE_LEVEL = 45;
const int YEW_LEVEL = 60;
const int MAGIC_LEVEL = 75;
//LevelCaps - levels above to get to highest burn chance
const int NORMAL_LEVEL_CAP = 10;
const int OAK_LEVEL_CAP = 15;
const int WILLOW_LEVEL_CAP = 15;
const int MAPLE_LEVEL_CAP = 20;
const int YEW_LEVEL_CAP = 20;
const int MAGIC_LEVEL_CAP = 30;
//Burn Time
const int NORMAL_TIME = 20;
const int OAK_TIME = 30;
const int WILLOW_TIME = 40;
const int MAPLE_TIME = 50;
const int YEW_TIME = 60;
const int MAGIC_TIME = 120;
//XP
const int NORMAL_XP = 40;
const int OAK_XP = 60;
const int WILLOW_XP = 90;
const int MAPLE_XP = 135;
const int YEW_XP =202;
const int MAGIC_XP = 301;

object oPC;
object logs;
string ref;
location loc;
int burnTime;
string type;
int xp;
int logLevel = 0;
int levelcap;
int level;
float nStrikeTime = 3.5;
string feedback;

void StartStriking();
void EndFiremaking(); // you either moved on or lit the fire so end
void StartFire(object _oPC, object _logs)
{
	oPC = _oPC;
	if (GetLocalInt(oPC, "isfiremaking") == 1) //a firemaking loop is already firing
	{
		//already firemaking
		return;
	}
	SetLocalString(oPC, "activity", "firemaking"); //activity switch aborts loops in all other activities
	logs = _logs;
	ref = GetResRef(_logs);
	loc = GetLocation(_logs);
	object nearestfire = GetNearestObjectByTag("bonfire",_logs);
	nearestfire = (!GetIsObjectValid(nearestfire)) ? GetNearestObjectByTag("bonfire",oPC) : nearestfire;
	if (GetDistanceBetweenLocations(GetLocation(oPC), loc) == -1.0)
	{
		loc = GetLocation(oPC);
	}
	float dist = GetDistanceBetweenLocations(loc, GetLocation(nearestfire));
	//SendMessageToPC(oPC, "<color=white>" + "Dist from nearest fire: " + FloatToString(dist));
	//Preparing logs
	if (ref == UNLITTORCH_TAG)
	{
		type = "Torch";
		logLevel = TORCH_LEVEL;
		levelcap = OAK_LEVEL_CAP;
		burnTime = OAK_TIME;
	}
	if (ref == NORMAL_TAG)
	{
		type = "Normal";
		logLevel = NORMAL_LEVEL;
		levelcap = NORMAL_LEVEL_CAP;
		burnTime = NORMAL_TIME;
		xp = NORMAL_XP;
	} else if (ref == OAK_TAG)
	{
		type = "Oak";
		logLevel = OAK_LEVEL;
		levelcap = OAK_LEVEL_CAP;
		burnTime = OAK_TIME;
		xp = OAK_XP;
	} else if (ref == WILLOW_TAG)
	{
		type = "Willow";
		logLevel = WILLOW_LEVEL;
		levelcap = WILLOW_LEVEL_CAP;
		burnTime = WILLOW_TIME;
		xp = WILLOW_XP;
	} else if (ref == MAPLE_TAG)
	{
		type = "Maple";
		logLevel = MAPLE_LEVEL;
		levelcap = MAPLE_LEVEL_CAP;
		burnTime = MAPLE_TIME;
		xp = MAPLE_XP;
	} else if (ref == YEW_TAG)
	{
		type = "Yew";
		logLevel = YEW_LEVEL;
		levelcap = YEW_LEVEL_CAP;
		burnTime = YEW_TIME;
		xp = YEW_XP;
	} else if (ref == MAGIC_TAG)
	{
		type = "Magic";
		logLevel = MAGIC_LEVEL;
		levelcap = MAGIC_LEVEL_CAP;
		burnTime = MAGIC_TIME;
		xp = MAGIC_XP;
	}
	if (dist < 0.8f && GetIsObjectValid(nearestfire) && type != "Torch")
	{
		SendMessageToPC(oPC, "<color=white>" + "You can't light a fire there.");
		return;
	}
	//End Log Preparation
	//Check our level
	level = GetSkillRank(SKILL_FIREMAKING, oPC);
	if (level < logLevel)
	{
		SendMessageToPC(oPC, "<color=white>" + "You need Firemaking level " + IntToString(logLevel) + 
		" to do that.");
		return;
	}
	//Roll Skill timer
	//int timecap = burnTime/2;//StringToInt(GetLocalString(oSpot, "timecap"));
	//int timespan = level - logLevel;
	//timespan = (timespan <= timecap) ? timespan : timecap; //10 is maximum level time reduction
	//int skilltime = timecap-(Random(timespan/4)+3*timespan/4);
	//int minTime = 1 + (burnTime/30);
	//nStrikeTime = IntToFloat(minTime + skilltime);
	burnTime = Random(5) + 2*burnTime + Random(logLevel); //adjust burntime
	//End Skill Roll
	//SendMessageToPC(oPC, "<color=white>" + "\nStrike Time: " + FloatToString(nStrikeTime)
	// + "BurnTime: " + IntToString(burnTime));
	
	AssignCommand(oPC, PlaySound(STRIKE_SOUND, TRUE));
	AssignCommand(oPC, ActionMoveToLocation(loc, TRUE));
	StartStriking();
}

void StartStriking()
{
	float curdist = GetDistanceBetweenLocations(GetLocation(oPC), loc);
	if (curdist <= 0.3)
	{
		DelayCommand(0.2f, AssignCommand(oPC, ReallyPlayCustomAnimation(oPC, FIRE_ANIM, 0)));
		AssignCommand(oPC, StrikeTinder(nStrikeTime, nStrikeTime, 1000.0f));
	}
	else
	{
		DelayCommand(0.1, StartStriking());
	}
}

void StrikeTinder(float time, float curtime, float dist)
{
	float step = 0.5f;
	float curdist = GetDistanceBetweenLocations(GetLocation(oPC), loc);
	//SendMessageToPC(oPC, "<color=white>" + "Current Distance." + FloatToString(curdist) +
	//"Previous Distance." + FloatToString(dist));
	
	int levelspan = level-logLevel;
	int nRoll = Random(levelcap);
	if (curdist <= 0.3)
	{
		if (curtime <= 0.0f)
		{
			//roll skill success
			if (levelspan >= nRoll)
			{
				BurnLogs();
			}
			else
			{
				DelayCommand(0.2f, AssignCommand(oPC, ReallyPlayCustomAnimation(oPC, "fire", 0)));
				AssignCommand(oPC, StrikeTinder(nStrikeTime, nStrikeTime, curdist));
				AssignCommand(oPC, PlaySound(STRIKE_SOUND, TRUE));
				/*switch (Random(5))
				{
					case 0:
						feedback = "You dropped your tinder.";
						break;
					case 1:
						feedback = "Your logs show no signs of burning.";
						break;
					case 2:
						feedback = "You ruin your tinder and toss it.";
						break;
					case 3:
						feedback = "Your logs begin to burn but go out.";
						break;
					case 4:
						feedback = "You lose your tinder to a breeze.";
						break;
				}
				SendMessageToPC(oPC, "<color=white>" + feedback);
				*/
				return;
			}
		}
		else if (GetLocalString(oPC, "activity") == "firemaking")
		{
			SetLocalInt(oPC, "isfiremaking", 1);
			DelayCommand(step, AssignCommand(oPC, StrikeTinder(time, curtime-step, curdist)));
		}
		else
		{
			EndFiremaking();
		}
	}
	else if (curdist <= dist && GetLocalString(oPC, "activity") == "firemaking") //we're still running toward it
	{
		//SendMessageToPC(oPC, "<color=white>" + "Current dist:" + FloatToString(curdist) + ", dist: " + FloatToString(dist));
		DelayCommand(0.2f, AssignCommand(oPC, StrikeTinder(time, time, curdist)));
	}
	else
	{
		EndFiremaking();
	}
}

void BurnLogs()
{
	SendMessageToPC(oPC, "<color=white>" + ref + " type: " + type + " logs: " + GetTag(logs));
	//Fire Begin
	AssignCommand(oPC, PlaySound(BURN_SOUND, TRUE));
	EndFiremaking();
	if (type == "Torch")
	{
		DestroyObject(logs);
		object fire = CreateItemOnObject(TORCH_TAG, oPC, 1);
		AssignCommand(oPC, ActionEquipItem(fire, INVENTORY_SLOT_RIGHTHAND));
		DelayCommand(burnTime+30.0, DestroyObject(fire));
		DelayCommand(burnTime+30.0, SendMessageToPC(oPC, "<color=white>" + "Your torch goes out."));
		SendMessageToPC(oPC, "<color=white>" + "You manage to light the torch.");
		return;
	}
	AssignCommand(oPC, ActionMoveAwayFromLocation(loc, FALSE, BACKUP_DISTANCE));
	AssignCommand(oPC, ActionDoCommand(SetFacing(GetFacingFromLocation(loc))));
	string fireL = (ref == "magiclogs") ? MAGIC_LIGHT_TAG : "bonfire";
	string fireV = (ref == "magiclogs") ? MAGIC_VFX_TAG : "bonfire";
	object fire = CreateObject(GetObjectTypes("P"), "bonfire", loc);
	object f_l = CreateObject(GetObjectTypes("L"), fireL, loc);
	object f_v = CreateObject(GetObjectTypes("V"), fireV, loc);
	DestroyObject(logs);
	GiveXP(oPC, "firemaking", xp);
	SetFirstName(fire, type + " Fire");
	SendMessageToPC(oPC, "<color=white>" + "You manage to light the logs.");
	DelayCommand(burnTime+2.0, Spawn("ashes", loc, 10));
	DelayCommand(burnTime+0.0, DestroyObject(fire));
	DelayCommand(burnTime+0.0, DestroyObject(f_v));
	DelayCommand(burnTime+0.0, DestroyObject(f_l));
}

void EndFiremaking()
{
	CloseLoops(oPC);
}