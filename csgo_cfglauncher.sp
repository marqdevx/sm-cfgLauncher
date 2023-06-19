#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#define VERSION "1.0.0"

ConVar g_cvarPracticeCFG = null;
ConVar g_cvarScrimCFG = null;
ConVar g_cvarSimulationCFG = null;

public Plugin myinfo = {
    name = "Custom CFG launcher",
    author = "marqdevx",
    description = "",
    version = VERSION,
    url = "https://github.com/marqdevx/sm-plugins"
}

public void OnPluginStart(){
    //CFGs name
    g_cvarPracticeCFG = CreateConVar("sm_cfg_practice", "pracc.cfg", "Default cfg - practice");
    g_cvarScrimCFG = CreateConVar("sm_cfg_scrim", "scrim.cfg", "Default cfg - practice");
    g_cvarSimulationCFG = CreateConVar("sm_cfg_simulation", "simulation.cfg", "Default cfg - practice");

    RegAdminCmd("sm_cfgscrim", Command_cfg_scrim, ADMFLAG_GENERIC, "Launches scrim CFG");
    RegAdminCmd("sm_cfgpracc", Command_cfg_pracc, ADMFLAG_GENERIC, "Launches practice CFG");
    RegAdminCmd("sm_cfgsimulation", Command_cfg_simulation, ADMFLAG_GENERIC, "Launches simulation CFG");
}

public Action welcomeMessage(Handle timer, int client){
    PrintToChat(client, " \x02[CFG]\x03 Available commands: \x10.scrim\x03, \x10.practice\x03, \x10.simulation\x03");

    return Plugin_Handled;
}

public void OnClientConnected(int client){
    CreateTimer(8.0, welcomeMessage, client);
}

public Action Command_cfg_scrim(int client, int args){
    ServerCommand("exec scrim");
    PrintToChatAll("Scrim mode");
    
    return Plugin_Handled;
}

public Action Command_cfg_pracc(int client, int args){
    ServerCommand("exec pracc.cfg");
    PrintToChatAll("Practice mode");

    return Plugin_Handled;
}

public Action Command_cfg_simulation(int client, int args){
    ServerCommand("exec simulacion.cfg");
    PrintToChatAll("Simulation mode");

    return Plugin_Handled;
}

// Custom chat commands with dot prefix
public void OnClientSayCommand_Post(int client, const char[] command, const char[] sArgs){
    if (!CheckCommandAccess(client, "sm_cfgscrim", ADMFLAG_GENERIC))
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
}