/* ===============================================
    GENERAL BRIEFING NOTES
     - Uses HTML style syntax. All supported tags can be found here - https://community.bistudio.com/wiki/createDiaryRecord
     - For images use <img image='FILE'></img> (for those familiar with HTML note it is image rather than src).
     - Note that using the " character inside the briefing block is forbidden use ' instead of ".
*/

/* ===============================================
    SITUATION
     - Outline of what is going on, where we are we and what has happened before the mission has started? This needs to contain any relevant background information.
     - Draw attention to friendly and enemy forces in the area. The commander will make important decisions based off this information.
     - Outline present weather conditions, players will typically assume that it is daylight with sunny weather.
*/

private _situation = ["diary", ["Situation","
<br/>
RATS practice shooting, flying, building, and other things.
<br/><br/>

<font size='18'>ENEMY FORCES</font>
<br/>
None, probably.
<br/><br/>

<font size='18'>FRIENDLY FORCES</font>
<br/>
None, probably.
<br/>
<br/>
<img image='z\mjb\addons\flags\data\ratsFlag_ca.paa' width='256' height='128' />
"]];

/* ===============================================
    MISSION
     - Describe any objectives that the team is expected to complete.
     - Summarize(!) the overall task. This MUST be short and clear.
*/

private _mission = ["diary", ["Mission","
<br/>
- Have fun practicing stuff.
"]];

/* ===============================================
    ADMINISTRATION
     - Outline of logistics: available resources (equipment/vehicles) and ideally a summary of their capabilities.
     - Outline of how to use any mission specific features/scripts.
     - Seating capacities of each vehicle available for use.
*/

private _administration = ["diary", ["Administration","
<br/>
Flagpoles marked with insert markers are teleporters to different spots.
<br/>
<br/><marker name='respawn_west_mk_sab'>Stratis Air Base</marker> has some helos and planes for practice.
<br/>
<br/><marker name='respawn_west_mk_fs'>Fortify Sandbox</marker> has a computer with addActions mimicking ACE Fortify chat commands, don't forget the fortify tool.
<br/>
<br/><marker name='respawn_west_mk_kh'>Kill House</marker> is made by Inquietude, and can be reset at the computer near the entrance.
<br/>
<br/><marker name='respawn_west_mk_qup'>Quiet Place</marker> is for chilling, try not to fly over or shoot near it.

"]];

player createDiaryRecord _administration;
player createDiaryRecord _mission;
player createDiaryRecord _situation;