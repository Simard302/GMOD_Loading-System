TW_LOADINGSYSTEM.Config = {
  MaxAddonSizeBytes = 500000000,  -- Maximum downloadable addon size (if bigger size, do not download). Prevents freezing on big addons
  IsDarkrpBased = true,

  -- Add any workshop IDs (clientside or serverside) here.
  -- This will be checked serverside before making every client download an addon/server mount an addon.
  WhitelistedAddons = {
    ['1878568737'] = true,
    ['1755725700'] = true,
    ['947544869'] = true,
    ['899046901'] = true,
    ['1529901430'] = true,
    ['1713950767'] = true,
    ['1894908676'] = true,
    ['1580175017'] = true,
    ['1723252181'] = true,
    ['1739279660'] = true,
    ['1959895851'] = true,
    ['1423892109'] = true,
    ['930396962'] = true,
    ['1944228375'] = true,
    ['2013167925'] = true,
    ['2014672223'] = true,
    ['2024979336'] = true,
    ['2014029867'] = true,
    ['1952443043'] = true,
    ['2061996588'] = true,
    ['1406438579'] = true,
    ['705124288'] = true,
    ['188562859'] = true,
    ['1411777865'] = true,
    ['668821867'] = true,
    ['1613615135'] = true,
    ['1898215773'] = true,
    ['1894647095'] = true,
    ['2040309290'] = true,
    ['2142029112'] = true,
    ['2332782456'] = true
  },

  AddonMenuTree = {
    ['Ships'] = {
      ['V-19 and V-Wing'] = {
        Description = "The V-19 and V-Wing ship using LFS",
        Guidelines = "This ship is to be used by Pilot interceptors (Viper)",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1755725700",
      },
      ['LAAT/i, LAAT/c and ATTE'] = {
        Description = "The LAAT/i, LAAT/c and ATTE using LFS",
        Guidelines = "These ships are to be used by transporters (Rhinos) and vehicle by troopers",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1878568737",
      },
      ['Delta-7 Jedi Starfighter'] = {
        Description = "The Delta-7 Jedi starfighters",
        Guidelines = "Spawn these ships for Jedi during air combat.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "947544869",
      },
      ['Frigates Pack'] = {
        Description = "A Frigate Pack with lots of CIS and Republic ships",
        Guidelines = "Spawn these ships as props in the air above battles, use them over vehicles when possible.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "899046901",
      },
      ['Battlefront 2 Fleet Props v2a'] = {
        Description = "Venator, Acclamator and Providence",
        Guidelines = "Spawn these ships as props in the air above battles, use them over vehicles when possible.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1529901430",
      },
      ['BTL-B Y-Wing'] = {
        Description = "The BTL-B Y-Wing bomber",
        Guidelines = "Give these to bomber pilots (Impact)",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1713950767",
      },
      ['ETA-2 Interceptor'] = {
        Description = "The ETA-2 Jedi Interceptors",
        Guidelines = "Give these to pilot certified Jedi for air battles/transport.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1894908676",
      },
      ['Jedi Starfighters'] = {
        Description = "The Jedi Starfighters using LFS (ETA-2 and Delta-7)",
        Guidelines = "Give these to pilot certified Jedi for air battles/transport.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1580175017",
      },
      ['HMP Droid Gunship'] = {
        Description = "The CIS HMP Droid Gunship",
        Guidelines = "Use these over Vultures when lag is an issue (much more HP so less amount of droids)",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1723252181",
      },
      ['Hyena-class Bomber'] = {
        Description = "The CIS Hyena-class Bomber",
        Guidelines = "Use these for big aerial space combat. Can be cancer with player bombings.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1739279660",
      },
      ['[TW] Vehicles'] = {
        Description = "Large vehicle pack by Deno, should be added when using ships (required content)",
        Guidelines = "Add this addon when using LFS ships",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1959895851",
      },
      ['[TW] Additional Ships'] = {
        Description = "Large vehicle pack by Galen, most pilot regiment ships and random ships are here",
        Guidelines = "Add this addon for most air battles, avoid overspawning ships.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1423892109",
      },
    },
    ['Vehicles'] = {
      ['AV-7 Antivehicle Cannon'] = {
        Description = "The AV-7 Antivehicle Cannon",
        Guidelines = "Spawn this when big bombings are needed. Shouldn't be added very often.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "930396962",
      },
      ['AAT'] = {
        Description = "The CIS AAT",
        Guidelines = "Spawn this as an enemy tank. Has its own AI for shooting.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1944228375",
      },
      ['BARC speeder'] = {
        Description = "The Republic BARC Speeder + Medical BARC",
        Guidelines = "Spawn these for small transports and recon. Do not overspawn.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "2013167925",
      },
      ['IG-227 Hailfire-class droid tank'] = {
        Description = "The CIS Hailfire-class droid tank",
        Guidelines = "Player controlled CIS Tank. Do not overspawn.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "2014672223",
      },
      ['MTT'] = {
        Description = "The CIS MTT",
        Guidelines = "Player controlled CIS MTT. Used for droid transport and has animations.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "2024979336",
      },
      ['NR-N99 Tank Droid'] = {
        Description = "The CIS Snail Tank",
        Guidelines = "Player controlled CIS Snail Tank. Do not overspawn.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "2014029867",
      },
      ['TX-130'] = {
        Description = "The Republic TX-130",
        Guidelines = "Tank used by players. Useful as heavy artillery and blowing stuff up.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1952443043",
      },
      ['AT-TE'] = {
        Description = "The Republic AT-TE",
        Guidelines = "Tank/transport used by players. Useful as heavy artillery and blowing stuff up.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "2061996588",
      },
      ['AT-RT'] = {
        Description = "The Republic AT-RT",
        Guidelines = "Scout vehicles for republic players. Do not overspawn.",
        Rules = "Keep these ships at a minimum, they can be laggy.",
        Addon = "1406438579",
      },
      ['Ship prop pack'] = {
          Description = "Testing",
          Guidelines = "Testing",
          Rules = "testing",
          Addon = "2332782456",
      },
    },
    ['Player/NPC Models'] = {
      ['General Grievous'] = {
        Description = "General Grievous playermodel",
        Guidelines = "Special event character. Only use with high up permission.",
        Rules = "Use these models for actors/npcs",
        Addon = "705124288",
      },
      ['Heavy Combine'] = {
        Description = "Heavy Combine player and npc models",
        Guidelines = "Use as an alternative to CIS. Widely used as both player and npc enemies.",
        Rules = "Use these models for actors/npcs",
        Addon = "188562859",
      },
      ['SWTOR: Undead'] = {
        Description = "SWTOR's Undead pack. Many weird models",
        Guidelines = "Use these to model actors, dark users, bounty hunters, whatever.",
        Rules = "Use these models for actors/npcs",
        Addon = "1411777865",
      },
      ['EG-5 Jedi Hunter Droid'] = {
        Description = "The Jedi Hunter Droid",
        Guidelines = "Playermodel used for actors. Use this for Jedi enemies.",
        Rules = "Use these models for actors/npcs",
        Addon = "668821867",
      },
      ['CIS B2 Droid'] = {
        Description = "CIS B2 Droids made by OkFellow",
        Guidelines = "B2 Droids, heavier/more armored. Used a lot.",
        Rules = "Use these models for actors/npcs",
        Addon = "1613615135",
      },
      ['CIS B1 Droid'] = {
        Description = "CIS B1 Droids made by OkFellow",
        Guidelines = "B1 Droids, lighter/expendable. Used the most for NPCs",
        Rules = "Use these models for actors/npcs",
        Addon = "1898215773",
      },
      ['CIS Commando Droid'] = {
        Description = "CIS Commando Droids made by OkFellow",
        Guidelines = "Commando Droids, elite/hard to kill. Used a decent amount for hard objectives.",
        Rules = "Use these models for actors/npcs",
        Addon = "1894647095",
      },
      ['CIS Tactical Droid'] = {
        Description = "CIS Tactical Droids made by OkFellow",
        Guidelines = "Tactical Droids, smart/strategist. Used a decent amount for hard objectives.",
        Rules = "Use these models for actors/npcs",
        Addon = "1470836967",
      },
      ['Deathwatch'] = {
        Description = "Deathwatch Mandalorians made by OkFellow",
        Guidelines = "Mandalorian enemies. Not used too much.",
        Rules = "Use these models for actors/npcs",
        Addon = "2040309290",
      },
      ['Sons of Dathomir'] = {
        Description = "Darth Maul and Savage models by OkFellow, Plo Cool and Ace",
        Guidelines = "Use these models for player actors. Need high up permission.",
        Rules = "Use these models for actors/npcs",
        Addon = "2142029112",
      },
    }
  }
}