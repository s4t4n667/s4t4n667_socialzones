## Zone-based social payment system 💸👥

Specify zones in which players can earn money whilst socialising. Can adjust how often players get paid via the config.

## ✨ Features:
- Can define payment period, in minutes, for each zone separately
- Pay players with either `money` or `black_money`
- Option to disable paying dead players
- Locales: English, French & German

## 🔒 Dependencies:
- [ESX](https://github.com/esx-framework/esx_core), [QBCore](https://github.com/qbcore-framework) or [Qbox](https://github.com/Qbox-project/)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_inventory](https://github.com/overextended/ox_inventory)

## 🔗 Useful links:
- [Documentation](https://s4t4n667.gitbook.io/asgaard-developments/free-scripts/s4t4n667_socialzones)
- I recommend using [sd-zonecreator](https://github.com/Samuels-Development/sd-zonecreator) to help you create your zones

## ⚙️ How to install:
1) Download the latest release
2) Add `s4t4n667_socialzones` to your server's `resource` folder
3) Adjust the `config.lua` to your liking
4) Restart your server

## 📊 Resmon Count
0.00ms

## Zone example:
```lua
    {
        name = 'BurgerShot', -- notification title
        icon = 'burger', -- notification icon
        iconColor = '#b17214e5', -- notification icon colour
        payAmount = 500, -- payment per tick
        payPeriod = 10, -- how often payment is sent in minutes
        payNotify = true, -- whether there is a notification when payment is sent
        moneyType = 'money',
        points = {
            vector2(-1198.18, -914.21),
            vector2(-1218.04, -890.05),
            vector2(-1177.1691, -863.11),
            vector2(-1157.49, -893.42),
            vector2(-1183.9269, -909.3953),
            vector2(-1185.7928, -906.3600),            
        },
        minZ = 10.0,
        maxZ = 20.0,
    },
```

## 📌 Asgaard Developments
I’m a solo FiveM developer creating scripts, custom clothing, logos and graphics, liveries, MLO retextures and Discord servers. Lots of different packages available, along with plenty of free assets and scripts for the community to enjoy. 

Join the Discord: [here](https://discord.gg/eFsB5ZFxeq)
