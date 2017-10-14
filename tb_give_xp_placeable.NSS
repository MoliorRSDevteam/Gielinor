#include "tb_skillsandxp"
void main()
{
    object oPC = GetLastUsedBy();

    GiveXP( oPC, GetLocalString(OBJECT_SELF, "skill"), 300000 );
}