// tb_crafting
/*
    This script checks to see if the PC has an item in their inventory
        item = the item produced
		//fletching
			-48 = rune arrows
			-47 = adamant arrows
			-46 = broad arrows
			-45 = mithril arrows
			-44 = steel arrows
			-43 = iron arrows
			-42 = bronze arrows
			-41 = headless arrows
			-40 = arrow shafts
			//filler
			-16 = magic longbow
			-15 = yew longbow
			-14 = maple longbow
			-13 = willow longbow
			-12 = oak longbow
			-11 = longbow
			-10 = magic shortbow
			-9 = yew shortbow
			-8 = maple shortbow
			-7 = willow shortbow
			-6 = oak shortbow
			-5 = shortbow
		//crafting
			0 = leatherboots
			1 = leathergloves
			2 = leathercowl
			-2 = coif
			3 = leathervambraces
			4 = leatherbody
			-4 = studdedleatherbody
			5 = hardleatherbody
			6 = imphorn boots		imphorn
			7 = imphorn gloves
			8 = imphorn hood
			9= imphorn robes
			10= carapace boots 		carapace
			11= carapace gloves
			12= carapace helm
			13= carapace torso
			14= spidersilk boots	spidersilk
			15= spidersilk gloves
			16= spidersilk hood
			17= spidersilk robes
			18= sapphire			gems
			19= emerald
			20= ruby
			21= diamond
			22= dragonstone
			23= onyx
			24= goldring
			25= sapphirering
			26= emeraldring
			27= rubyring
			28= diamondring
			39= dragonstonering
			30= onyxring
			31= goldnecklace
			32= sapphirenecklace
			33= emeraldnecklace
			34= rubynecklace
			35= diamondnecklace
			36= dragonstonenecklace
			37= onyxnecklace
			38= holynecklace
			39= goldamulet
			40= sapphireamulet
			41= emeraldamulet
			42= rubyamulet
			43= diamondamulet
			44= dragonstoneamulet
			45= onyxamulet
			46= greendhidebody
			47= greendhidevambraces
			48= greendleather
			53= spidersilk boots spidersilk
			54= spidersilk gloves
			55= spidersilk hood
			56= spidersilk robes
			57= reddhidebody
			58= reddhidevambraces
			59= reddleather
			60= sapphirebolttips
			61= emeraldbolttips
			62= rubybolttips
			63= diamondbolttips
		quantity = how many to make
*/

#include "tb_loops"
#include "tb_skillsandxp"
#include "nw_i0_plot"

const string ANIM_CRAFT = "Cooking02";
const string ANIM_SMELT = "smelt";
const string SMELT_SOUND = "al_cv_fireplace1";
const string NEEDLE_SOUND = "sewingzips";
const string CHISEL_SOUND = "as_cv_chiseling1";
const string KNIFE_SOUND = "tinderbox";
//TOOLS
const string CHISEL_TAG = "chisel";
const string NEEDLE_TAG = "needle";
const string KNIFE_TAG = "knife";
//MATERIAL TAGS
//fletch
const string FEATHERS_TAG = "feathers";
const string SHAFTS_TAG = "arrowshaft";
const string HEADLESS_ARROWS_TAG = "headlessarrow";
const string BRONZE_ARROWS_TAG = "bronzearrow";
const string IRON_ARROWS_TAG = "ironarrow";
const string STEEL_ARROWS_TAG = "steelarrow";
const string MITHRIL_ARROWS_TAG = "mithrilarrow";
const string BROAD_ARROWS_TAG = "broadarrow";
const string ADAMANT_ARROWS_TAG = "adamantarrow";
const string RUNE_ARROWS_TAG = "runearrow";
const string BRONZE_ARROWTIPS_TAG = "bronzearrowtip";
const string IRON_ARROWTIPS_TAG = "ironarrowtip";
const string STEEL_ARROWTIPS_TAG = "steelarrowtip";
const string MITHRIL_ARROWTIPS_TAG = "mithrilarrowtip";
const string BROAD_ARROWTIPS_TAG = "broadarrowtip";
const string ADAMANT_ARROWTIPS_TAG = "adamantarrowtip";
const string RUNE_ARROWTIPS_TAG = "runearrowtip";
const string LOGS_TAG = "logs";
const string OAK_LOGS_TAG = "oaklogs";
const string WILLOW_LOGS_TAG = "willowlogs";
const string MAPLE_LOGS_TAG = "maplelogs";
const string YEW_LOGS_TAG = "yewlogs";
const string MAGIC_LOGS_TAG = "yewlogs";
//craft
const string THREAD_TAG = "thread";
const string LEATHER_TAG = "leather";
const string HARDLEATHER_TAG = "hardleather";
const string IMPHIDE_TAG = "imphide";
const string CARAPACE_TAG = "carapace";
const string SPIDERSILK_TAG = "spidersilk";
const string BATWING_TAG = "batwing";
const string GREEN_DLEATHER_TAG = "greendleather";
const string RED_DLEATHER_TAG = "reddleather";
const string UNCUTSAPPHIRE_TAG = "uncutsapphire";
const string UNCUTEMERALD_TAG = "uncutemerald";
const string UNCUTRUBY_TAG = "uncutruby";
const string UNCUTDIAMOND_TAG = "uncutdiamond";
const string UNCUTDRAGONSTONE_TAG = "uncutdragonstone";
const string UNCUTONYX_TAG = "uncutonyx";
const string GOLDBAR_TAG = "goldbar";
const string SILVERBAR_TAG = "silverbar";
//PRODUCT TAGS
//fletch
const string SHORTBOW_TAG = "shortbow";
const string OAK_SHORTBOW_TAG = "oakshortbow";
const string WILLOW_SHORTBOW_TAG = "willowshortbow";
const string MAPLE_SHORTBOW_TAG = "mapleshortbow";
const string YEW_SHORTBOW_TAG = "yewshortbow";
const string MAGIC_SHORTBOW_TAG = "magicshortbow";
const string LONGBOW_TAG = "longbow";
const string OAK_LONGBOW_TAG = "oaklongbow";
const string WILLOW_LONGBOW_TAG = "willowlongbow";
const string MAPLE_LONGBOW_TAG = "maplelongbow";
const string YEW_LONGBOW_TAG = "yewlongbow";
const string MAGIC_LONGBOW_TAG = "magiclongbow";
//craft
const string SAPPHIRE_BOLT_TIPS_TAG = "sapphirebolttips";
const string EMERALD_BOLT_TIPS_TAG = "emeraldbolttips";
const string RUBY_BOLT_TIPS_TAG = "rubybolttips";
const string DIAMOND_BOLT_TIPS_TAG = "diamondbolttips";
const string SAPPHIRE_TAG = "sapphire";
const string EMERALD_TAG = "emerald";
const string RUBY_TAG = "ruby";
const string DIAMOND_TAG = "diamond";
const string DRAGONSTONE_TAG = "dragonstone";
const string ONYX_TAG = "onyx";
const string GOLDRING_TAG = "goldring";
const string SAPPHIRERING_TAG = "sapphirering";
const string EMERALDRING_TAG = "emeraldring";
const string RUBYRING_TAG = "rubyring";
const string DIAMONDRING_TAG = "diamondring";
const string DRAGONSTONERING_TAG = "dragonstonering";
const string ONYXRING_TAG = "onyxring";
const string GOLDNECKLACE_TAG = "goldnecklace";
const string SAPPHIRENECKLACE_TAG = "sapphirenecklace";
const string EMERALDNECKLACE_TAG = "emeraldnecklace";
const string RUBYNECKLACE_TAG = "rubynecklace";
const string DIAMONDNECKLACE_TAG = "diamondnecklace";
const string DRAGONSTONENECKLACE_TAG = "dragonstonenecklace";
const string ONYXNECKLACE_TAG = "onyxnecklace";
const string HOLYNECKLACE_TAG = "holysymbol";
const string GOLDAMULET_TAG = "goldamulet";
const string SAPPHIREAMULET_TAG = "sapphireamulet";
const string EMERALDAMULET_TAG = "emeraldamulet";
const string RUBYAMULET_TAG = "rubyamulet";
const string DIAMONDAMULET_TAG = "diamondamulet";
const string DRAGONSTONEAMULET_TAG = "dragonstoneamulet";
const string ONYXAMULET_TAG = "onyxamulet";
const string LEATHER_BOOTS_TAG = "leatherboots";
const string LEATHER_GLOVES_TAG = "leathergloves";
const string LEATHER_COWL_TAG = "cowl";
const string LEATHER_COIF_TAG = "coif";
const string LEATHER_VAMBRACES_TAG = "leathervambraces";
const string LEATHER_BODY_TAG = "leatherbody";
const string STUDDEDLEATHER_BODY_TAG = "studdedleatherbody";
const string HARD_LEATHER_BODY_TAG = "hardleatherbody";
const string IMPHORN_BOOTS_TAG = "imphornboots";
const string IMPHORN_GLOVES_TAG = "imphorngloves";
const string IMPHORN_HOOD_TAG = "imphornhood";
const string IMPHORN_ROBES_TAG = "imphornrobes";
const string CARAPACE_BOOTS_TAG = "carapaceboots";
const string CARAPACE_GLOVES_TAG = "carapacegloves";
const string CARAPACE_HELM_TAG = "carapacehelm";
const string CARAPACE_TORSO_TAG = "carapacetorso";
const string SPIDERSILK_BOOTS_TAG = "spidersilkboots";
const string SPIDERSILK_GLOVES_TAG = "spidersilkgloves";
const string SPIDERSILK_HOOD_TAG = "spidersilkhood";
const string SPIDERSILK_ROBES_TAG = "spidersilkrobe";
const string BATWING_BOOTS_TAG = "batwingboots";
const string BATWING_GLOVES_TAG = "batwinggloves";
const string BATWING_HOOD_TAG = "batwinghood";
const string BATWING_ROBES_TAG = "batwingrobe";
const string GREEN_DRAGONHIDE_BODY_TAG = "greendhidebody";
const string GREEN_DRAGONHIDE_VAMBRACES_TAG = "greendhidevambraces";
const string RED_DRAGONHIDE_BODY_TAG = "reddhidebody";
const string RED_DRAGONHIDE_VAMBRACES_TAG = "reddhidevambraces";
const string UNFPOT_TAG = "";
const string UNFPIEDISH_TAG = "";
const string UNFBOWL_TAG = "unfiredbowl";
const string UNFPLANTPOT_TAG = "";
const string UNFPOTLID_TAG = "";
const string EMPTYPOT_TAG = "emptypot";
const string PIEDISH_TAG = "pieshell";
const string BOWL_TAG = "emptybowl";
const string PLANTPOT_TAG = "";
const string POTLID_TAG = "";
//PRODUCT XP -down below
//const int LEATHERBOOTS_XP = ;

object oPC;
int prodNum;
int quantity;
int bFletching = 0;
string producttag;
string mat1tag;
string mat2tag;
string tooltag;
int mat1used;
int mat2used;
int numproducts = 1;
string craftsound;
string craftanim;
int xp;
int hasRingOfForging;
float nCraftTime = 3.5f;
location loc;

void StartCrafting();
void EndCrafting(); //you either moved on or finished all the items
void WaitForCraft(float time, float curtime);
void GiveCrafted(int quantity = 1);
void SetupVars(int prodNum);
void DestroyItems(object oTarget,string sItem,int nNumItems);
void ReallyPlayCustomAnimation(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0f)
{
	PlayAnimation(0, 1.0f, 0.01f);
 	PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
}
void main(int product, int _quantity, int bfletching = 0)
{
	bFletching = bfletching;
	oPC = GetPCSpeaker();
	if (GetLocalInt(oPC, "iscrafting") == 1) //a smelting loop is already firing
	{
		return;
	}
	SetLocalString(oPC, "activity", "crafting"); //activity switch aborts loops in all other activities
	loc = GetLocation(oPC);
	quantity = _quantity;
	prodNum = product;
	SendMessageToPC(oPC, "<color=white>" + "You attempt to work the material.");
	StartCrafting();
}

void StartCrafting()
{
	SetupVars(prodNum);
	if (GetNumItems(oPC, mat1tag) < mat1used || GetNumItems(oPC, mat2tag) < mat2used)
	{
		EndCrafting();
		SendMessageToPC(oPC, "<color=white>" + "You've run short on materials to work.");
	}
	if (tooltag != "" && GetItemPossessedBy(oPC, tooltag) == OBJECT_INVALID)
	{
		EndCrafting();
		string message = "nulltool debug";	
		message = (tooltag == NEEDLE_TAG) ? "You need a needle and thread to craft that." : message;
		message = (tooltag == CHISEL_TAG) ? "You need a chisel to cut that." : message;
		message = (tooltag == KNIFE_TAG) ? "You need a knife to fletch that." : message;
		SendMessageToPC(oPC, "<color=white>" + message);
		return;
	}
	AssignCommand(oPC, PlaySound(craftsound, TRUE));
	WaitForCraft(nCraftTime, nCraftTime);
}

void WaitForCraft(float time, float curtime)
{
	//SendMessageToPC(oPC, "<color=white>" + "Time: " + FloatToString(time-curtime));
	float step = 0.5f;
	float curdist = GetDistanceBetweenLocations(GetLocation(oPC), loc);
	if (GetNumItems(oPC, mat1tag) < mat1used || GetNumItems(oPC, mat2tag) < mat2used)
	{
		EndCrafting();
		SendMessageToPC(oPC, "<color=white>" + "You've run short on materials to work.");
		return;
	}
	else if (curtime <= 0.0f)
	{
		quantity--;
		SendMessageToPC(oPC, "<color=white>" + "You successfully work the materials.");
		int level = GetSkillRank(SKILL_CRAFTING, oPC);
		level = (bFletching == 1) ? GetSkillRank(SKILL_FLETCHING, oPC) : level; 
		if (level > 45) level = 45;
		int levelbonus = level-15;
		int spot = 50+levelbonus;
		DestroyItems(oPC, mat1tag, mat1used);
		DestroyItems(oPC, mat2tag, mat2used);
		DelayCommand(0.1f, AssignCommand(oPC, GiveCrafted(numproducts)));
		if (bFletching == 0){GiveXP(oPC, "crafting", xp);}
		else{GiveXP(oPC, "fletching", xp);}
		StartCrafting();
	}
	else if (curdist < 0.3f && GetLocalString(oPC, "activity") == "crafting")
	{
		SetLocalInt(oPC, "iscrafting", 1);
		if (quantity <= 0)
		{
			EndCrafting();
			return;
		}
		DelayCommand(0.2f, AssignCommand(oPC, ReallyPlayCustomAnimation(oPC, craftanim, 0)));
		DelayCommand(step, AssignCommand(oPC, WaitForCraft(time, curtime-step)));
	}
	else
	{
		EndCrafting();
		//SendMessageToPC(oPC, "<color=white>" + "Current Activity: " + GetLocalString(oPC, "activity"));
	}
}

void GiveCrafted(int quantity)
{
	CreateItemOnObject(producttag, oPC, quantity);
}


void SetupVars(int prodNum)
{
	//string leftringtag = GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
	//string rightringtag = GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
	//string glovestag = GetTag(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC));
	craftsound = NEEDLE_SOUND;
	craftanim = ANIM_CRAFT;
	craftsound = (prodNum >= 18 && prodNum <= 23) ? CHISEL_SOUND : craftsound;
	craftsound = (prodNum >= 24 && prodNum <= 45) ? SMELT_SOUND : craftsound;
	craftanim = (prodNum >= 24 && prodNum <= 45) ? ANIM_SMELT : craftanim;
	tooltag = (prodNum >= 0 && prodNum <= 17) ? NEEDLE_TAG : tooltag;
	tooltag = (prodNum >= 18 && prodNum <= 23) ? CHISEL_TAG : tooltag;
	//fletch
	craftsound = (prodNum <= -5) ? KNIFE_SOUND : craftsound;
	craftanim = (prodNum <= -5) ? ANIM_CRAFT : craftanim;
	tooltag = (prodNum <= -5) ? KNIFE_TAG : tooltag;
	
	switch(prodNum)
	{
//const string LOGS_TAG = "logs";
//const string OAK_TAG = "oaklogs";
//const string WILLOW_TAG = "willowlogs";
//const string MAPLE_TAG = "maplelogs";
//const string YEW_TAG = "yewlogs";
//FLETCHING
	//shafts and arrows
		case -48:
			numproducts = 15;
			producttag = RUNE_ARROWS_TAG;
			mat1tag = HEADLESS_ARROWS_TAG;
			mat1used = 15;
			mat2tag = RUNE_ARROWTIPS_TAG;
			mat2used = 15;
			xp = 188;
			break;
		case -47:
			numproducts = 15;
			producttag = ADAMANT_ARROWS_TAG;
			mat1tag = HEADLESS_ARROWS_TAG;
			mat1used = 15;
			mat2tag = ADAMANT_ARROWTIPS_TAG;
			mat2used = 15;
			xp = 150;
			break;
		case -46:
			numproducts = 15;
			producttag = BROAD_ARROWS_TAG;
			mat1tag = HEADLESS_ARROWS_TAG;
			mat1used = 15;
			mat2tag = BROAD_ARROWTIPS_TAG;
			mat2used = 15;
			xp = 150;
			break;
		case -45:
			numproducts = 15;
			producttag = MITHRIL_ARROWS_TAG;
			mat1tag = HEADLESS_ARROWS_TAG;
			mat1used = 15;
			mat2tag = MITHRIL_ARROWTIPS_TAG;
			mat2used = 15;
			xp = 5;
			break;
		case -44:
			numproducts = 15;
			producttag = STEEL_ARROWS_TAG;
			mat1tag = HEADLESS_ARROWS_TAG;
			mat1used = 15;
			mat2tag = STEEL_ARROWTIPS_TAG;
			mat2used = 15;
			xp = 5;
			break;
		case -43:
			numproducts = 15;
			producttag = IRON_ARROWS_TAG;
			mat1tag = HEADLESS_ARROWS_TAG;
			mat1used = 15;
			mat2tag = IRON_ARROWTIPS_TAG;
			mat2used = 15;
			xp = 5;
			break;
		case -42:
			numproducts = 15;
			producttag = BRONZE_ARROWS_TAG;
			mat1tag = HEADLESS_ARROWS_TAG;
			mat1used = 15;
			mat2tag = BRONZE_ARROWTIPS_TAG;
			mat2used = 15;
			xp = 5;
			break;
		case -41:
			numproducts = 15;
			producttag = HEADLESS_ARROWS_TAG;
			mat1tag = SHAFTS_TAG;
			mat1used = 15;
			mat2tag = FEATHERS_TAG;
			mat2used = 15;
			xp = 5;
			break;
		case -40:
			numproducts = 15;
			producttag = SHAFTS_TAG;
			mat1tag = LOGS_TAG;
			mat1used = 1;
			xp = 5;
	//longbows
		case -16:
			producttag = MAGIC_LONGBOW_TAG;
			mat1tag = MAGIC_LOGS_TAG;
			mat1used = 1;
			xp = 183;
			break;
		case -15:
			producttag = YEW_LONGBOW_TAG;
			mat1tag = YEW_LOGS_TAG;
			mat1used = 1;
			xp = 150;
			break;
		case -14:
			producttag = MAPLE_LONGBOW_TAG;
			mat1tag = MAPLE_LOGS_TAG;
			mat1used = 1;
			xp = 117;
			break;
		case -13:
			producttag = WILLOW_LONGBOW_TAG;
			mat1tag = WILLOW_LOGS_TAG;
			mat1used = 1;
			xp = 83;
			break;
		case -12:
			producttag = OAK_LONGBOW_TAG;
			mat1tag = OAK_LOGS_TAG;
			mat1used = 1;
			xp = 50;
			break;
		case -11:
			producttag = LONGBOW_TAG;
			mat1tag = LOGS_TAG;
			mat1used = 1;
			xp = 20;
			break;
	//shortbows
		case -10:
			producttag = MAGIC_SHORTBOW_TAG;
			mat1tag = MAGIC_LOGS_TAG;
			mat1used = 1;
			xp = 167;
			break;
		case -9:
			producttag = YEW_SHORTBOW_TAG;
			mat1tag = YEW_LOGS_TAG;
			mat1used = 1;
			xp = 135;
			break;
		case -8:
			producttag = MAPLE_SHORTBOW_TAG;
			mat1tag = MAPLE_LOGS_TAG;
			mat1used = 1;
			xp = 100;
			break;
		case -7:
			producttag = WILLOW_SHORTBOW_TAG;
			mat1tag = WILLOW_LOGS_TAG;
			mat1used = 1;
			xp = 67;
			break;
		case -6:
			producttag = OAK_SHORTBOW_TAG;
			mat1tag = OAK_LOGS_TAG;
			mat1used = 1;
			xp = 33;
			break;
		case -5:
			producttag = SHORTBOW_TAG;
			mat1tag = LOGS_TAG;
			mat1used = 1;
			xp = 10;
			break;
//CRAFT
		case -4: //studdedleatherbody
			producttag = STUDDEDLEATHER_BODY_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = LEATHER_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 40;
			break;
		case -2: //coif
			producttag = LEATHER_COIF_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = LEATHER_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 37;
			break;
		case 0: //leatherboots
			producttag = LEATHER_BOOTS_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = LEATHER_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 16;
			break;
		case 1: //leathergloves
			producttag = LEATHER_GLOVES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = LEATHER_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 13;
			break;
		case 2: //leathercowl
			producttag = LEATHER_COWL_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = LEATHER_TAG;
			mat1used = 2;
			mat2used = 2;
			xp = 19;
			break;
		case 3: //leathervambraces
			producttag = LEATHER_VAMBRACES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = LEATHER_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 22;
			break;
		case 4: //leatherbody
			producttag = LEATHER_BODY_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = LEATHER_TAG;
			mat1used = 5;
			mat2used = 5;
			xp = 50;
			break;
		case 5: //hardleatherboody
			producttag = HARD_LEATHER_BODY_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = HARDLEATHER_TAG;
			mat1used = 5;
			mat2used = 5;
			xp = 35;
			break;
		case 6: //imphideboots
			producttag = IMPHORN_BOOTS_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = IMPHIDE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 10;
			break;
		case 7: //imphidegloves
			producttag = IMPHORN_GLOVES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = IMPHIDE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 10;
			break;
		case 8: //imphidehood
			producttag = IMPHORN_HOOD_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = IMPHIDE_TAG;
			mat1used = 2;
			mat2used = 2;
			xp = 20;
			break;
		case 9: //imphiderobes
			producttag = IMPHORN_ROBES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = IMPHIDE_TAG;
			mat1used = 5;
			mat2used = 5;
			xp = 50;
			break;
		case 10: //carapaceboots
			producttag = CARAPACE_BOOTS_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = CARAPACE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 12;
			break;
		case 11: //carapacegloves
			producttag = CARAPACE_GLOVES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = CARAPACE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 12;
			break;
		case 12: //carapacehelm
			producttag = CARAPACE_HELM_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = CARAPACE_TAG;
			mat1used = 2;
			mat2used = 2;
			xp = 24;
			break;
		case 13: //carapacetorso
			producttag = CARAPACE_TORSO_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = CARAPACE_TAG;
			mat1used = 5;
			mat2used = 5;
			xp = 60;
			break;
		case 14: //spidersilkboots
			producttag = SPIDERSILK_BOOTS_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = SPIDERSILK_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 12;
			break;
		case 15: //spidersilkgloves
			producttag = SPIDERSILK_GLOVES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = SPIDERSILK_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 12;
			break;
		case 16: //spidersilkhood
			producttag = SPIDERSILK_HOOD_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = SPIDERSILK_TAG;
			mat1used = 2;
			mat2used = 2;
			xp = 25;
			break;
		case 17: //spidersilkrobes
			producttag = SPIDERSILK_ROBES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = SPIDERSILK_TAG;
			mat1used = 5;
			mat2used = 5;
			xp = 62;
			break;
		case 18: //sapphire
			producttag = SAPPHIRE_TAG;
			mat1tag = UNCUTSAPPHIRE_TAG;
			mat1used = 1;
			xp = 50;
			break;
		case 19: //emerald
			producttag = EMERALD_TAG;
			mat1tag = UNCUTEMERALD_TAG;
			mat1used = 1;
			xp = 70;
			break;
		case 20: //ruby
			producttag = RUBY_TAG;
			mat1tag = UNCUTRUBY_TAG;
			mat1used = 1;
			xp = 85;
			break;
		case 21: //diamond
			producttag = DIAMOND_TAG;
			mat1tag = UNCUTDIAMOND_TAG;
			mat1used = 1;
			xp = 108;
			break;
		case 22: //dragonstone
			producttag = DRAGONSTONE_TAG;
			mat1tag = UNCUTDRAGONSTONE_TAG;
			mat1used = 1;
			xp = 138;
			break;
		case 23: //onyx
			producttag = ONYX_TAG;
			mat1tag = UNCUTONYX_TAG;
			mat1used = 1;
			xp = 170;
			break;
//***Rings
		case 24: //goldring
			producttag = GOLDRING_TAG;
			mat1tag = GOLDBAR_TAG;
			mat1used = 1;
			xp = 15;
			break;
		case 25: //sapphirering
			producttag = SAPPHIRERING_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = SAPPHIRE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 40;
			break;
		case 26: //emeraldring
			producttag = EMERALDRING_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = EMERALD_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 55;
			break;
		case 27: //rubyring
			producttag = RUBYRING_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = RUBY_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 70;
			break;
		case 28: //diamondring
			producttag = DIAMONDRING_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = DIAMOND_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 85;
			break;
		case 29: //dragonstonering
			producttag = DRAGONSTONERING_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = DRAGONSTONE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 100;
			break;
		case 30: //onyxring
			producttag = ONYXRING_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = ONYX_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 115;
			break;
//***Necklaces
		case 31: //necklace
			producttag = GOLDNECKLACE_TAG;
			mat1tag = GOLDBAR_TAG;
			mat1used = 1;
			xp = 20;
			break;
		case 32: //sapphirenecklace
			producttag = SAPPHIRENECKLACE_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = SAPPHIRE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 55;
			break;
		case 33: //emeraldnecklace
			producttag = EMERALDNECKLACE_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = EMERALD_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 60;
			break;
		case 34: //rubynecklace
			producttag = RUBYNECKLACE_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = RUBY_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 75;
			break;
		case 35: //diamondnecklace
			producttag = DIAMONDNECKLACE_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = DIAMOND_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 90;
			break;
		case 36: //dragonstonenecklace
			producttag = DRAGONSTONENECKLACE_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = DRAGONSTONE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 105;
			break;
		case 37: //onyxnecklace
			producttag = ONYXNECKLACE_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = ONYX_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 120;
			break;
		case 38: //holynecklace
			producttag = HOLYNECKLACE_TAG;
			mat1tag = SILVERBAR_TAG;
			mat1used = 1;
			xp = 50;
			break;
//***Amulets
		case 39: //goldamulet
			producttag = GOLDAMULET_TAG;
			mat1tag = GOLDBAR_TAG;
			mat1used = 1;
			xp = 30;
			break;
		case 40: //sapphireamulet
			producttag = SAPPHIREAMULET_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = SAPPHIRE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 65;
			break;
		case 41: //emeraldamulet
			producttag = EMERALDAMULET_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = EMERALD_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 70;
			break;
		case 42: //rubyamulet
			producttag = RUBYAMULET_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = RUBY_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 85;
			break;
		case 43: //diamondamulet
			producttag = DIAMONDAMULET_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = DIAMOND_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 100;
			break;
		case 44: //dragonstoneamulet
			producttag = DRAGONSTONEAMULET_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = DRAGONSTONE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 105;
			break;
		case 45: //onyxamulet
			producttag = ONYXAMULET_TAG;
			mat1tag = GOLDBAR_TAG;
			mat2tag = ONYX_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 165;
			break;
//**Pottery**
		case 46: //emptypot
			producttag = EMPTYPOT_TAG;
			mat1tag = UNFPOT_TAG;
			mat1used = 1;
			xp = 7;
			break;
		case 47: //piedish
			producttag = PIEDISH_TAG;
			mat1tag = UNFPIEDISH_TAG;
			mat1used = 1;
			xp = 10;
			break;
		case 48: //bowl
			producttag = BOWL_TAG;
			mat1tag = UNFBOWL_TAG;
			mat1used = 1;
			xp = 15;
			break;
		case 49: //plantpot
			producttag = PLANTPOT_TAG;
			mat1tag = UNFPLANTPOT_TAG;
			mat1used = 1;
			xp = 18;
			break;
		case 50: //potlid
			producttag = POTLID_TAG;
			mat1tag = UNFPOTLID_TAG;
			mat1used = 1;
			xp = 20;
			break;
		case 51: //greendhidebody
			producttag = GREEN_DRAGONHIDE_BODY_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = GREEN_DLEATHER_TAG;
			mat1used = 1;
			mat2used = 5;
			xp = 310;
			break;
		case 52: //greendhidevambraces
			producttag = GREEN_DRAGONHIDE_VAMBRACES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = GREEN_DLEATHER_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 62;
			break;
		case 53: //batwinggloves
			producttag = BATWING_GLOVES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = BATWING_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 50;
			break;
		case 54: //batwingboots
			producttag = BATWING_BOOTS_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = BATWING_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 50;
			break;
		case 55: //batwinghood
			producttag = BATWING_HOOD_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = BATWING_TAG;
			mat1used = 1;
			mat2used = 2;
			xp = 100;
			break;
		case 56: //batwingrobes
			producttag = BATWING_ROBES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = BATWING_TAG;
			mat1used = 1;
			mat2used = 5;
			xp = 250;
			break;
		case 57: //reddhidebody
			producttag = RED_DRAGONHIDE_BODY_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = RED_DLEATHER_TAG;
			mat1used = 1;
			mat2used = 5;
			xp = 390;
			break;
		case 58: //reddhidevambraces
			producttag = RED_DRAGONHIDE_VAMBRACES_TAG;
			mat1tag = THREAD_TAG;
			mat2tag = RED_DLEATHER_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = 78;
			break;
		case 60: //sapphirebolttips
			producttag = SAPPHIRE_BOLT_TIPS_TAG;
			mat1tag = SAPPHIRE_TAG;
			mat1used = 1;
			xp = 5;
			break;
		case 61: //emeraldbolttips
			producttag = EMERALD_BOLT_TIPS_TAG;
			mat1tag = EMERALD_TAG;
			mat1used = 1;
			xp = 6;
			break;
		case 62: //rubybolttips
			producttag = RUBY_BOLT_TIPS_TAG;
			mat1tag = RUBY_TAG;
			mat1used = 1;
			xp = 7;
			break;
		case 63: //diamondbolttips
			producttag = DIAMOND_BOLT_TIPS_TAG;
			mat1tag = DIAMOND_TAG;
			mat1used = 1;
			xp = 8;
			break;
	}
}

void EndCrafting()
{
	CloseLoops(oPC);
}

void DestroyItems(object oTarget,string sItem,int nNumItems)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);
	
    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
            int nRemainingToDestroy = nNumItems - nCount;
			int nStackSize = GetItemStackSize(oItem);
			
			if(nStackSize <= nRemainingToDestroy)
			{
				DestroyObject(oItem,0.1f);
				nCount += nStackSize;
			}
            else
			{
				int nNewStackSize = nStackSize - nRemainingToDestroy;
				SetItemStackSize(oItem, nNewStackSize);
				break;
			}
        }
        oItem = GetNextItemInInventory(oTarget);
    }
   return;
}