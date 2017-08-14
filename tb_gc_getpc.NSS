#include "ginc_param_const"
int StartingConditional()
{
    SetLocalObject(OBJECT_SELF, "LASTPC", GetTarget("$PC", TARGET_OBJECT_SELF));
	return 1;
}