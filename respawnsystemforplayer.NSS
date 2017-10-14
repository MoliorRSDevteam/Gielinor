/*******************************
Script: Respawn At Start Location
Created By: Jaden Wagener
Created On: 08/30/02
*******************************/
//Respawns a player back at the start location.
//Script should be placed in the module's OnRespawn slot.
//NOTE: due to the current bug issue with the GetStartLocation function,
//a waypoint must be created at the starting location and its tag inserted
//in place of NW_WAYPOINT001.
#include "nw_i0_plot"
//Uses some in game default scripts
void main()
{
   //Set variables
   object xPC;
   int xHP;
   location xStart;
   effect xRez, xHeal, xVisual, xBad;
   //Populate variables
   xPC = GetLastRespawnButtonPresser();                      //Player respawning
   xHP = GetMaxHitPoints(xPC);                               //Player's Max HP
   xStart = GetLocation(GetWaypointByTag("lummydeathspawnpoint")); //Start location
   xRez = EffectResurrection();                              //Resurrect effect
   xHeal = EffectHeal(xHP);                                  //Heal effect
   //Resurrect at start location
   ApplyEffectToObject(DURATION_TYPE_INSTANT,xRez,xPC,0.0f);
   ApplyEffectToObject(DURATION_TYPE_INSTANT,xHeal,xPC,0.0f);
   RemoveEffects(xPC); //Removes Negative effects. Is defined in nw_i0_plot.
   AssignCommand(xPC,ActionJumpToLocation(xStart));
}