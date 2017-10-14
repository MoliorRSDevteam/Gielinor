void CloseLoops(object oPC)
{
    DeleteLocalInt(oPC, "isfiremaking");
    DeleteLocalInt(oPC, "isfishing");
    DeleteLocalInt(oPC, "issmelting");
    DeleteLocalInt(oPC, "issmithing");
    DeleteLocalInt(oPC, "iscooking");
    DeleteLocalInt(oPC, "iscrafting");
    DeleteLocalInt(oPC, "iswoodcutting");
    DeleteLocalInt(oPC, "ismining");
}