//-----------------------------------------------------------------------
// <copyright file="gui_death_respawn_self.nss" company="Molior RS">
// Copyright (c) Molior RS. All rights reserved.
// </copyright>
// <revision> 1 </revision>
// <lasteditedby>Austin Jensen</lasteditedby>
//-----------------------------------------------------------------------
// gui_death_respawn_self.nss
/*
	NWN2 Default Death Screen 'Respawn' callback
*/
// BMA-OEI 7/20/06


#include "ginc_death"


void main() {


//	ResurrectCreature( OBJECT_SELF );

	SetLocalObject(GetModule(), "LAST_RESPAWN_BUTTON_PRESSER", OBJECT_SELF);
	ExecuteScript("row_mod_respawn", GetModule());	

}