//-----------------------------------------------------------------------
// <copyright file="deathscript.nss" company="Molior RS">
// Copyright (c) Molior RS. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------

void main()
{
    object oPC = GetLastPlayerDied();
	DisplayMessageBox(oPC, -1, "You have died.", "gui_cityrespawn", "gui_waitrespawn", TRUE, "SCREEN_MESSAGEBOX_DEFAULT", -1, "Respawn", -1, "Wait");
}