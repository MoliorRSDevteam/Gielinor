void main()
{
    string sXML;
    string sSCREEN;
    string sPLACE = GetTag(OBJECT_SELF);
    if (sPLACE == "furnace")
    {
        sXML = "smithingmenu.xml";
        sSCREEN = "SMITHINGMENU";
    }
		else if (sPLACE == "potterywheel")
    {
        sXML = "potterytable.xml";
        sSCREEN = "POTTERYWHEEL";
    }
		else if (sPLACE == "anvil")
    {
        sXML = "anvilmenu.xml";
        sSCREEN = "ANVILMENU";
    }
		else if (sPLACE == "smelter")
    {
        sXML = "smeltmenu.xml";
        sSCREEN = "SMELTMENU";
    }
		else if (sPLACE == "bitsrefinery")
    {
        sXML = "refinermenu.xml";
        sSCREEN = "REFINERMENU";
    }
		else if (sPLACE == "watersource")
    {
        sXML = "watermenu.xml";
        sSCREEN = "WATERMENU";
    }
		else if (sPLACE == "sink")
    {
        sXML = "cooksink.xml";
        sSCREEN = "COOKSINKMENU";
    }
		else if (sPLACE == "spinningwheelfletching")
    {
        sXML = "loommenu.xml";
        sSCREEN = "LOOMMENU";
    }
		else if (sPLACE == "spit")
    {
        sXML = "ovenorfire.xml";
        sSCREEN = "OVENMENU";
    }
			else if (sPLACE == "oven")
    {
        sXML = "ovenorfire.xml";
        sSCREEN = "OVENMENU";
    }
		else if (sPLACE == "cremationpyre")
    {
        sXML = "bonesmenu.xml";
        sSCREEN = "BONESMENU";
    }
        else if (sPLACE == "plotitemsplace")
    {
        sXML = "questremoveitemgui.xml";
        sSCREEN = "PLOTITEMMENU";
    }
       else if (sPLACE == "patronstatue")
    {
        sXML = "patrons.xml";
        sSCREEN = "PATRONSMENU";
    }
       else if (sPLACE == "millforflour")
    {
        sXML = "millforflour.xml";
        sSCREEN = "MILLFLOURSMENU";
    }
    else return;
    object oPC = GetLastUsedBy();
    DisplayGuiScreen(oPC, sSCREEN, FALSE, sXML);
}