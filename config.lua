
return {

    debug = false, -- show zone boundary

    payPeriod = 10, -- time in minutes to receive money when in zone

    socialZones = {
        {
            name = 'BurgerShot', -- appears as notification title
            icon = 'burger', -- notification icon
            iconColor = '#b17214e5', -- notification icon colour
            payAmount = 500, -- payment per tick
            points = {
                vector2(-1198.18, -914.21),
                vector2(-1218.04, -890.05),
                vector2(-1177.1691, -863.11),
                vector2(-1157.49, -893.42)              
            },
            minZ = 10.0,
            maxZ = 20.0,
        },
        {
            name = 'Legion Square Car Park', -- appears as notification title
            icon = 'warehouse', -- notification icon
            iconColor = '', -- notification icon colour
            payAmount = 110, -- payment per tick
            points = {
                vector2(199.1045, -806.4117),
                vector2(243.4202, -822.5151),
                vector2(277.9434, -738.6096),
                vector2(222.0008, -717.9221),             
            },
            minZ = 30.00,
            maxZ = 45.0,
        },   
    }
    
}
