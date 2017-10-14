    BK: October 8 2002: Overriden for Expansion */
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles       mod: kevL's
//:: Created On: November 6, 2001    on: May 2009, Jul 2010
//:://////////////////////////////////////////////
// BMA-OEI 7/20/06 -- Temp death screen
// BMA-OEI 11/08/06 -- Added engine death GUI: SCREEN_DEATH_DEFAULT
// (ingamegui.ini) is force closed upon resurrection
// kevL's modified, 2010 ..
//      - modded further, 2012 may 14
//triston 1/10/16

#include "tb_spawndespawn"

const string CORPSE_TAG = "gravestone";
float despawntime = IntToFloat(DEFAULT_DESPAWN_TIME);

// Drop all items & Gold
void DropEverything(object oPC);
//
void TransferBag(object oItem, object oCorpse);


// Display death pop-up to oPC
void kL_ShowDeathScreen(object oPC)
{
    DisplayMessageBox(oPC,
                        FALSE,                        // MessageBox STRREF
                        GetStringByStrRef(181408),    // text: "You have died."
                        "gui_cityrespawn",            // callback for 'ok'
                        "",                         // callback for 'cancel'
                        FALSE,                        // no cancel option.
                        "",                         // GUIScreenName: "SCREEN_MESSAGEBOX_DEFAULT"
                        6603,                        // ok STRREF: "Respawn"
                        "Respawn",                    // ok text, overrides STRREF
                        FALSE,                        // cancel STRREF: ""
                        "");                        // cancel text.
}


void main()
{
    SendMessageToPC(GetFirstPC(FALSE), "");

    object oPC = GetLastPlayerDied();
    SendMessageToPC(GetFirstPC(FALSE), "You have died : " + GetName(oPC));

    DropEverything(oPC); // HERE IT IS.

    // try to avoid possible complications
    AssignCommand(oPC, SetCommandable(TRUE));
    AssignCommand(oPC, ClearAllActions(TRUE));

    // he's dead jim
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oPC);

    // Check for additional death script
    string sDeathScript = GetLocalString(oPC, "duelscriptdeath1");
    if (sDeathScript != "") ExecuteScript(sDeathScript, oPC);

	
    // player is controlling the OwnedPC; try to switch to Companion:
    if (GetIsPC(oPC))
    {
        object oCompanion;
        string sCompanion = GetFirstRosterMember();
        while (sCompanion != "")
        {
            oCompanion = GetObjectFromRosterName(sCompanion);
            if (GetIsObjectValid(oCompanion)
                    && GetFactionEqual(oCompanion, oPC)
                    && !GetIsDead(oCompanion)
                    && !GetIsCompanionPossessionBlocked(oCompanion)
                    && !GetIsPC(oCompanion))
            {
                // Give control to the first living, unblocked, uncontrolled Companion
                SetOwnersControlledCompanion(oPC, oCompanion);

                return;
            }

            sCompanion = GetNextRosterMember();
        }
    }
    // if you're not controlling the OwnedPC, just let it die unless everyone else is dead too
    else
    {
        // if the character that the player is controlling isn't dead-dead, do nothing.
        oPC = GetControlledCharacter(oPC);
        if (!GetIsDead(oPC, TRUE)) return;

        object oFM = GetFirstFactionMember(oPC, FALSE);
        while (GetIsObjectValid(oFM))
        {
            // if there is a living Companion ( not an Associate or another PC )
            // This really should check for things like, oh Permanent paralysis etc.
            if (oPC != oFM
                    && !GetIsDead(oFM)
//                    && !GetIsCompanionPossessionBlocked(oFM)
                    && !GetIsPC(oFM)
                    && !GetAssociateType(oFM))
            {
                // it's all good.
                return;
            }

            oFM = GetNextFactionMember(oPC, FALSE);
        }

        // else Pop the player into the OwnedCorpse:
        oPC = SetOwnersControlledCompanion(oPC);
    }


    // below this line, the Party is dead! ( except perhaps another PC )
    DelayCommand(4.6f, kL_ShowDeathScreen(oPC));
}


//
void DropEverything(object oPC)
{
    location lLoc = GetLocation(oPC);
    object oCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, CORPSE_TAG, lLoc);
	SetFirstName(oCorpse, GetName(oPC));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectNWN2SpecialEffectFile("fx_lootbag"), oCorpse);
	DestroyObject(oCorpse, despawntime);
	
    object oItem = OBJECT_INVALID;

    int iSlot;
    for (iSlot = INVENTORY_SLOT_HEAD; iSlot <= INVENTORY_SLOT_BOLTS; iSlot++)
    {
        oItem = GetItemInSlot(iSlot, oPC);
        if (GetIsObjectValid(oItem)
            && !GetItemCursedFlag(oItem))
        {
            Despawn(CopyItem(oItem, oCorpse, TRUE), FloatToInt(despawntime));
            DestroyObject(oItem, 0.f, FALSE);
        }
    }

    oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (!GetItemCursedFlag(oItem))
        {
            if (!GetHasInventory(oItem)
                || !GetIsObjectValid(GetFirstItemInInventory(oItem)))
            {
                Despawn(CopyItem(oItem, oCorpse, TRUE),  FloatToInt(despawntime));
                DestroyObject(oItem, 0.f, FALSE);
            }
            else // is a container with something in it
            {
                DelayCommand(0.1f, TransferBag(oItem, oCorpse));
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
}

//
void TransferBag(object oItem, object oCorpse)
{
    // if a Cursed item is still in the Bag, neither will not be copied or destroyed
    if (!GetIsObjectValid(GetFirstItemInInventory(oItem)))
    {
        CopyItem(oItem, oCorpse, TRUE);
        DestroyObject(oItem, 0.f, FALSE);
    }
}