#include <cstrike>
#include <sdktools>
#include <smlib>
#include <sourcemod>

#include "include/csgo_common.inc"

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = {
    name = "Custom CFG launcher",
    author = "marqdevx",
    description = "",
    version = VERSION,
    url = "https://github.com/marqdevx"
}

public void OnPluginStart(){
    RegAdminCmd("sm_cfgscrim", Command_cfg_scrim, ADMFLAG_GENERIC, "Forces a pause");
    RegAdminCmd("sm_cfgpracc", Command_cfg_pracc, ADMFLAG_GENERIC, "Forces a pause");
    RegAdminCmd("sm_cfgsimulation", Command_cfg_simulation, ADMFLAG_GENERIC, "Forces a pause");
    RegAdminCmd("sm_cfgstopdemo", Command_cfg_stopdemo, ADMFLAG_GENERIC, "Forces a pause");
}

public Action welcomeMessage(Handle timer, int client){
    PrintToChat(client, " \x03 Available commands: \x10.scrim\x03, \x10.practice\x03, \x10.simulation\x03, \x10.stopdemo\x03");
}
public void OnClientConnected(int client){
    CreateTimer(8.0, welcomeMessage, client);
}

public Action Command_cfg_scrim(int client, int args){
    ServerCommand("exec scrim");
    PrintToChatAll("Scrim mode");
}

public Action Command_cfg_pracc(int client, int args){
    ServerCommand("exec pracc.cfg");
    PrintToChatAll("Practice mode");
}

public Action Command_cfg_simulation(int client, int args){
    ServerCommand("exec simulacion.cfg");
    PrintToChatAll("Simulation mode");
}

public Action Command_cfg_stopdemo(int client, int args){
    PrintToChatAll("Stopping recording");
    ServerCommand("tv_stoprecord");
}

// Custom chat commands with dot prefix
public void OnClientSayCommand_Post(int client, const char[] command, const char[] sArgs){
    if (!CheckCommandAccess(client, "sm_medic", ADMFLAG_GENERIC))
    {
      return;
    }

    if (StrEqual(sArgs, ".practice", false))
    {
        Command_cfg_pracc(client, 0);
    }
    else if (StrEqual(sArgs, ".scrim", false))
    {
        Command_cfg_scrim(client, 0);
    }
    else if (StrEqual(sArgs, ".simulation", false))
    {
        Command_cfg_simulation(client, 0);
    }
    else if (StrEqual(sArgs, ".stopdemo", false))
    {
        Command_cfg_stopdemo(client, 0);
    }
}